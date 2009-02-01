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
      page          = @agent.get(URLS[self.category.to_sym]) # URLS[self.category.to_sym]
      form          = page.forms[1]
      return false if form.nil?
      form.subject  = name
      form.descript = description
      # form.imageurl = "http:/prehistoricpets.com/products/#{to_param}.jpg" # is this breaking it when I try to post?
      page          = form.submit
      validate_post_success(page)
    end

    def validate_post_success(page)
      if page.title =~ /Thank You/
        return true
      else
        return false
      end
    end
  end
end
# Keep this for testing:
class Product
  include PostOMatic::KingSnake
  attr_accessor :name, :description, :imageurl

  def initialize
    @name = "Test"
    @description = "This is a test."
  end

  def category
    "venomous"
  end

  def name
    @name
  end

  def description
    @description
  end

  def to_param
    name
  end
end
p = Product.new
puts p.post_ad