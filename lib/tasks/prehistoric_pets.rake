namespace :prehistoric_pets do
  namespace :images do
    desc 'Removes image records that are missing image files on the server'
    task :prune => :environment do
      time = Benchmark.measure do
        @records_deleted = 0
        Image.find_in_batches do |images|
          images.each do |image|
            unless image.has_image?
              image.destroy
              @records_deleted += 1
            end
          end
        end # find_in_batches
      end # Benchmark
      puts "Deleted #{@records_deleted} bad image records in %.4fs" % time.real
    end # prune
  end # images
end # prehistoric_pets