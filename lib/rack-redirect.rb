require 'rack'

module Rack
  module EY
    module Solo
      class DomainRedirect
        attr_accessor :prefix
        def initialize(app, &block)
          @app = app
          @prefix = nil
          yield self if block_given?
        end

        def call(env)
          parts = env['SERVER_NAME'].split('.')
          suffix, chunk, prefix = parts.pop, parts.pop, parts.pop

          if prefix == @prefix
            @app.call(env)
          else
            prefix = @prefix ? "#{@prefix}." : ''
            destination  = "#{env['rack.url_scheme']}://#{prefix}#{chunk}.#{suffix}"
            destination << "#{env['PATH_INFO']}"
            destination << "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].empty?

            [301, {'Location' => destination}, ['See Ya!']] 
          end
        end
      end
    end
  end
end
