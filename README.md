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

[sinatra]: http://www.sinatrarb.com
[everlater]: http://everlater.com
[solo]: http://engineyard.com/solo
