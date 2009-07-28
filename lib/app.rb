module EY
  module Solo
    module Rack
      class Redirect
        def call(env)
          parts = env['SERVER_NAME'].split('.')
          p1, p2 = parts.pop, parts.pop

          destination  = "#{env['rack.url_scheme']}://www.#{p2}.#{p1}"
          destination << "#{env['PATH_INFO']}"
          destination << "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].empty?

          [302, {'Location' => destination}, ['See Ya!']] 
        end
      end
    end
  end
end
