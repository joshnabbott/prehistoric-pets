namespace :post_o_matic do
  namespace :kingsnake do
    desc 'Post the first Post-O-Matic Postings for the category listed.'
    task :post, :category_name, :needs => :environment do |task, args|
      time = Benchmark.measure do
        category_name = args.category_name
        category      = PostOMaticCategory.find(:first, :conditions => ['name = ?', category_name])

        # If there's no category by this name, just exit
        unless category
          puts "Post-O-Matic Category #{category_name} doesn't exist"
          exit 0
        end

        # Get the first three postings that that have a scheduled state and have an active product associated
        postings = category.post_o_matic_postings.scheduled.find(:all, :include => :product, :conditions => ['products.is_active = ?', true], :limit => 1)
        # postings = category.post_o_matic_postings.scheduled.find(:all, :include => :product, :conditions => ['products.is_active = ?', true], :limit => 3)
        # Exit unless we have postings to deal with
        unless postings
          puts "No postings for this category (#{category_name})"
          exit 0
        end

        # Post the ads
        postings.each do |posting|
          puts "Posted #{posting.product.name} to #{category_name}" if posting.post_ad
        end
      end

      # Tell them what happened.
      puts "Done in %.4fs" % time.real
    end
  end
end