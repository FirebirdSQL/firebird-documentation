// Text - Saxon extension element for inserting text

package com.nwalsh.saxon;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.net.URL;
import java.net.MalformedURLException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerConfigurationException;
import com.icl.saxon.*;
import com.icl.saxon.style.*;
import com.icl.saxon.expr.*;
import com.icl.saxon.output.*;
import org.xml.sax.AttributeList;

/**
 * <p>Saxon extension element for inserting text
 *
 * <p>$Id$</p>
 *
 * <p>Copyright (C) 2000 Norman Walsh.</p>
 *
 * <p>This class provides a
 * <a href="http://users.iclway.co.uk/mhkay/saxon/">Saxon</a>
 * extension element for inserting text into a result tree.</p>
 *
 * <p><b>Change Log:</b></p>
 * <dl>
 * <dt>1.0</dt>
 * <dd><p>Initial release.</p></dd>
 * </dl>
 *
 * @author Norman Walsh
 * <a href="mailto:ndw@nwalsh.com">ndw@nwalsh.com</a>
 *
 * @version $Id$
 *
 */
public class Text extends StyleElement {
  /**
   * <p>Constructor for Text</p>
   *
   * <p>Does nothing.</p>
   */
  public Text() {
  }

  /**
   * <p>Is this element an instruction?</p>
   *
   * <p>Yes, it is.</p>
   *
   * @return true
   */
  public boolean isInstruction() {
    return true;
  }

    /**
    * <p>Can this element contain a template-body?</p>
    *
    * <p>Yes, it can, but only so that it can contain xsl:fallback.</p>
    *
    * @return true
    */
  public boolean mayContainTemplateBody() {
    return true;
  }

  /**
   * <p>Validate the arguments</p>
   *
   * <p>The element must have an href attribute.</p>
   */
  public void prepareAttributes() throws TransformerConfigurationException {
    // Get mandatory href attribute
    String fnAtt = getAttribute("href");
    if (fnAtt == null) {
      reportAbsence("href");
    }
  }

  /** Validate that the element occurs in a reasonable place. */
  public void validate() throws TransformerConfigurationException {
    checkWithinTemplate();
  }

  /**
   * <p>Insert the text of the file into the result tree</p>
   *
   * <p>Processing this element inserts the contents of the URL named
   * by the href attribute into the result tree as plain text.</p>
   *
   */
  public void process( Context context ) throws TransformerException {
    Outputter out = context.getOutputter();

    String hrefAtt = getAttribute("href");
    Expression hrefExpr = makeAttributeValueTemplate(hrefAtt);
    String href = hrefExpr.evaluateAsString(context);
    URL fileURL = null;

    try {
      try {
	fileURL = new URL(href);
      } catch (MalformedURLException e1) {
	try {
	  fileURL = new URL("file:" + href);
	} catch (MalformedURLException e2) {
	  System.out.println("Cannot open " + href);
	  return;
	}
      }

      InputStreamReader isr = new InputStreamReader(fileURL.openStream());
      BufferedReader is = new BufferedReader(isr);

      final int BUFFER_SIZE = 4096;
      char chars[] = new char[BUFFER_SIZE];
      char nchars[] = new char[BUFFER_SIZE];
      int len = 0;
      int i = 0;
      int carry = -1;

      while ((len = is.read(chars)) > 0) 
      {
	// various new lines are normalized to LF to prevent blank lines between lines
	int nlen = 0;
	for (i=0; i<len; i++)
	{
	  // is current char CR?
	  if (chars[i] == '\r')
	  {
	    if (i < (len - 1))
	    {
       	      // skip it if next char is LF
	      if (chars[i+1] == '\n') continue;
              // single CR -> LF to normalize MAC line endings
              nchars[nlen] = '\n';
	      nlen++;
              continue;
	    }
	    else
	    {
	      // if CR is last char of buffer we must look ahead
	      carry = is.read();
              nchars[nlen] = '\n';
              nlen++;
	      if (carry == '\n')
	      {
                carry = -1;
              }
              break;
	    }
	  }
	  nchars[nlen] = chars[i];
	  nlen++;
	}
	out.writeContent(nchars, 0, nlen);
        // handle look aheaded character
	if (carry != -1) out.writeContent(String.valueOf((char)carry));
	carry = -1;
      }
      is.close();
    } catch (Exception e) {
      System.out.println("Cannot read " + href);
    }
  }
}
