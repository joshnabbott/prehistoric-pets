namespace :post_o_matic do
  namespace :kingsnake do
    desc 'This will post the first PostOMaticPosting in each PostOMaticCategory to market.kingsnake.com'
    task :post => :environment do
      PostOMaticCategory.all.each do |post_o_matic_category|
        next if post_o_matic_category.post_o_matic_postings.count == 0
        puts "Posting to #{post_o_matic_category.name} -> #{post_o_matic_category.url}"
        posting = PostOMaticPosting.scheduled.find_by_post_o_matic_category_id(category.id)
        next unless posting.product.is_active
        puts posting.post_ad
      end
    end
  end
end