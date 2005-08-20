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

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;

import org.infoglue.common.util.ResourceBundleHelper;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.ActionContext;


/**
 * 
 */
public class TextAreaFieldTag extends AbstractCalendarTag 
{
	private static final long serialVersionUID = 3617579309963752240L;
	
	private String name = "";
	private String cssClass = "";
	private String value = "";
	private String label = "";
	private List fieldErrors = null;
	private Object errorAction = null;
	
	/**
	 * 
	 */
	public TextAreaFieldTag() 
	{
		super();
	}
	
		  
	public int doEndTag() throws JspException
    {
	    fieldErrors = (List)findOnValueStack("#fieldErrors." + name);
	    
	    errorAction = findOnValueStack("#errorAction");
	    if(errorAction != null)
	    {
	        Object o = findOnValueStack("#errorAction." + name);
	        if(o != null)
	            value = o.toString();
	        
	        System.out.println("value from errorAction:" + value);
        }
	    
	    StringBuffer sb = new StringBuffer();
	    if(this.label != null)
	        sb.append("<span class=\"calendarLabel\">" + this.label + "</span>");
		else
		    sb.append("<span class=\"calendarLabel\">" + name + "</span>");
		    
	    if(fieldErrors != null && fieldErrors.size() > 0)
	    {   
	        Iterator i = fieldErrors.iterator();
	        while(i.hasNext())
		    {
	            String fieldError = (String)i.next();
	          	sb.append("<span class=\"errorMessage\">- " + fieldError + "</span>");
	        }
	    }	
        sb.append("<br>");
        sb.append("<textarea name=\"" + name + "\" class=\"" + cssClass + "\">" + ((value == null) ? "" : value) + "</textarea>");

        write(sb.toString());
	    
        return EVAL_PAGE;
    }

	
    public void setCssClass(String cssClass)
    {
        this.cssClass = cssClass;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }

    public void setLabel(String rawLabel) throws JspException
    {
        String translatedLabel = this.getLabel(rawLabel);
        if(translatedLabel != null && translatedLabel.length() > 0)
            this.label = translatedLabel;
        else
            this.label = evaluateString("TextFieldTag", "label", rawLabel);
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
    
}
