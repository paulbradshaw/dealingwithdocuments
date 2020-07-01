# Analysing company accounts as text documents

Most company accounts are published in PDF format which makes them difficult to analyse at scale - especially as many are also scanned. 

However, Companies House's [Accounts Data Product](http://download.companieshouse.gov.uk/en_accountsdata.html) allows you to download a collection of company accounts as "data files" (HTML or XML format). At the time of writing the page notes that: 

> "Data is only available for electronically filed accounts, which currently stands at about 75% of the 2.2 million accounts we expect to be filed each year."

Although these files, like company accounts more generally, do not necessarily have a common structure that can be predicted - they do have a number of qualities which make them easier to analyse than PDF versions of the same information. This includes:

* The ability to search text contents
* Some tagging which can be used to classify information
* More reliability than OCR
* A file naming approach which allows for querying and filtering

The downloads are large (one downloaded on July 1st contained 27,000 files) and 5 are provided every week - so the scale involved is large.

We will deal with one of those downloads to demonstrate some techniques for dealing with large numbers of those documents.

## Understanding and filtering the download

Download the most recent download - I'm going to use the [July 1 2020 download](http://download.companieshouse.gov.uk/Accounts_Bulk_Data-2020-07-01.zip) as I'm writing it on that day.

When the download has finished, you should have a Zip file, which you should unzip to its own folder.

The files inside will have names like `Prod223_2688_00103767_20191231.html`.

Those names are useful because they contain data:

The last 8 characters show the date that the accounts refer to: the `20191231`, for example, means the accounts are for the year ending on the 31st of December 2019. 

The 8 characters before that are the company number: in the example above this is `00103767`.

And the file extension tells us whether this is `iXBRL` or `XBRL` format: `.html` indicates the former; `.xml` the latter. This helps us know how to interpret the files later. For example, there are [R packages for working with XBRL](https://cran.r-project.org/web/packages/XBRL/index.html).

The rest isn't useful to us.
