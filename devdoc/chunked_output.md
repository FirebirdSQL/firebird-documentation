How to generate chunked output
------------------------------

NOTE: Creating chunked output is experimental.

1. Download and unzip latest docbook-xsltng from https://github.com/docbook/xslTNG/releases \
   When a new release is used, check if `css/firebird.css`, `css/firebird-toc.css` and 
   `js/firebird-persistent-toc.js` in `src/theme/dockbook5` need to be changed (e.g. by 
   diff-ing the files they are based on in the previous and current version).
2. Go to the docker directory and run
   ```
   docker build -t docbook-xslt .
   ```
3. Generate Docbook from Asciidoc (e.g. for Firebird 4.0 Language Reference):
   ```
   ./gradlew asciidocDocbook --baseName=refdocs --docId=fblangref40
   ```
4. Generate chunked HTML from Docbook: (note: trial & error, work in progress; PowerShell syntax; paths based on my setup)

   Firebird 5.0 Language Reference
   ```
   docker run --rm `
    -v D:\Development\firebird-documentation\build\docs\chunk:/output `
    -v D:\Development\firebird-documentation\build\docs\asciidoc\docbook:/input `
    docbook-xslt `
    /input/en/refdocs/fblangref50/firebird-50-language-reference.xml `
    chunk-output-base-uri=/output/en/refdocs/fblangref50/ `
    chunk=firebird-50-language-reference.html `
    resource-base-uri=../../../ `
    --resources:/output `
    -- `
    "-xsl:/input/custom.xsl"      
   ``` 

   Firebird 4.0 Language Reference
   ```
   docker run --rm `
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
   
   Firebird 3.0 Language Reference
   ```
   docker run --rm `
    -v D:\Development\firebird-documentation\build\docs\chunk:/output `
    -v D:\Development\firebird-documentation\build\docs\asciidoc\docbook:/input `
    docbook-xslt `
    /input/en/refdocs/fblangref30/firebird-30-language-reference.xml `
    chunk-output-base-uri=/output/en/refdocs/fblangref30/ `
    chunk=firebird-30-language-reference.html `
    resource-base-uri=../../../ `
    --resources:/output `
    -- `
    "-xsl:/input/custom.xsl"      
   ```

   Firebird 2.5 Language Reference
   ```
   docker run --rm `
    -v D:\Development\firebird-documentation\build\docs\chunk:/output `
    -v D:\Development\firebird-documentation\build\docs\asciidoc\docbook:/input `
    docbook-xslt `
    /input/en/refdocs/fblangref25/firebird-25-language-reference.xml `
    chunk-output-base-uri=/output/en/refdocs/fblangref25/ `
    chunk=firebird-25-language-reference.html `
    resource-base-uri=../../../ `
    --resources:/output `
    -- `
    "-xsl:/input/custom.xsl"      
   ```