/* ===============================================================================
*
* Part of the InfoGlue Content Management Platform (www.infoglue.org)
*
* ===============================================================================
*
*  Copyright (C)
* 
* This program is free software; you can redistribute it and/or modify it under
* the terms of the GNU General Public License version 2, as published by the
* Free Software Foundation. See the file LICENSE.html for more information.
* 
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY, including the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License along with
* this program; if not, write to the Free Software Foundation, Inc. / 59 Temple
* Place, Suite 330 / Boston, MA 02111-1307 / USA.
*
* ===============================================================================
*/
package org.infoglue.calendar.taglib;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * 
 */
public class TextFieldTag extends AbstractCalendarTag
{
    private static Log log = LogFactory.getLog(TextFieldTag.class);

	private static final long serialVersionUID = 3617579309963752240L;
	
	private boolean mandatory = false;

	private String name = "";
	private String labelCssClass = "";
	private String cssClass = "";
	private String value = "";
	private String label = "";
	private List fieldErrors = null;
	private Object errorAction = null;
	
	/**
	 * 
	 */
	public TextFieldTag() 
	{
		super();
	}
	
		  
	public int doEndTag() throws JspException
    {
		String errorName = name;
		if(errorName.indexOf("attribute_") > -1)
			errorName = errorName.substring(errorName.indexOf("attribute_") + 10);
		
	    fieldErrors = (List)findOnValueStack("#fieldErrors." + errorName);
	    Map fieldErrorsList = (Map)findOnValueStack("#fieldErrors");
	    
	    errorAction = findOnValueStack("#errorAction");
	    if(errorAction != null)
	    {
	        Object o = findOnValueStack("#errorAction." + errorName);
	        if(o != null)
	            value = o.toString();
        }
	    //System.out.println("name:" + name);
	    //System.out.println("errorName:" + errorName);
	    //System.out.println("fieldErrorsList:" + fieldErrorsList);
	    //System.out.println("fieldErrors: " + fieldErrors);
	    //System.out.println("value: " + value);
	    
	    String errorMessage = "";
	    if(fieldErrors != null && fieldErrors.size() > 0)
	    {   
	        Iterator i = fieldErrors.iterator();
	        while(i.hasNext())
		    {
	            String fieldError = (String)i.next();
	            //System.out.println("fieldError: " + fieldError);
	            String translatedError = this.getLabel(fieldError);
	            if(translatedError != null && translatedError.length() > 0)
	                fieldError = translatedError;

	          	errorMessage = "<span class=\"errorMessage\">" + fieldError + "</span>";
	        }
	    }	

	    StringBuffer sb = new StringBuffer();
        sb.append("<div class=\"fieldrow\">");
	    
        if(this.label != null)
	    {
	    	sb.append("<label for=\"" + name + "\">" + this.label + "</label>" + (getMandatory() ? "<span class=\"redstar\">*</span>" : "") + " " + errorMessage + "<br>");
	    	sb.append("	<input type=\"textfield\" id=\"" + name + "\" name=\"" + name + "\" value=\"" + ((value == null) ? "" : value) + "\" class=\"" + cssClass + "\">");
	    }
	    else
	    {
	    	sb.append("<label for=\"" + name + "\">" + this.name + "</label>" + (getMandatory() ? "<span class=\"redstar\">*</span>" : "") + " " + errorMessage + "<br>");
	    	sb.append("	<input type=\"textfield\" id=\"" + name + "\" name=\"" + name + "\" value=\"" + ((value == null) ? "" : value) + "\" class=\"" + cssClass + "\">");
	    }
		sb.append("</div>");
			
        //sb.append("<br>");
        //sb.append("<input type=\"textfield\" name=\"" + name + "\" value=\"" + ((value == null) ? "" : value) + "\" class=\"" + cssClass + "\">");

        write(sb.toString());
	    
        this.name = null;
        
        return EVAL_PAGE;
    }

	
    public void setCssClass(String cssClass)
    {
        this.cssClass = cssClass;
    }
    
    public void setName(String name)
    {
        Object o = findOnValueStack(name);
        if(o != null) 
            this.name = o.toString();
        else
            this.name = name;
    }

    public void setLabel(String rawLabel) throws JspException
    {
        Object o = findOnValueStack(rawLabel);
        String evaluatedString = evaluateString("TextFieldTag", "label", rawLabel);
        log.info("o:" + o);
        log.info("evaluatedString:" + evaluatedString);
        if(o != null)
            this.label = (String)o;
        else if(evaluatedString != null && !evaluatedString.equals(rawLabel))
            this.label = evaluatedString;
        else
        {
            String translatedLabel = this.getLabel(rawLabel);
            if(translatedLabel != null && translatedLabel.length() > 0)
                this.label = translatedLabel;
        }
    }
    
    public void setValue(String value)
    {
        Object o = findOnValueStack(value);
        if(o != null) 
            this.value = o.toString();
        else
            this.value = null;
        
        //this.value = value;
    }
    
    public void setLabelCssClass(String labelCssClass)
    {
        this.labelCssClass = labelCssClass;
    }
    
    public void setRequired(String required) throws JspException
    {
    	System.out.println("BEA1:" + required);
        String evaluatedString = evaluateString("AbstractInputCalendarTag", "required", required);
        if(evaluatedString != null && !evaluatedString.equals(required))
        	required = evaluatedString;
        
    	if(required.equalsIgnoreCase("true"))
            this.mandatory = true;
        else
            this.mandatory = false;   
    }

    
    public void setMandatory(String mandatory)
    {
    	System.out.println("APA1:" + mandatory);
    }

    public void setMandatory(Object mandatory)
    {
    	System.out.println("APA2:" + mandatory);
    }

    public void setMandatory(boolean mandatory)
    {
    	System.out.println("APA3:" + mandatory);
    }

    public boolean getMandatory()
    {
    	return this.mandatory;
    }

    
}
