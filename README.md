# Dealing with documents and text - techniques, tools and tips

This repository contains resources related to dealing with documents as a journalist. Typical challenges include:

* Scraping multiple documents published online
* 'Batch downloading' multiple documents for offline analysis
* Converting documents into searchable text
* Dealing with scanned documents (OCR)
* Searching across multiple documents
* Identifying patterns in documents
* Identifying entities in documents (people, places, organisations, dates and times)
* Organising documents
* Publishing documents
* Matching names referred to in different ways in different documents

## Tools for dealing with documents

Some useful tools to know about include:

* [Tabula](https://tabula.technology/) (for extracting tables from documents)
* [OutWit Hub](https://www.outwit.com/#hub) (for batch downloading documents - only available in Pro version)
* [Atom](https://atom.io/) (text editor - for using regex for searching across multiple documents)
* [DocumentCloud](https://www.documentcloud.org/) (entity extraction and OCR)
* [Overview](https://www.overviewdocs.com/) (identify links across documents, search and visualise)
* [Pinpoint](https://journaliststudio.google.com/pinpoint/about) "helps reporters quickly go through hundreds of thousands of documents by automatically identifying and organizing the most frequently mentioned people, organizations and locations. Instead of asking users to repeatedly hit “Ctrl+F,” the tool helps reporters use Google Search and Knowledge Graph, optical character recognition and speech-to-text technologies to search through scanned PDFs, images, handwritten notes, e-mails and audio files."
* [Datashare](https://datashare.icij.org/) from the ICIJ for extracting text from documents and searching them. [User Guide here](https://icij.gitbook.io/datashare/)
* [Open Semantic Search](https://www.opensemanticsearch.org/) is "Free Software for your own Search Engine, Explorer for Discovery of large document collections, Media Monitoring, Text Analytics, Document Analysis & Text Mining platform"
* [Aleph](https://aleph.occrp.org/) is "A tool for indexing large amounts of both documents (PDF, Word, HTML) and structured (CSV, XLS, SQL) data for easy browsing and search. It is built with investigative reporting as a primary use case. Aleph allows cross-referencing mentions of well-known entities (such as people and companies) against watchlists, e.g. from prior research or public datasets." [Read the documentation on GitHub](https://github.com/alephdata/aleph)
* [The Archive Network](https://thearchive.network/) - for creating personal and publishable archives, handles filetypes such as emails etc. Currently in closed beta.
* [Evernote](https://evernote.com/) (organisation, sharing, OCR and tagging)
* Programming languages open up other ways of dealing with text. For example, you can search documents using **command line** and **regex**, convert PDFs in **Python** using the library `pdftoxml`, or use tools like sentiment analysis and Natural Language Processing (NLP). The free ebook [Text Mining With R](https://www.tidytextmining.com/) explains some techniques.
* [CSV Match](https://github.com/maxharlow/csvmatch) is one tool for fuzzy matching.
* [Pandoc](https://pandoc.org/getting-started.html) is a command line tool for converting, combining, and doing other stuff with documents

Other tools are bookmarked at [https://pinboard.in/u:paulbradshaw/t:text+tools](https://pinboard.in/u:paulbradshaw/t:text+tools)

## Useful concepts

* A `diff` compares documents and shows the differences
* `Regex` (regular expression) is a way of describing the pattern in a passage of text (e.g. 2 digits followed by a non-numerical character, followed by two digits...)
* **Sentiment analysis** attempts to gauge whether a word or passage of text is positive or negative (used in [this story](https://www.washingtonpost.com/investigations/whistleblowers-say-usaids-ig-removed-critical-details-from-public-reports/2014/10/22/68fbc1a0-4031-11e4-b03f-de718edeb92f_story.html) along with `diff`)
* **Entity extraction** attempts to identify and classify entities in a document, such as people, places, organisations, and times and dates.
* **OCR** (Optical Character Recognition) attempts to convert images and scanned documents into text that can be searched etc. Google Images, for example, includes OCR so that you can search for images of specific licence plates, signs etc.
* **Fuzzy matching** allows you to match different text where they are not exactly the same, e.g. names spelt or arranged slightly differently in different documents.
* **Ngrams** [are](https://en.wikipedia.org/wiki/N-gram) "a contiguous sequence of n items from a given sample of text or speech". In other words, a group of words that occur together (e.g. "police investigated", "investigated a") rather than a single word. The 'n' means 'any number' but related terms like **bigrams** (two word pairs) and **trigrams** (three word strings) specify the number of words involved.
* **Topic modeling** is a way of categorising or organising documents by shared features in the text. For example you might have a collection of medical reports but need to know what they're about. Topic modeling might identify one cluster which tends to use one vocabulary (operation, incision, surgeon) and another which uses a different cluster of words (consultation, appointment, advised). This can help you to identify the group of documents you need to focus on.

## Guides and tutorials

* [This tutorial explains how to count multiple tags in a text column in Excel and Atom](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/tagsexample.md)
* [This tutorial explains how to use Datashare to create a document database and perform entity extraction](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/datasharehowto.md)
* [This Python notebook shows how to use regex and ngrams with speeches](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/regexNgramsSpeeches.ipynb)
* [This Python notebook shows how to use topic modelling on tweets](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/topicModelling_DrWhoTweets.ipynb)
* [This thread talks about how to search multiple documents using Atom](https://discuss.atom.io/t/find-string-in-a-list-of-files/13269)
* [Fuzzy matching in SQL](http://www.padjo.org/tutorials/databases/sql-fuzzy/)
* [Find connections with fuzzy matching](https://github.com/maxharlow/tutorials/tree/master/find-connections-with-fuzzy-matching)
* [Text Mining With R](https://www.tidytextmining.com/) includes ngram extraction, topic modeling and sentiment analysis

## Sources of text to work with

* Many political assemblies publish transcripts. In the UK [Hansard is the official record of all debates](https://hansard.parliament.uk/), and it offers HTML downloads, as well as [an API](https://api.parliament.uk/historic-hansard/api). [TheyWorkForYou](https://www.theyworkforyou.com/) provides the same data with [an API](https://www.theyworkforyou.com/api/).
* Most political speeches and statements are published by the Government or political parties. Examples include [Council of Europe speeches](https://www.coe.int/en/web/portal/speeches), the [European Parliament](https://www.europarl.europa.eu/plenary/en/debates-video.html#sidesForm), the [Parliament of India](https://eparlib.nic.in/handle/123456789/7), and [Gov.uk's news and communication](https://www.gov.uk/search/news-and-communications)
* The Chilcott Inquiry published [over 150 witness transcripts](https://webarchive.nationalarchives.gov.uk/20171123123302/http://www.iraqinquiry.org.uk/the-evidence/witness-transcripts/)
* [Submissions to the Cairncross Review (98 documents)](https://www.documentcloud.org/public/search/projectid:%2048718-cairncrossreview%20%20) - download them from the [call for submissions](https://www.gov.uk/government/consultations/call-for-evidence-on-sustainable-high-quality-journalism-in-the-uk)
* Companies House [publishes bulk data files of company accounts](http://download.companieshouse.gov.uk/en_accountsdata.html). These are in XBRL format (.html file extension) XBRL format (.xml file extension). The file names include the company number and filing date. Use command line to navigate to the folder and create a spreadsheet of the filenames using `ls > filenames.csv` then extract and filter by company number, filing date (`=RIGHT(SUBSTITUTE(SUBSTITUTE(A2,".html",""),".xml",""),8)`) and filetype. 
* There's some scraped IOPC recommendations in [this folder](https://github.com/paulbradshaw/dealingwithdocuments/tree/master/iopcreports)
