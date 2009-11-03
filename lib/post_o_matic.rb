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
      # true
      # Uncomment below to make posts to kingsnake.com
      @agent = WWW::Mechanize.new
      page   = login
      page   = submit_ad(page)
      validate_post_success(page) # returns true or false
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
      page          = @agent.get(self.post_o_matic_category.url)
      form          = page.forms[1]
      # Form would be nil if the max postings for the day have been reached.
      return false if form.nil?
      form.subject  = self.product.name
      form.descript = self.product.description
      # form.imageurl = "http:/prehistoricpets.com/products/#{self.product.to_param}.jpg" # is this breaking it when I try to post?
      page          = form.submit
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