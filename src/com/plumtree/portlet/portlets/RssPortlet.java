/*
Copyright (c) 2003, Plumtree Software

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions is met:

Neither the name of Plumtree Software nor the names of its contributors may be used
to endorse or promote products derived from this software without specific prior 
written permission. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package com.plumtree.portlet.portlets;


import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletMode;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.portlet.PortletSecurityException;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.UnavailableException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.*;
import javax.xml.transform.stream.StreamSource;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import java.net.URL;

import java.util.Arrays;
import java.util.Enumeration;
import java.util.TreeSet;

/**
 * Portlet that transforms an RSS newsfeed
 */
public class RssPortlet
  extends GenericPortlet
{
  /** xsl file for rss 1.0 */
  private static final String RSS10XSL = "/WEB-INF/html.xsl";

  /** xsl file for rss 2.0 */
  private static final String RSS20XSL = "/WEB-INF/Rss20.xsl";

  /**DOCUMENT ME!*/
  private static final String CONTENT_TYPE_HTML = "text/html;charset=UTF-8";

  /** compiled xsl file for 1.0 */
  private Templates m_translet10;

  /** compiled xsl file for 2.0 */
  private Templates m_translet20;

  /**
   * Gets the xsl file and puts it into application scope
   *
   * @see javax.servlet.portlet.Portlet#init(javax.servlet.portlet.PortletConfig)
   */
  public void init()
  {
    try
    {
        System.out.println("AAAAAAAAAAAAAAAAAAAAAAa");
        System.setProperty( "javax.xml.transform.TransformerFactory", "org.apache.xalan.processor.TransformerFactoryImpl"); 
        
      InputStream xslstream = this.getPortletContext().getResourceAsStream(
          RssPortlet.RSS10XSL);
      StreamSource source = new StreamSource(xslstream);
      TransformerFactory tFactory = TransformerFactory.newInstance();
      this.m_translet10 = tFactory.newTemplates(source);

      xslstream = this.getPortletContext().getResourceAsStream(
          RssPortlet.RSS20XSL);
      source = new StreamSource(xslstream);
      tFactory = TransformerFactory.newInstance();
      this.m_translet20 = tFactory.newTemplates(source);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  /**
   * @see javax.servlet.portlet.Portlet#processAction(javax.servlet.portlet.ActionRequest,
   *      javax.servlet.portlet.ActionResponse)
   */
  public void processAction(
    ActionRequest request,
    ActionResponse response)
    throws UnavailableException, 
      PortletSecurityException, 
      PortletException, 
      IOException
  {
    String errorMessage = null;

    System.out.println("request:" + request);
    Enumeration enum = request.getParameterNames();
    while(enum.hasMoreElements())
    {
        String name = (String)enum.nextElement();
        String value = request.getParameter(name);
        System.out.println(name + "=" + value);
    }
    //checkbox prefs
    //see how the prefs come over- can we just do a single checkbox?
    String[] checkPrefs = request.getParameterValues("checkPref");

    if (null != checkPrefs)
    {
      PortletPreferences prefs = request.getPreferences();
      TreeSet treePrefs = new TreeSet(Arrays.asList(checkPrefs));
      prefs.setValues(
        "RssXml",
        (String[]) treePrefs.toArray(new String[0]));
      prefs.store();
    }

    //input url
    //check if the url is a valid url
    //if not, pass in a render param for error
    String url = request.getParameter("inputXml");

    if ((null != url) && url.startsWith("http"))
    {
      try
      {
        //see if the url exists
        new URL(url).openStream();

        //add this as a pref
        PortletPreferences prefs = request.getPreferences();

        //add to the existing values
        TreeSet existingPrefs = new TreeSet(
            Arrays.asList(
              prefs.getValues(
                "RssXml",
                new String[]
                {
                  "http://www.theserverside.com/rss/theserverside-0.9.rdf"
                })));

        existingPrefs.add(url);
        prefs.setValues(
          "RssXml",
          (String[]) existingPrefs.toArray(new String[0]));
        prefs.store();

        //store as the selected xml so that it shows up selected as displays
        response.setRenderParameter(
          "selectXml",
          url);
        response.setRenderParameter(
          "inputXml",
          url);

        response.setRenderParameter(
                "apa",
                "Mattias");
        //set the portlet mode back to view
        response.setPortletMode(PortletMode.VIEW);
      }
      catch (Exception e)
      {
        //just get the error message to pass to render
        errorMessage = e.getMessage();
      }

      if (null != errorMessage)
      {
        response.setRenderParameter(
          "errorMessage",
          errorMessage);
      }
    }

    //selectXml from drop-down
    String selectXml = request.getParameter("selectXml");

    if (null != selectXml)
    {
      response.setRenderParameter(
        "selectXml",
        selectXml);
    }
  }

  /**
   * @see javax.servlet.portlet.GenericPortlet#doView(javax.servlet.portlet.RenderRequest,javax.servlet.portlet.RenderRequest)
   */
  protected void doEdit(
    RenderRequest request,
    RenderResponse response)
    throws UnavailableException, 
      PortletSecurityException, 
      PortletException, 
      IOException
  {
    response.setContentType("text/html");

    PrintWriter out = response.getWriter();
    PortletURL actionURL = response.createActionURL();

    out.println("<table>");
    out.println(
      "<form name=\"inputForm\" target=\"_self\" method=\"POST\" action=\"" +
      actionURL.toString() + "\">");

    /*
     * display checkboxes for all the prefs
     */

    //get the preferences for the option
    PortletPreferences prefs = request.getPreferences();
    String[] rssPrefs = prefs.getValues(
        "RssXml",
        new String[] { "http://www.theserverside.com/rss/theserverside-0.9.rdf" });

    for (int i = 0, len = rssPrefs.length; i < len; i++)
    {
      String pref = rssPrefs[i];
      out.println("<tr>");
      out.println("<td>");

      out.println(
        "<input type=\"checkbox\" name=\"checkPref\" value=\"" + pref +
        "\" CHECKED >");
      out.println(pref);

      out.println("</td>");
      out.println("</tr>");
    }

    /*textbox for url*/
    out.println("<tr>");
    out.println("<td>");
    out.println("Additional RSS Feed:");
    out.println("<input type=\"text\" name=\"inputXml\" value=\"\">");
    out.println(
      "<input name=\"inputSubmit\" type=\"submit\" value=\"submit\">");

    out.println("</td>");
    out.println("</tr>");
    out.println("</form>");
    out.println("</table>");
  }

  /**
   * @see javax.servlet.portlet.GenericPortlet#doHelp(javax.servlet.portlet.RenderRequest,javax.servlet.portlet.RenderRequest)
   */
  protected void doHelp(
    RenderRequest request,
    RenderResponse response)
    throws UnavailableException, 
      PortletSecurityException, 
      PortletException, 
      IOException
  {
    response.setContentType(CONTENT_TYPE_HTML);

    PrintWriter out = response.getWriter();
    out.println("<table>");
    out.println("<tr>");
    out.println("<td>");

    PortletURL renderURL = response.createRenderURL();
    renderURL.setPortletMode(PortletMode.VIEW);
    out.println(
      "The RSS Portlet transforms newsfeed using a default stylesheet<BR/> Note that not all newsfeeds will transform correctly, but none should throw an error. <BR/> To add or remove newfeeds, change the portlet preferences.<BR/> <a href=\"" +
      renderURL.toString() + "\">back</a>");
    out.println("</td>");
    out.println("</tr>");
    out.println("</form>");
    out.println("</table>");
  }

  /**
   * @see javax.servlet.portlet.GenericPortlet#doView(javax.servlet.portlet.RenderRequest,javax.servlet.portlet.RenderRequest)
   */
  protected void doView(
    RenderRequest request,
    RenderResponse response)
    throws UnavailableException, 
      PortletSecurityException, 
      PortletException, 
      IOException
  {
    response.setProperty(
      "expiration-cache",
      "130");

    InputStream xmlstream = null;
    InputStream xslstream = null;

    //try to get the selected value, if it exists
    String selectedXml = null;

    try
    {
        System.out.println("request:" + request);
        Enumeration enum = request.getParameterNames();
        while(enum.hasMoreElements())
        {
            String name = (String)enum.nextElement();
            String value = request.getParameter(name);
            System.out.println(name + "=" + value);
        }

      selectedXml = request.getParameter("selectXml");

      response.setContentType(CONTENT_TYPE_HTML);

      PrintWriter out = response.getWriter();

      /*error message from action, if any*/
      String errorMessage = request.getParameter("errorMessage");

      if (null != errorMessage)
      {
        out.println("<table>");
        out.println("<tr>");
        out.println("<td>");

        out.println("<font color=\"red\">" + errorMessage + "</font>");
        out.println("</td>");
        out.println("</tr>");
        out.println("</table>");
      }

      PortletURL actionURL = response.createActionURL();

      /*Select*/
      out.println("<table>");

      //get the action url
      out.print("<form name=\"selectForm\" method=\"POST\" action=\"");
      out.print(actionURL.toString());
      out.println("\" target=\"_self\">");
      out.println("<tr>");
      out.println("<td>");

      PortletURL renderLink = response.createRenderURL();
      renderLink.setPortletMode(PortletMode.HELP);
      out.println("<a href=\"" + renderLink + "\">help</a>");
      out.println("</td>");
      out.println("</tr>");
      out.println("<tr>");
      out.println("<td>");
      out.println("&nbsp;");
      out.println("</td>");
      out.println("</tr>");
      out.println("<tr>");
      out.println("<td>");
      out.println("<select name=\"selectXml\">");

      //get the preferences for the option
      PortletPreferences prefs = request.getPreferences();
      String[] rssPrefs = prefs.getValues(
          "RssXml",
          new String[] { "http://www.theserverside.com/rss/theserverside-0.9.rdf" });

      for (int i = 0, len = rssPrefs.length; i < len; i++)
      {
        out.print("<option value=\"");
        out.print(rssPrefs[i]);
        out.print("\"");

        if ((null != selectedXml) && rssPrefs[i].equals(selectedXml))
        {
          out.print(" SELECTED ");
        }

        out.print(">");
        out.print(rssPrefs[i]);
        out.println("</option>");
      }

      out.println("</select>");
      out.println("</td>");
      out.println("<td>");
      out.println(
        "<input name=\"selectSubmit\" type=\"submit\" value=\"go\">");
      out.println("</td>");
      out.println("<td>");
      out.println("</td>");
      out.println("</tr>");
      out.println("</form>");
      out.println("</table>");

      /* XML */
      if (null == selectedXml)
      {
        selectedXml = request.getPreferences().getValue(
            "RssXml",
            "http://www.theserverside.com/rss/theserverside-0.9.rdf");
      }

      xmlstream = new URL(selectedXml).openStream();

      if (xmlstream == null)
      {
        throw new PortletException("No XML");
      }

      //make a dom from the stream, so we can tell if this is 1.0 or 2.0
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
      Source source = null;
      Transformer transformer = this.m_translet10.newTransformer();

//see if we can parse the document to determine if this is 2.0  If not, go with the stream source
      try
      {
        Document document = builder.parse(xmlstream);
        Element element = document.getDocumentElement();

        //if we have a version attribute, then use 2.0
        if (element.hasAttribute("version") && element.getAttribute("version").equals("2.0"))
        {
          transformer = this.m_translet20.newTransformer();
        }

        source = new DOMSource(document);
      }
      catch (Exception e)
      {
        e.printStackTrace();
        source = new StreamSource(xmlstream);
      }

      /* Transform */
      StreamResult output = new StreamResult(out);
      transformer.transform(
        source,
        output);
    }
    catch (TransformerConfigurationException t)
    {
      throw new PortletException(t);
    }
    catch (TransformerException t)
    {
      throw new PortletException(t);
    }
    catch (Exception e)
    {
      throw new PortletException(e);
    }

    finally
    {
      if (xmlstream != null)
      {
        xmlstream.close();
      }

      if (xslstream != null)
      {
        xslstream.close();
      }
    }
  }
}
