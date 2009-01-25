# The kingsnake class will need to be turned into a module to be included into the
# ActiveRecord class to mixin these methods.
# class Product < ActiveRecord::Base
#   include PostOMatic::KingSnake
# end
module PostOMatic
  require 'rubygems'
  require 'mechanize'
  require 'hpricot'

  module KingSnake
    USERNAME = 'prehistoricpets'
    PASSWORD = 'pimbura1'
    URLS = {
      :login                      => 'http://market.kingsnake.com/login.php',
      :adoptions                  => 'http://market.kingsnake.com/list.php?cat=10',
      :ball_pythons               => 'http://market.kingsnake.com/list.php?cat=32',
      :pythons                    => 'http://market.kingsnake.com/list.php?cat=7',
      :tree_boas                  => 'http://market.kingsnake.com/list.php?cat=33',
      :boa_constrictors           => 'http://market.kingsnake.com/list.php?cat=8',
      :other_boas                 => 'http://market.kingsnake.com/list.php?cat=62',
      :rose_rubber_and_sand_boas  => 'http://market.kingsnake.com/list.php?cat=61',
      :new_world_rat_snakes       => 'http://market.kingsnake.com/list.php?cat=60',
      :old_world_rat_snakes       => 'http://market.kingsnake.com/list.php?cat=64',
      :corn_snakes                => 'http://market.kingsnake.com/list.php?cat=65',
      :gray_banded_kingsnakes     => 'http://market.kingsnake.com/list.php?cat=29',
      :other_kings_and_milksnakes => 'http://market.kingsnake.com/list.php?cat=59',
      :other_snakes               => 'http://market.kingsnake.com/list.php?cat=6'
    }

    def post_ad(options = {}) # options = { :ad_duration => '5 days' }
      @agent = WWW::Mechanize.new
      page   = login
      page   = submit_ad(page)
      puts page.inspect
    end

  private
    def login
      page          = @agent.get(URLS[:login])
      form          = page.forms[1]
      form.username = USERNAME
      form.passwd   = PASSWORD
      page          = @agent.submit(form)
    end

    def submit_ad(page)
      page          = @agent.get(URLS[:other_snakes]) # URLS[self.category.to_sym]
      form          = page.forms[1]
      return false if form.nil?
      form.subject  = name
      form.descript = description
      form.imageurl = "http:/prehistoricpets.com/products/#{to_param}.jpg"
      # page        = form.submit # works
      validate_post_success(form)
    end

    def validate_post_success(page)
      # if page.something_on_the_page.eql?('bla bla bla')
      #   return true
      # else
      #   return false
      # end
      "eff holed"
      return true
    end
  end
end
# class Product
#   include PostOMatic::KingSnake
#   attr_accessor :name, :description, :imageurl
# 
#   def initialize
#     @name = "Awesome Ball Python"
#     @description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
#   end
# 
#   def category
#     "ball_pythons"
#   end
# 
#   def name
#     @name
#   end
# 
#   def description
#     @description
#   end
# 
#   def to_param
#     name
#   end
# end
# p = Product.new
# puts p.post_ad