This is src/docs/xsl

This directory contains our driver stylesheets for the various
build targets.

Each driver stylesheet is named after the target it's used for, and
imports the appropriate default DocBook stylesheet (to be found in
the tools/docbook-stylesheets tree). Most drivers also contain a
number of <include> elements to load customized transformation
templates that override some of the imported DocBook ones.

The overriding templates are placed in files in subdirs below
src/doc/xsl; these subdirs and files mimic (part of) the structure
under tools/docbook-stylesheets, with each overriding template
placed in a file with the same relative path as the file in the
tools/docbook-stylesheets tree that contains the overridden template.

This is done to keep things manageable.
