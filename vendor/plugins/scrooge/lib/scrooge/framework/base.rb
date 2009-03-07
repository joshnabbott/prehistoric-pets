module Scrooge
  module Framework
    
    # Scrooge is framework agnostic and attempts to abstract the following :
    #
    # * current environment
    # * app root dir
    # * app tmp dir
    # * app config dir 
    # * logging    
    # * resource endpoints 
    # * caching
    # * injecting Rack MiddleWare 
    #
    # Framework Signatures 
    #
    # Scrooge will attempt to determine the current active framework it's deployed with
    # through various framework specific hooks.
    #
    # module Scrooge
    #    module Framework
    #      module YetAnother < Base
    #        ...
    #        signature do
    #          Object.const_defined?( "UnlikeAnyOther" )
    #        end
    #        ...
    #      end
    #    end
    #  end 
    
    autoload :Rails, 'scrooge/framework/rails'
    
    class Base < Scrooge::Base
      
      GUARD = Mutex.new
      
      SCOPE_REGEX = /\d{10}/.freeze
      
      CONFIGURATION_FILE = 'scrooge.yml'.freeze
      
      SCOPE_FILE = 'scope.yml'.freeze
      
      class NotImplemented < StandardError
      end
      
      class NoSupportedFrameworks < StandardError
      end
      
      class InvalidScopeSignature < StandardError
      end        
   
      # Per framework signature lookup.
      #        
      @@signatures = Hash.new( [] )
      @@signatures[self.name] = []
      
      # Support none by default.
      #
      @@frameworks = [] 
   
      class << self  
                
        # Registers a framework signature.
        #        
        def signature( &block )
          @@signatures[self.name] << block
        end  
        
        # All signatures for the current klass. 
        #
        def signatures
          @@signatures[self.name]
        end
        
        # All supported frameworks.
        #
        def frameworks
          @@frameworks
        end
        
        # Infer the framework Scrooge attaches to in a first yield manner.
        # A match of all defined signatures is required.
        #
        def which_framework?
          iterate_frameworks() || raise( NoSupportedFrameworks )
        end
        
        # Yield an instance of the current framework.
        #
        def instantiate
          which_framework?().new
        end
        
        private
        
          def inherited( subclass ) #:nodoc:
            @@frameworks << subclass
          end
        
          def iterate_frameworks #:nodoc:
            frameworks.detect do |framework|
              framework.signatures.all?{|sig| sig.call }
            end
          end  
                        
      end
      
      # The framework environment eg. test, development etc.
      #
      def environment
        raise NotImplemented
      end
      
      # Application root directory
      #
      def root
        raise NotImplemented  
      end
      
      # Application temp. directory
      #
      def tmp
        raise NotImplemented
      end      
      
      # Application configuration directory
      #
      def config
        raise NotImplemented
      end
      
      # Application logger instance.
      # API compat with stdlib Logger assumed.
      #
      def logger
        raise NotImplemented
      end
      
      # Supplement the current Resource tracker with additional environment context. 
      #
      def resource( env, request = nil )
        raise NotImplemented
      end
      
      # Write to the framework cache.
      #
      def write_cache( key, value )
        raise NotImplemented
      end
      
      # Read from the framework cache.
      #
      def read_cache( key )
        raise NotImplemented
      end 
      
      # Access to the framework's Rack middleware stack.
      #
      def middleware
        raise NotImplemented
      end
      
      # Inject scoping middleware. 
      #
      def install_scope_middleware( tracker )
        raise NotImplemented
      end
      
      # Inject tracking middleware.
      #
      def install_tracking_middleware
        raise NotImplemented
      end
      
      # Remove tracking middleware
      #
      def uninstall_tracking_middleware
        raise NotImplemented
      end
      
      # Register a code block to run when the host framework is fully initialized.
      #
      def initialized( &block )
        raise NotImplemented
      end
      
      # Yields a controller constant from a given Resource Tracker
      #
      def controller( resource )
        raise NotImplemented
      end
      
      # Retrieve all previously persisted scopes tracked with Scrooge. 
      #
      def scopes
        ensure_scopes_path do
          Dir.entries( scopes_path ).grep( SCOPE_REGEX )
        end  
      end
      
      # Determine if there's any previously persisted scopes.
      #
      def scopes?
        !scopes().empty?
      end
      
      # Return the scopes storage path for the current framework.
      #
      def scopes_path
        @scopes_path ||= File.join( config, 'scrooge', 'scopes' )
      end

      # Return the scopes storage path for a given scope and optional filename.
      #
      def scope_path( scope, filename = nil )
        path = File.join( scopes_path, scope.to_s )
        filename ? File.join( path, filename ) : path
      end
      
      # Log a message to the logger.
      #
      def log( message, flush = false )
        logger.info "[Scrooge] #{message}"
        flush_logger! if flush
      end
      
      # Persist the current tracker as scope or restore a previously persisted scope
      # from a given signature. 
      #
      def scope!( scope = nil )
        scope ? from_scope!( scope ) : to_scope!()
      end
      
      # Do we have a valid scope signature ?
      #
      def scope?( scope )
        scopes.include?( scope.to_s )
      end
      
      # Restore a previously persisted scope to the current tracker from a given 
      # signature.Raises Scrooge::Framework::InvalidScopeSignature if the signature
      # could not be found.
      #
      def from_scope!( scope )
        GUARD.synchronize do
          if scope?( scope )
            restore_scope!( scope )
          else
            raise InvalidScopeSignature
          end
        end    
      end
      
      # Dump the current tracker to the filesystem.
      #
      def to_scope!
        GUARD.synchronize do
          scope = Time.now.to_i
          dump_scope!( scope )
          scope.to_s
        end  
      end      
      
      # Full path the scrooge configuration file.
      #
      def configuration_file
        @configuration_file ||= File.join( config, CONFIGURATION_FILE )
      end
      
      private
       
       def flush_logger! #:nodoc:
         logger.flush if logger.respond_to?(:flush)
       end
       
       def restore_scope!( scope ) #:nodoc:
         tracker = Scrooge::Tracker::App.new
         tracker.marshal_load( scope_from_yaml( scope ) )
         tracker
       end
       
       def dump_scope!( scope ) #:nodoc:
         ensure_scope_path( scope ) do
           File.open( scope_path( scope, SCOPE_FILE ), 'w' ) do |io|
             scope_to_yaml( io )
           end
         end
       end
       
       def scope_from_yaml( scope ) #:nodoc:
         YAML.load( IO.read( scope_path( scope.to_s, SCOPE_FILE ) ) )
       end
       
       def scope_to_yaml( io ) #:nodoc:
         YAML.dump( Scrooge::Base.profile.tracker.marshal_dump, io )
       end 
       
       def ensure_scope_path( scope ) #:nodoc:
         makedir_unless_exist( scope_path( scope ) )
         yield if block_given?  
       end 
       
       def ensure_scopes_path #:nodoc:
         makedir_unless_exist( scopes_path )
         yield if block_given?
       end
           
      def makedir_unless_exist( path ) #:nodoc:
        FileUtils.makedirs( path ) unless File.exist?( path )
      end     
               
    end
  end
end