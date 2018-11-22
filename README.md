# Markdown to html/pdf 

## This is a demo for machine to machine bitcoin [lightning payments](https://en.wikipedia.org/wiki/Lightning_Network)

This app exposes HTTP endpoints to convert markdown files to HTML or PDF after the client paid a lightning invoice.

This is a simple [Sinatra.rb app](http://sinatrarb.com/) that uses the [rack-lightning middleware](https://github.com/bumi/rack-lightning) to handle lightning invoices.

Have a look at the server code: 

* [config.ru](https://github.com/bumi/ln-markdown-to-pdf/blob/master/config.ru#L9) - where the magic happens: loading the lightning middleware
* [converter.rb](https://github.com/bumi/ln-markdown-to-pdf/blob/master/converter.rb) - the actual sinatra app (no lightning related code in here; all handled by the middleware)

Usage details about the [rack lightning middleware can be found here](https://github.com/bumi/rack-lightning)

## API endpoints

The application is deployed on [https://lightning-2pdf.herokuapp.com](https://lightning-2pdf.herokuapp.com) and exposes the following endpoints:

### /convert/pdf

converts markdown in the request body to PDF and returns the PDF file content

### /convert/html

converts the markdown in the request body to HTML and returns the html file content


## Client

The API client uses faraday and the faraday_ln_paywall middleware to automatically pay the lightning invoice for every request.

Have a look at the [code in client.rb](https://github.com/bumi/ln-markdown-to-pdf/blob/master/client.rb) and have a look at the [faraday lightning middleware](https://github.com/bumi/faraday_ln_paywall#readme)

### Usage:

    $ ruby client.rb [path to markdown file] [format]
    $
    $ # example:
    $ ruby client.rb ./README.md html

The client is using default lnd settings and loads `~/.lnd/data/chain/bitcoin/testnet/admin.macaroon` and `~/.lnd/tls.cert`
You can configure that in the [faraday middleware](https://github.com/bumi/ln-markdown-to-pdf/blob/master/client.rb#L7). ([documentation](https://github.com/bumi/faraday_ln_paywall#configuration))

## Questions?

Please let me know if you have any questions and I'd love to hear feedback and your ideas on this: hello@michaelbumann.com   
more contact details on my website: [michaelbumann.com](http://michaelbumann.com)


## What is the Lightning Network?

The [Lightning Network](https://en.wikipedia.org/wiki/Lightning_Network) allows to send real near-instant microtransactions with extremely low fees. 
It is a second layer on top of the Bitcoin network (and other crypto currencies). 
Thanks to this properties it can be easily used for automated machine to machine payments.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

