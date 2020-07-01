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
* [Datashare](https://datashare.icij.org/) from the ICIJ for extracting text from documents and searching them. [User Guide here](https://icij.gitbook.io/datashare/)
* [Open Semantic Search](https://www.opensemanticsearch.org/) is "Free Software for your own Search Engine, Explorer for Discovery of large document collections, Media Monitoring, Text Analytics, Document Analysis & Text Mining platform"
* [Aleph](https://aleph.occrp.org/) is "A tool for indexing large amounts of both documents (PDF, Word, HTML) and structured (CSV, XLS, SQL) data for easy browsing and search. It is built with investigative reporting as a primary use case. Aleph allows cross-referencing mentions of well-known entities (such as people and companies) against watchlists, e.g. from prior research or public datasets." [Read the documentation on GitHub](https://github.com/alephdata/aleph)
* [The Archive Network](https://thearchive.network/) - for creating personal and publishable archives, handles filetypes such as emails etc. Currently in closed beta.
* [Evernote](https://evernote.com/) (organisation, sharing, OCR and tagging)
* Programming languages open up other ways of dealing with text. For example, you can search documents using **command line** and **regex**, convert PDFs in **Python** using the library `pdftoxml`, or use tools like sentiment analysis and Natural Language Processing (NLP). The free ebook [Text Mining With R](https://www.tidytextmining.com/) explains some techniques.
* [CSV Match](https://github.com/maxharlow/csvmatch) is one tool for fuzzy matching.

Other tools are bookmarked at [https://pinboard.in/u:paulbradshaw/t:text+tools](https://pinboard.in/u:paulbradshaw/t:text+tools)

## Useful concepts

* A `diff` compares documents and shows the differences
* `Regex` (regular expression) is a way of describing the pattern in a passage of text (e.g. 2 digits followed by a non-numerical character, followed by two digits...)
* **Sentiment analysis** attempts to gauge whether a word or passage of text is positive or negative (used in [this story](https://www.washingtonpost.com/investigations/whistleblowers-say-usaids-ig-removed-critical-details-from-public-reports/2014/10/22/68fbc1a0-4031-11e4-b03f-de718edeb92f_story.html) along with `diff`)
* **Entity extraction** attempts to identify and classify entities in a document, such as people, places, organisations, and times and dates.
* **OCR** (Optical Character Recognition) attempts to convert images and scanned documents into text that can be searched etc. Google Images, for example, includes OCR so that you can search for images of specific licence plates, signs etc.
* **Fuzzy matching** allows you to match different text where they are not exactly the same, e.g. names spelt or arranged slightly differently in different documents.

## Guides and tutorials

* [This tutorial explains how to count multiple tags in a text column in Excel and Atom](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/tagsexample.md)
* [This tutorial explains how to use Datashare to create a document database and perform entity extraction](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/datasharehowto.md)
* [This thread talks about how to search multiple documents using Atom](https://discuss.atom.io/t/find-string-in-a-list-of-files/13269)
* [Fuzzy matching in SQL](http://www.padjo.org/tutorials/databases/sql-fuzzy/)
* [Find connections with fuzzy matching](https://github.com/maxharlow/tutorials/tree/master/find-connections-with-fuzzy-matching)

## Sources of text to work with

* The Chilcott Inquiry published [over 150 witness transcripts](https://webarchive.nationalarchives.gov.uk/20171123123302/http://www.iraqinquiry.org.uk/the-evidence/witness-transcripts/)
* [Submissions to the Cairncross Review (98 documents)](https://www.documentcloud.org/public/search/projectid:%2048718-cairncrossreview%20%20) - download them from the [call for submissions](https://www.gov.uk/government/consultations/call-for-evidence-on-sustainable-high-quality-journalism-in-the-uk)
* Companies House [publishes bulk data files of company accounts](http://download.companieshouse.gov.uk/en_accountsdata.html). These are in XBRL format (.html file extension) XBRL format (.xml file extension). The file names include the company number and filing date. Use command line to navigate to the folder and create a spreadsheet of the filenames using `ls > filenames.csv` then extract and filter by company number, filing date (`=RIGHT(SUBSTITUTE(SUBSTITUTE(A2,".html",""),".xml",""),8)`) and filetype. 
