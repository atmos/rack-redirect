rack-redirect
=============
More and more of my friends are deploying on [Engine Yard Solo][solo] and I
keep getting asked for help.  My friends at [everlater][everlater] wanted every
incoming request for *.everlater.com to go to www.everlater.com.  Here's a
little app that you can deploy on solo to handle all the weird HTTP_HOST
variants your app might 404 on.

Installation
============

    % git clone git://github.com/atmos/rack-redirect.git
    % ... (modify if needed) ...


Deployment
==========
Check the included config.ru

testing
=======

Just run rake...

    rack-redirect
      - redirects from http://example.org to http://www.example.org/
      - redirects from http://alpha.example.com to http://www.example.org/
      - redirects from http://example.org/nate to http://www.example.org/nate
      - redirects from http://example.org/nate?trip_id=42 to http://www.example.org/nate?trip_id=42


[sinatra]: http://www.sinatrarb.com
[everlater]: http://everlater.com
[solo]: http://engineyard.com/solo
