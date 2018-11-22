# Markdown to html/pdf 

## An lightning API payments example

## API endpoints

### /convert/pdf

converts markdown in the request body to PDF and returns the PDF file content

### /convert/html

converts the markdown in the request body to HTML and returns the html file content


## Client

### Usage:

    $ ruby client.rb [path to markdown file] [format]
    $
    $ # example:
    $ ruby client.rb ./README.md html

