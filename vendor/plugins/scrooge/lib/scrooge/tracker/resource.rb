module Scrooge
  module Tracker
    class Resource < Base
      
      # A Resource tracker is scoped to a
      #
      # * controller
      # * action
      # * request method
      # * content type
      #
      # and is a container for any Models referenced during the active
      # request / response cycle.
      
      GET = /get/i
      
      GUARD = Monitor.new
            
      attr_accessor :controller,
                    :action,
                    :method,
                    :format,
                    :models,
                    :is_public     
      
      def initialize
        super()
        @models = Set.new
        yield self if block_given?
      end

      # Merge this Tracker with another Tracker for the same resource ( multi-process / cluster aggregation ) 
      #      
      def merge( other_resource )
        return unless other_resource
        models.merge( other_resource.models )
        models.each do |model|
          model.merge( other_resource.model( model ) )
        end
      end

      # Has any Models been tracked ? 
      #
      def any?
        GUARD.synchronize do
          !@models.empty?
        end  
      end

      # Is this a public ( not authenticated ) resource ?
      #
      def public?
        @is_public == true
      end
      
      # Is this a private ( authenticated ) resource ?
      #      
      def private?
        !public?
      end
      
      # Search for a given model instance
      #
      def model( model )
        models.detect{|m| m.name == model.name }
      end
      
      # Generates a signature / lookup key.
      #
      def signature
        @signature ||= "#{controller.to_s}_#{action.to_s}_#{method.to_s}_#{private_or_public}"
      end
      
      # Only track GET requests
      #
      def trackable?
        !( method || '' ).to_s.match( GET ).nil?
      end
      
      # Add a Model to this resource.
      #
      def <<( model )
        GUARD.synchronize do
          @models << track_model_from( model )
        end
      end
      
      def marshal_dump #:nodoc:
        GUARD.synchronize do
          { signature => { :controller => @controller,
                           :action => @action,
                           :method => @method,
                           :format => @format,
                           :models => dumped_models(),
                           :is_public => @is_public } }
        end
      end      
      
      def marshal_load( data ) #:nodoc:
        GUARD.synchronize do
          data = data.to_a.flatten.last
          @controller = data[:controller]
          @action = data[:action]
          @method = data[:method]
          @format = data[:format]
          @models = restored_models( data[:models] )
          @is_public = data[:is_public]
          self
        end  
      end
      
      # Yields a collection of Rack middleware to scope Model attributes to the
      # tracked dataset.
      #
      def middleware
        @middleware ||= begin
          GUARD.synchronize do
            models.map do |model|
              model.middleware( self )
            end
          end  
        end
      end      

      def inspect #:nodoc:
        "#<#{@method.to_s.upcase} #{private_or_public} :#{@controller}/#{@action} (#{@format})\n#{models_for_inspect()}"
      end
      
      private
      
        def private_or_public #:nodoc:
          @is_public ? 'public' : 'private'
        end
      
        def track_model_from( model ) #:nodoc:
          model.is_a?( Array ) ? model_from_enumerable( model ) : setup_model( model )
        end
      
        def model_from_enumerable( model ) #:nodoc:
          model, attribute = model
          model = setup_model( model )
          model << attribute
          model
        end
      
        def models_for_inspect #:nodoc:
          models.map{|m| " - #{m.inspect}" }.join( "\n" )
        end
      
        def dumped_models #:nodoc:
          GUARD.synchronize do
            @models.to_a.map{|m| m.marshal_dump }
          end
        end
        
        def restored_models( models ) #:nodoc:
          GUARD.synchronize do
            models.map do |model|
              m = model.keys.first # TODO: cleanup
              Model.new( m ).marshal_load( model )
            end.to_set
          end  
        end
        
        def setup_model( model ) #:nodoc:
          GUARD.synchronize do
            if model.is_a?( Scrooge::Tracker::Model )
              model
            else
              model_for( model ) || Scrooge::Tracker::Model.new( model )
            end
          end       
        end
      
        def model_for( model ) #:nodoc:
          @models.detect{|m| m.model.name == model.name }
        end
      
    end
  end
end