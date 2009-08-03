require 'erb'
require 'ftools'

# General settings
set :primary_domain, "208.64.71.88"
set :application, "prehistoricpets"
set :domain, "208.64.71.88"
set :user, "deploy"

# Apache settings
set :apache_ctl, "/etc/init.d/apache2"
set :vhost_template, "vhost.erb"

# GIT settings
set :scm, :git
set :repository, "git@github.com:joshnabbott/prehistoric-pets.git"
set :deploy_to, "/var/www/#{application}"
set :use_sudo, true

set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1


role :app, primary_domain
role :web, primary_domain
role :db, primary_domain , :primary => true

set :runner, user

after 'deploy:restart', 'deploy:symlink', 'deploy:update_crontab'

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |task|
    desc "#{task} task is a no-op with mod_rails"
    task task, :role => :app do; end
  end

  desc "Re-establish symlinks"
  task :symlink do
    run <<-CMD
      ln -sf #{shared_path}/db/sphinx #{release_path}/db/sphinx
      ln -sf #{shared_path}/log #{release_path}/log && 
      ln -sf /var/assets #{release_path}/public/assets
    CMD
  end

  desc "Stop the sphinx server"
  task :stop_sphinx, :roles => :app do
    sudo "cd #{current_path} && RAILS_ENV=production rake thinking_sphinx:stop"
  end

  desc "Start the sphinx server" 
  task :start_sphinx, :roles => :app do
    sudo "cd #{current_path} && RAILS_ENV=production rake thinking_sphinx:start"
  end

  desc "Restart the sphinx server"
  task :restart_sphinx, :roles => :app do
    stop_sphinx
    start_sphinx
  end

  desc 'Update crontab.'
  task :update_crontab, :roles => :app do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

namespace :apache do
  desc "Create vhost files for this domain."
  task :add_vhost, :roles => :web do
    set :apache_vhost_aconf, "/etc/apache2/sites-available/#{domain}"
    set :apache_vhost_econf, "/etc/apache2/sites-enabled/#{domain}"
    server_aliases = []
    set :apache_server_aliases, server_aliases
    File.rm(apache_vhost_aconf) if FileTest.exists?(apache_vhost_aconf)
    File.rm(apache_vhost_econf) if FileTest.exists?(apache_vhost_econf)
    file     = File.join(File.dirname(__FILE__), vhost_template)
    template = File.read(file)
    vhost    = ERB.new(template).result(binding)
    put vhost, apache_vhost_aconf, :mode => 0700
    put vhost, apache_vhost_econf, :mode => 0700
  end

  desc "Reload Apache"
  task :reload, :roles => :web do
    sudo "#{apache_ctl} reload"
  end
end

desc "A setup task to put shared system, log, and database directories in place"
namespace :shared do
  task :setup, :roles => :web do
    run <<-CMD
      mkdir -p -m 775 #{shared_path}/db && mkdir -p -m 777 #{shared_path}/db/sphinx &&
      mkdir -p -m 777 #{shared_path}/log &&
      mkdir -p -m 777 /var/assets
    CMD
  end
end

after 'deploy:setup' do
  sudo "chown -R #{user}:#{user} #{shared_path}"
  shared::setup
  apache::add_vhost
  apache::reload
  sudo "chown -R #{user}:#{user} #{deploy_to}"
end