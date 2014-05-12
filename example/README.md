# Simulacrum Example App

Run the web server;

1. `bundle install`
2. `cd ./public`
3. `python -m SimpleHTTPServer 8000`

Then in a new terminal window;

2. `BROWSERSTACK_USERNAME=yourusername BROWSERSTACK_APIKEY=yourapikey rake simulacrum:spec`
