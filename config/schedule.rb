set :path, '/var/www/prehistoricpets/current'

every 1.day, :at => '2:00am' do
  command "RAILS_ENV=production FILEPATH=/home/deploy/backups /usr/bin/ruby #{RAILS_ROOT}/script/dbdump --include-password"
end

every 1.week, :at => '1:00am' do
  rake 'prehistoric_pets:images:prune'
end

# Search engine
every 4.hours do
  rake 'thinking_sphinx:index'
end

every 1.day, :at => '2:30am' do
  rake 'thinking_sphinx:stop'
end

every 1.day, :at => '2:31am' do
  rake 'thinking_sphinx:start'
end