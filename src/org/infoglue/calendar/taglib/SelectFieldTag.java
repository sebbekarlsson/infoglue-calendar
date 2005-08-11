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

import org.infoglue.calendar.entities.BaseEntity;

import com.opensymphony.xwork.ActionContext;


/**
 * 
 */
public class SelectFieldTag extends AbstractCalendarTag 
{
	private static final long serialVersionUID = 3617579309963752240L;
	
	private String name;
	private String cssClass = "";
	private List selectedValues;
	private List values;
	private String label;
	private String multiple = "false";
	private List fieldErrors;
	private Object errorBean = null;
	
	/**
	 * 
	 */
	public SelectFieldTag() 
	{
		super();
	}
	
	public int doEndTag() throws JspException
    {
	    fieldErrors = (List)findOnValueStack("#fieldErrors." + name);
	    errorBean = findOnValueStack("#errorBean");
	    /*
	    if(errorBean != null)
	    {
            value = findOnValueStack("#errorBean." + name).toString();
	        System.out.println("value:" + value);
        }
        */
	        
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
        
        sb.append("<select name=\"" + name + "\" multiple=\"" + multiple + "\" class=\"" + cssClass + "\">");
        
        Iterator valuesIterator = values.iterator();
        while(valuesIterator.hasNext())
	    {
            BaseEntity value = (BaseEntity)valuesIterator.next();
            sb.append("<option value=\"" + value.getId() + "\">" + value.getName() + "</option>");
        }
        sb.append("</select>");

        write(sb.toString());
	    
        return EVAL_PAGE;
    }

    public void setCssClass(String cssClass)
    {
        this.cssClass = cssClass;
    }
    
    public void setName(String name) throws JspException
    {
        this.name = name;
    }

    public void setLabel(String label) throws JspException
    {
        this.label = evaluateString("TextFieldTag", "label", label);
    }

    public void setMultiple(String multiple)
    {
        this.multiple = multiple;
    }

    public void setSelectedValues(String selectedValues) throws JspException
    {
        this.selectedValues = evaluateList("SelectTag", "selectedValues", selectedValues);
    }
    
    public void setValue(String value) throws JspException
    {
        Object o = findOnValueStack(value);
        if(o != null) 
            this.values = (List)o;
        
        //this.values = evaluateList("SelectTag", "values", values);
    }

    
    
}
