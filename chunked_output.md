How to generate chunked output
------------------------------

NOTE: Creating chunked output is experimental.

1. Download and unzip latest docbook-xsltng from https://github.com/docbook/xslTNG/releases
2. Go to the docker directory and run
   ```
   docker build -t docbook-xslt .
   ```
3. Generate Docbook from Asciidoc (e.g. for Firebird 4.0 Language Reference):
   ```
   ./gradlew asciidocDocbook --baseName=refdocs --docId=fblangref40
   ```
4. Generate chunked HTML from Docbook: (note: trial & error, work in progress; PowerShell syntax; paths based on my setup)
   ```
   docker run `
    -v D:\Development\firebird-documentation\build\docs\chunk:/output `
    -v D:\Development\firebird-documentation\build\docs\asciidoc\docbook:/input `
    docbook-xslt `
    /input/en/refdocs/fblangref40/firebird-40-language-reference.xml `
    chunk-output-base-uri=/output/en/refdocs/fblangref40/ `
    chunk=firebird-40-language-reference.html `
    resource-base-uri=../../../ `
    --resources:/output `
    -- `
    "-xsl:/input/custom.xsl"      
   ```