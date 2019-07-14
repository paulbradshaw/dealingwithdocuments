# Using Datashare to analyse documents

Datashare is a tool for analysing documents created by the ICIJ. It allows you to:

* Search multiple documents all at once (document database/archive)
* Text extraction (OCR)
* Entity extraction

First, [download Datashare here](https://datashare.icij.org/).

A [user guide explains how to install the tool on various platforms](https://icij.gitbook.io/datashare/) and there are sections on [analysis](https://icij.gitbook.io/datashare/all/analyze-documents) and [exploration](https://icij.gitbook.io/datashare/all/explore-documents).

Those guides are best to check, but here's a quick step-by-step.

## Add documents to your Datashare folder

Once Datashare is installed, it will create a folder on your computer with the same name. On a Windows PC this will be on your Desktop; on a Mac it will be in your username folder, as [explained here](https://icij.gitbook.io/datashare/mac/add-documents-to-datashare-on-mac).

To analyse documents in Datashare you need to first move them to this folder.

I have bulk downloaded a [bunch of witness statements for you to use here](https://github.com/paulbradshaw/dealingwithdocuments/tree/master/chilcottwitnessstatements). Download those to try the tool out.

## 'Analyse them' (prepare for analysis) in Datashare

Open Datashare on your computer. It will start running a local server, and open a browser at the address `http://localhost:8080`.

To ensure that you can search the documents, you need to first ask Datashare to analyse them: click **Analyze documents** near the top of your browser.

Wait for the analysis to finish.

Next click **Extract text** so that Datashare can extract the texts from your files.

When that's finished, try clicking **Find people, organizations and locations** to run the entity extraction. Leave the default option selected.

Once these steps have finished, you should be able to explore your documents in different ways: through search; by browsing entities; and by applying different filters such as document type etc.

## Search or browse documents in Datashare

Leave the search box empty (apart from the asterisk which will be added anyway) and click **Search**.

After a few moments you should see the reuslts of that empty search: a list of documents found. But more importantly, on the left are other ways of navigating those documents:

* File type: there may just be PDFs, but if you've added images, emails, or other file types you can filter them here.
* Language: the language of documents is detected and you can filter accordingly here
* People: note that the most-mentioned appear here, but there's also a search box for you to look closer. Try typing 'paul' to narrow the list to those with 'Paul' in the name
* Organisations: as above. Try clicking on one organisation to narrow the results.
* Locations: as above. Click 'show more' to browse through the options.
* Indexing date: each time you run a new analysis a new indexing date will be created, so you can filter based on when the documents were indexed

[More on this in the Datashare guide](https://icij.gitbook.io/datashare/all/explore-documents)

## More advanced searches

[More advanced searches can be conducted with certain operators, detailed here](https://icij.gitbook.io/datashare/all/search-with-operators).

This includes **fuzzy search** where you can look for words which might be misspelt/incorrectly OCR'd, or spelt slightly differently (an example being `quikc~ brwn~ foks~`) and **proximity search** which looks for words within a certain distance of each other (example: `"fox quick"~5`)

## Opening documents in Datashare  

If you want to dig deeper into a search result, click on the document name to open its page. There will be 4 tabs:

* Details: metadata about the document
* Named entities: people, locations, etc. - note that not all are shown and there doesn't seem to be a way of seeing the others.
* Extracted text: this can be searched directly using CTRL+F
* Preview: the original document. This will generate an error if the document has moved.

In addition there is a download link in the upper right corner which allows you to download a copy. This will generate an error if the document has moved.
