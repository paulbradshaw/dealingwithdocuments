# Counting the most common tags (or names or words) in an Excel spreadsheet

In this example we have a dataset where each record has a number of tags (you can [see a sample dataset with steps separated into different sheets in the same folder as this tutorial](https://github.com/paulbradshaw/dealingwithdocuments/blob/master/textanalysisexample.xlsx)). We want to identify the most common tags, but there are two problems:

* The tags are in a single cell, separated by a pipe symbol: `|`
* The tags may include spaces, e.g. "Race Relations"

How do we separate the tags in order to count them?

(It helps to imagine the end result you are aiming for. In this case we want a single column where each tag occupies its own cell. This can then be pivoted to count the frequency of each tag)

*Note: there are also two other columns: 'people' and 'production company' which are formed the same way and which we might want to analyse.

## Step 1: Copy the column into the text editor Atom and change it to a single line

Select the whole column and paste it into Atom. 

Atom contains some useful functionality that will allow us to convert the column into a single string.

Press CTRL+F to open up a *Find* area at the bottom of the screen. There are two boxes here: 

* A 'find' box
* A 'replace' box

To the right of these are buttons to **Replace All** etc. - and above those buttons are some special smaller buttons. 

Look for the small button with the `.*` symbol on it. This turns on **regex** (regular expressions) - turn it on.

Now your search can include a regular expression.

In the 'find' box type `\n` - this is the regular expression for a *new line*.

In the 'replace' box type `|` - you are going to replace any new line with a pipe symbol. 

Click **Replace All**. The narrow column of text should now be changed so that the page is filled with a long line of tags, each separated by that pipe symbol.

We can now bring it back to Excel.

## Step 2: Convert text to columns in Excel

Copy the text from Atom and paste it into the first cell of a sheet in Excel. 

With that cell selected, go to the *Data* menu and select *Text to columns*. On the window that appears:

* Select *Delimited* on the first screen and click *Next*
* Tick **Other** on the second screen and paste the pipe symbol `|` into the empty box next to it
* Click *Finish*

That single cell should now be split into many, many cells, all in the same row. Each cell now contains one tag, and the pipe symbols between those have been removed.

We are almost there. We just need to get this in one column rather than one row.

## Step 3: Transpose the row into a column

Select the whole row by clicking on the row number 1 to the left of the first cell.

Copy it with CTRL+C

Create a new sheet in Excel, and select *Edit > Paste Special...*

Tick the box marked **Transpose** (or select the transpose option from a menu if you get one) and click *OK*.

This will paste the row you copied as a single column.

*Note: you can do steps 2 and 3 in Google Sheets with a single formula: instead of text to columns, use the formula `=TRANSPOSE(SPLIT(A1, "|"))`

## Step 4: Create a pivot table from that column

Now you can count the tags separately. 

Make sure you are somewhere in that column and select *Insert > Pivot Table*. 

Click **OK** and a new sheet will be created with an empty pivot table.

On the right you should see the pivot table builder. In the top half of that will be just one field: 'tags'.

Click and drag that 'tags' field into the *Rows* area in the bottom.

Click and drag that 'tags' field into the *Values* area in the bottom, too. This will count the frequency of each tag.

Finally, to bring the most frequent to the top, make sure you are on one of the numbers in the pivot table itself, and then go to the *Data* tab. Click the *small* **Z-A** button to order the table by that column, largest to smallest.

## An alternative Excel-only approach: `TEXTJOIN`

You can skip the Atom step by using the `TEXTJOIN` function like so:

Create a new sheet in Excel and write a formula that joins all the cells together in one column:

`=TEXTJOIN("|",TRUE,'original data'!B:B)`

The `TEXTJOIN` function needs 3 ingredients:

* A delimiter which will separate the cells that it is joining. In this case we use `"|"` because the tags are already separated by a pipe *within* the cell, and we need that pipe symbol to separate them between cells too, once joined.
* A `TRUE/FALSE` value whether to ignore blank cells. We want to ignore blank cells so use `TRUE`
* The range of cells to be joined: `'original data'!B:B` is all cells in column B within the sheet 'original data'

This will create a single cell containing the contents of all those cells, with pipes inserted wherever a cell was joined.

Now copy that cell and select *Paste Special > Values Only* so that you are only pasting the results of the formula.

Next, split that cell into columns using Step 2 above, and follow the same process from there.
