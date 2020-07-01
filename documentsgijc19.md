# Notes on dealing with documents and other unstructured data by @sarahcnyt #GIJC19

## Some tools

* DocumentCloud to extract names and dates - can download
* Overview to create piles of similar docs and tag
* Voyant to obtain a quick overview of docs
* IBC Watson/Amazon comprehend to extract characteristics of text
* DeDupe to standardise names and addresses

## Challenges: standardising lists

For example names, addresses, city and county names, similar tweets - that have all entered slightly differently

Strategies:
* Edit distance - how many letters need changing - fails miserably on short words
* Clustering - open refine
* Dictionaries - lists of correct answers and likely answers

## Video or audio

* Transcription
* image recognition
* tone

Strategies

* automatic transcription - Otter.ai and Trint
* OCR on chyrons
* Location matters - outdoors vs controlled setting, one voice or many
* Fairly sophisticated ML might be required at scale - get help

## Text problems

* Entity extraction
* Cluster - similar docs (k-means clustering is simple)
* Classify - topics of interest (Stick wih simple algorithms including logistic regression and naive Bayes - easier to see why and understand results. Pick a good random sample to start, expect to do it over and over)

## Finding patterns in docs

* Separate docs or 1 file:
  When provided with multiple files in one document, "it messes it up [what you can do]" treat every page as a document.
* Already searchable?
* A lot of boilerplate? Web page ads, sidebars, email sigs etc

Strategies

* Get it searchable (use DocumentCloud)
* If HTML pull out main body text and cleanse of code
* Somehow turn it into plain text and then...

When trying to find patterns in docs, try to convert to text, strip out repeated elements (e.g. email signatures) and code (e.g. HTML)

* Separate docs or 1 file:
  When provided with multiple files in one document, "it messes it up [what you can do]" treat every page as a document.
* Already searchable?
* A lot of boilerplate? Remove text from web page ads, sidebars, email sigs etc
