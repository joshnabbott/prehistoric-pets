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
      :login => 'http://market.kingsnake.com/login.php',
      :ball_pythons => 'http://market.kingsnake.com/list.php?cat=32'
    }

    def post_ad(options = {}) # options = { :ad_duration => '5 days' }
      agent    = WWW::Mechanize.new
      page     = login(agent)
      page     = agent.get(URLS[:ball_pythons])
      page     = submit_ad(page)
      @page    = page
    end

    def page
      @page
    end

  private

    def get_my_form(page)
      page.forms[1]
    end

    def login(agent)
      page          = agent.get(URLS[:login])
      form          = page.forms[1]
      form.username = USERNAME
      form.passwd   = PASSWORD
      page          = agent.submit(form)
    end

    def submit_ad(page)
      form          = page.forms[1]
      form.subject  = name
      form.descript = description
      form.imageurl = imageurl
      form
      # page          = form.submit
    end
  end
end

class Product
  include PostOMatic::KingSnake
  attr_accessor :name, :description, :imageurl

  def initialize
    @name = "Awesome Ball Python"
    @description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @imageurl = "http://prehistoricpets.com/products/1-awesome-ball-python.jpg"
  end

  def name
    @name
  end

  def description
    @description
  end

  def imageurl
    @imageurl
  end
end
p = Product.new
puts p.post_ad.inspect