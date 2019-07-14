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

## Analyse them in Datashare

Open Datashare on your computer. It will start running a local server, and open a browser at the address `http://localhost:8080`.

To ensure that you can search the documents, you need to first ask Datashare to analyse them: click **Analyze documents** near the top of your browser.

Wait for the analysis to finish.

Next click **Extract text** so that Datashare can extract the texts from your files.

When that's finished, try clicking **Find people, organizations and locations** to run the entity extraction. Leave the default option selected.

Once these steps have finished, you should be able to explore your documents in different ways: through search; by browsing entities; and by applying different filters such as document type etc. 
