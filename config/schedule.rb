set :path, '/var/www/prehistoricpets/current'

every 1.day, :at => '2:00am' do
  command "RAILS_ENV=production FILEPATH=/home/deploy/backups /usr/bin/ruby #{RAILS_ROOT}/script/dbdump --include-password | mail -s 'Prehistoric Database Backup' joshnabbott@gmail.com"
end

every 4.hours do
  rake 'thinking_sphinx:index'
  rake 'thinking_sphinx:restart'
end