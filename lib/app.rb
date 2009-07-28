module EY
  module Solo
    module Rack
      class Redirect
        attr_accessor :prefix
        def initialize(app, &block)
          @app = app
          @prefix = nil
          yield self if block_given?
        end

        def call(env)
          parts = env['SERVER_NAME'].split('.')
          p1, p2 = parts.pop, parts.pop

          destination  = "#{env['rack.url_scheme']}://#{@prefix}#{p2}.#{p1}"
          destination << "#{env['PATH_INFO']}"
          destination << "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].empty?

          [301, {'Location' => destination}, ['See Ya!']] 
        end
      end
    end
  end
end
