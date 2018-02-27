Note for building the PDF version of this book
----------------------------------------------

A custom template for the inline <classname> is used
for the PDF build of this book.  Its purpose is to 
aid recognition of client-language classes and 
properties in the body text.  It has not been applied 
to code examples, nor to the HTML builds (via css).

The file affected is 
manual/src/docs/xsl/fo/inline.xsl.

A copy of the altered file is included in this node.
When building this book, you should

1) temporarily rename inline.xsl in its own location
2) copy the altered file from here to that location

Don't forget to restore the original file when you 
are done with building this book.
