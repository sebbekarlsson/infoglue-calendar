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
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;

import com.opensymphony.xwork.ActionContext;


/**
 * 
 */
public class TextFieldTag extends AbstractCalendarTag 
{
	private static final long serialVersionUID = 3617579309963752240L;
	
	private String name;
	private String cssClass = "";
	private String value;
	private String label;
	private List fieldErrors;
	private Object errorBean = null;
	
	/**
	 * 
	 */
	public TextFieldTag() 
	{
		super();
	}
	
	public int doEndTag() throws JspException
    {
	    fieldErrors = (List)findOnValueStack("#fieldErrors." + name);
	    errorBean = findOnValueStack("#errorBean");
	    if(errorBean != null)
	    {
            value = findOnValueStack("#errorBean." + name).toString();
	        System.out.println("value:" + value);
        }
	        
	    StringBuffer sb = new StringBuffer();
	    if(this.label != null)
	        sb.append(this.label);
		else
		    sb.append(name);
		    
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
        sb.append("<input type=\"textfield\" name=\"" + name + "\" value=\"" + ((value == null) ? "" : value) + "\" class=\"" + cssClass + "\">");

        write(sb.toString());
	    
        return EVAL_PAGE;
    }

    public void setCssClass(String cssClass)
    {
        this.cssClass = cssClass;
    }
    
    public void setErrorBean(String errorBean)
    {
        this.errorBean = errorBean;
    }
    
    public void setFieldErrors(String fieldErrors) throws JspException
    {
        this.fieldErrors = evaluateList("TextField", "fieldErrors", fieldErrors);
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setLabel(String label) throws JspException
    {
        this.label = evaluateString("TextFieldTag", "label", label);
    }
    
    public void setValue(String value)
    {
        Object o = findOnValueStack(value);
        if(o != null) 
            this.value = o.toString();
        //this.value = value;
    }
    
}
