# Markdown to html/pdf 

## This is a demo for machine to machine bitcoin [lightning payments](https://en.wikipedia.org/wiki/Lightning_Network)

This app exposes HTTP endpoints to convert markdown files to HTML or PDF after the client paid a lightning invoice.

This is a simple [Sinatra.rb app](http://sinatrarb.com/) that uses the [rack-lightning middleware](https://github.com/bumi/rack-lightning) to handle lightning invoices.


## How does it work? 

1. If no proof of payment is provided the rack lightning middleware creates a Lightning invoice and returns a `402 Payment Required` HTTP status code with a `application/vnd.lightning.bolt11` content type header and a Lightning invoice as a body. 
2. The client pays the invoice and does a second request providing the proof of payment / the preimage of the Lightning
payment in a `X-Preimage` header. 
3. Now the lightning middleware checks the if the invoice was paid and proceeds to the sinatra app doing the convertion.

Have a look at the server code: 

* [config.ru](https://github.com/bumi/ln-markdown-to-pdf/blob/master/config.ru#L9) - where the magic happens: loading the lightning middleware
* [converter.rb](https://github.com/bumi/ln-markdown-to-pdf/blob/master/converter.rb) - the actual sinatra app (no lightning related code in here; all handled by the middleware)

Usage details about the [rack lightning middleware can be found here](https://github.com/bumi/rack-lightning)

## Requirements

Server and client are using connecting (gRPC) to the [Lightning Network Daemon(lnd)](https://github.com/lightningnetwork/lnd/) to create and pay invoices..
A running node with funded channels is required. Details about lnd can be found on their [github page](https://github.com/lightningnetwork/lnd/)


### Video Demo

I've made a [video](https://vimeo.com/302338717) giving an overview of the setup and showing how it works: [https://vimeo.com/302338717](https://vimeo.com/302338717)


## API endpoints

The application is deployed on [https://lightning-2pdf.herokuapp.com](https://lightning-2pdf.herokuapp.com) and connected
to the [lightning node on 79.137.71.183](https://1ml.com/testnet/node/038474ec195f497cf4036e5994bd820dd365bb0aaa7fb42bd9b536913a1a2dcc9e)

The following endpoints are available:

### /convert/pdf

converts markdown in the request body to PDF and returns the PDF file content

### /convert/html

converts the markdown in the request body to HTML and returns the html file content


## Client

**requirements:** you need a running lnd node with funded, open channels. Check the [lnd github page](https://github.com/lightningnetwork/lnd/#readme) for information about lnd.

The API client uses the [faraday HTTP library](https://github.com/lostisland/faraday) and the [faraday_ln_paywall middleware](https://github.com/bumi/faraday_ln_paywall) to automatically pay the lightning invoice for every request.

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

