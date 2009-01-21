require 'erb'
require 'ftools'

# General settings
set :primary_domain, "lolmfao.com"
set :application, "prehistoricpets"
set :domain, "pp.lolmfao.com"
set :user, "joshnabbott"

# Apache settings
set :apache_ctl, "/etc/init.d/apache2"
set :vhost_template, "vhost.erb"

# GIT settings
set :scm, :git
set :local_repository, "#{user}@#{primary_domain}:/var/git/#{application}"
set :repository, "/var/git/#{application}"
set :deploy_to, "/var/www/#{application}"

role :app, primary_domain
role :web, primary_domain
role :db, primary_domain , :primary => true

set :runner, user

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :role => :app do; end
  end
end

namespace :apache do
  desc "Create vhost files for this domain."
  task :add_vhost, :roles => :web do
    set :apache_vhost_aconf, "/etc/apache2/sites-available/#{domain}"
    set :apache_vhost_econf, "/etc/apache2/sites-enabled/#{domain}"
    server_aliases = [ "www.#{domain}" ]
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
      mkdir -p -m 775 #{shared_path}/db &&
      mkdir -p -m 777 #{shared_path}/log
    CMD
  end
end

after 'deploy:setup' do
  shared::setup
  apache::add_vhost
  apache::reload
  sudo "chown -R #{user}:#{user} #{deploy_to}"
end