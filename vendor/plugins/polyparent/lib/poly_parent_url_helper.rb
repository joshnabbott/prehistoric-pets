# The entire purpose of this module is to call "flatten" on the array passed into either 'polymorphic_url'
# or 'url_for'. The problem is that when using the @parents instance variable provided with PolyParent
# you end up with a multi-dimensional array which will result in an error similar to
# 'Undefined method: array_image_path'
# Flatten the array and it *should* work.
module PolyParent
  module UrlHelper
    def polymorphic_url(record_or_hash_or_array, options = {})
      if record_or_hash_or_array.kind_of?(Array)
        record_or_hash_or_array = record_or_hash_or_array.compact.flatten
        record_or_hash_or_array = record_or_hash_or_array[0] if record_or_hash_or_array.size == 1
      end
      super
    end

    def url_for(options = {})
      options ||= {}
      options = options.flatten if options.is_a?(Array)
      super
    end
  end
end