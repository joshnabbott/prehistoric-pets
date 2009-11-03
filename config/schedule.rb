set :path, '/var/www/prehistoricpets/current'

every 1.day, :at => '2:00am' do
  command "RAILS_ENV=production FILEPATH=/home/deploy/backups /usr/bin/ruby #{RAILS_ROOT}/script/dbdump --include-password"
end

every 1.week, :at => '1:00am' do
  rake 'prehistoric_pets:db:prune_orders'
  rake 'prehistoric_pets:images:prune'
end

# Search
every 4.hours do
  rake 'thinking_sphinx:index'
end

every 1.day, :at => '2:30am' do
  rake 'thinking_sphinx:stop'
end

every 1.day, :at => '2:31am' do
  rake 'thinking_sphinx:start'
end

# PostOMatic

# Ball Pythons 4am 5am 6am
every 1.day, :at => '4 am' do
  rake 'post_o_matic:kingsnake:post["Ball Pythons"]'
end

every 1.day, :at => '5 am' do
  rake 'post_o_matic:kingsnake:post["Ball Pythons"]'
end

every 1.day, :at => '6 am' do
  rake 'post_o_matic:kingsnake:post["Ball Pythons"]'
end

# Pythons 4am 5am 6am
# Tree Boas/Pythons 3am 5am 7am
# Boa Constrictors 4am 5am 6am
# Rosy, Sand, & Rubber Boas 3am 6am 7am
# Other Boas 3am 7am 8am
# New World Rat Snakes 3am 6am 7am
# Old World Rat Snakes 3am 6am 7am
# Corn Snakes 4am 5am 6am
# Gray-Banded Kingsnakes 3am 8am 9am
# Other Kingsnakes & Milk Snakes 3am 6am 9am
# Other Snakes 4am 5am 6am
# 
# 
# Bearded Dragons 4am 5am 6am
# Chameleons 3am 6am 7am
# Geckos  3am 7am 9am
# Leopard Geckos 3am 7am 9am
# Lizards 4am 6am 8am
# Monitors & Tegus 4am 5am 6am
# 
# 
# Spiders & Other Inverts 3am 7am 9am
# Tortoises 4am 6am 8am
# Turtles4am 7am 9am
# 
# European Ads
# 
# Snakes 10pm 11pm 12am
# Lizards 10pm 11pm 12am
# 
# Canadian Ads
# 
# Snakes 3am 5am 7am
# Lizards 3am 5am 7am