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

## Creating a list of files using command line

Given there are 27,000 of these files it would be useful to know what companies and dates they refer to - and possibly filter accordingly.

Some simple pieces of command line can do this for us ([more on using command line here](https://github.com/paulbradshaw/commandline)).

Open up Terminal (on a Mac) or PowerShell (on a PC) and use `cd` to navigate to the folder where you downloaded the files. 

You can generate a list of files in that folder using `ls` (or `dir` on PC).

To store that list instead, just add `> filename.csv` after the `ls` command like so:

`ls > files.csv`

This will create a new file with that name and extension (`files.csv`) containing the list of files. I've used CSV so we can easily open it in Excel or Google Sheets ([more on the Windows command here](https://www.windowscentral.com/how-save-command-output-file-using-command-prompt-or-powershell)).

### Filtering the list in a spreadsheet

You can use that spreadsheet to compile information on the files, and filter them accordingly. We can filter by:

* Date (e.g. those between certain dates)
* Filetype (e.g. those which can be analysed in a particular way)
* Company number (e.g. those matching a list we have)

To begin with it has just one column, with each filename.

It doesn't have a header, so firstly insert a new row at the top of the spreadsheet and in the new empty cell A1 type **filename**.

Give column B the heading **date** and type the following formula in cell B2 underneath:

`=RIGHT(SUBSTITUTE(SUBSTITUTE(A2,".html",""),".xml",""),8)`

This formula nests various parts of text cleaning: first it gets rid of the `.html` extension using `SUBSTITUTE(A2,".html","")`, then this is used for another `SUBSTITUTE` formula that gets rid of the `.xml` extension (files can have either). Once these have both been removed, it extracts the final 8 characters of the resulting string using `=RIGHT()` at the front of the formula.

Now we have that full date we can extract parts of it.

In cell C1 type **year** and type this formula:

`=LEFT(B2,4)`

This uses the results of the last formula and extracts the first four characters, which contain the year.

In cell D1 type **month** and type this formula:

`=MID(B2,5,2)`

This uses the results of the same formula again but this time extracts the two characters starting at the fifth *position*: those contain the month.

We might also want to distinguish between what type of file it is. To do this, type **filetype** in cell E1 and type this formula:

`=RIGHT(A2,4)`

This look at the full filename and grabs the last four characters: that will either be `html` or `.xml` (we could nest this inside a `SUBSTITUTE` function to remove the period but it doesn't matter).

To extract the company number we can also use a `MID` function. In cell F1 type **companynumber** and type this formula:

`=MID(A2,14,8)`

Because the company number always starts at position 14 and runs for 8 characters, that's all we need to put here.

If we have another list of company numbers, we can use `VLOOKUP` to see where there is a match for one number in the other list (non-matches will return `#N/A`). Make sure that you clean the other company numbers so they are 8 characters long: if you are cleaning a company number in cell A2 the formula would be:

`=REPT("0",8-LEN(A2))&A2`

In other words this will measure the length of A2 (the company number) and subtract that from the number 8. If it's less than 8 characters then the number of characters missing will be used to generate that number of zeroes, and those zeroes will be put at the front of the unclean company number to create a 'clean' one.


## Filtering with R

The following function uses a number of functions in R to look inside the Zip files, extract the company numbers, match those against a list, and then extract *only* the files that match, saving locally.

```
#Create a function - it takes 2 arguments:
#zipurl should be the URL of a zip file
#compnums should be a vector of company numbers
findmatchedaccounts <- function(zipurl, compnums)
  {
  #Create a temporary file to store zip
  temp <- tempfile()
  #Download zip file
  download.file(zipurl,temp)
  #Store a list of the files
  zflist <- unzip(temp, list = T)
  #Add URL - we'll need this to download again if it has matching files
  zflist$url <- zipurl
  #We want to retain the full filename so we store that separately
  zflist$filename <- zflist$Name 
  #Then we separate on the underscore
  zflist <- tidyr::separate(zflist, Name, into = c("batch1","batch2","compnum","date"), sep ="_")
  #We separate again on the period, using square brackets to indicate we want to match it literally
  zflist <- tidyr::separate(zflist, date, into = c("date","filetype"), sep ="[.]")
  #Extract those that match
  filematches <- zflist$filename[zflist$compnum %in% compnums]
  #If there's at least one:
  if (length(filematches)>0){
    #Unzip just that one - this will throw an error if there's more than one match?
    matchedfile <- readLines(unz(temp, filematches))
    #Write it as a document, using the same filename
    write(matchedfile, filematches)
  }
  #Remove file
  unlink(temp)
  #Return the list of any matches
  return(filematches)
}
```

Once that's defined, you can loop through a list of URLs for the zip files like so:


```
#Create empty list
matchedfileslist <- c()
#Loop through list of file names created earlier
for (i in files){
  #form the full url by adding the file name to the CH base URL
  fullurl <- paste(baseurl,i,sep = "")
  print(fullurl)
  #run the function on that URL, with the company numbers
  matchedfiles <- findmatchedaccounts(fullurl, footballclubs$fullcompanynum)
  #We want to keep track of the results
  print(matchedfiles)
  #Add to what was the empty list
  matchedfileslist <- c(matchedfileslist, matchedfiles)
}
```


## Filtering those files using command line

We can also use command line to select certain files based on their name.

## Moving files using command line 

The `mv` command will move specified files to a specified place.

If we've identified that the file `Prod223_2688_00488096_20190630.html`, for example, is of interest we can move it from the directory of 27,000 files to the parent directory by typing the following (making sure we have used command line to move into the folder containing the file):

`mv Prod223_2688_00488096_20190630.html ..`

The two dots `..` means 'parent folder'.

If we want to move it instead to a folder within the parent folder, e.g. one called 'matchingaccounts', we can change it to this:

`mv Prod223_2688_00488096_20190630.html ../matchingaccounts`

(Obviously the file needs to still be in the place where we are writing our command line)
