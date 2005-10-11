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
public class RadioButtonFieldTag extends AbstractCalendarTag 
{
    private static Log log = LogFactory.getLog(RadioButtonFieldTag.class);

	private static final long serialVersionUID = 3617579309963752240L;
	
	private String name;
	private String labelCssClass = "";
	private String cssClass = "";
	private String selectedValue;
	private Map values;
	private String label;
	private List fieldErrors;
	private Object errorAction = null;

    private boolean mandatory;
	
	/**
	 * 
	 */
	public RadioButtonFieldTag() 
	{
		super();
	}
	
	public int doEndTag() throws JspException
    {
	    fieldErrors = (List)findOnValueStack("#fieldErrors." + name);
	    
	    errorAction = findOnValueStack("#errorAction");
	    if(errorAction != null)
	    {
	        Object obj = findOnValueStack("#errorAction." + name);
	        if(obj instanceof String)
	            selectedValue = (String)obj;
        }

	    String errorMessage = "";
	    if(fieldErrors != null && fieldErrors.size() > 0)
	    {   
	        Iterator i = fieldErrors.iterator();
	        while(i.hasNext())
		    {
	            String fieldError = (String)i.next();
	          	errorMessage = "<span class=\"errorMessage\">" + fieldError + "</span>";
	        }
	    }	

	    StringBuffer sb = new StringBuffer();

	    sb.append("<div class=\"fieldrow\">");
	    if(this.label != null)
	    {
			sb.append("<label>" + this.label + "</label>" + (mandatory ? "<span class=\"redstar\">*</span>" : "") + " " + errorMessage + "<br>");
	    }
	    else
	        sb.append("<label>" + this.name + "</label>" + (mandatory ? "<span class=\"redstar\">*</span>" : "") + " " + errorMessage + "<br>");

        if(values != null)
        {
	        Iterator valuesIterator = values.keySet().iterator();
	        while(valuesIterator.hasNext())
		    {
	            String id 			= (String)valuesIterator.next();
	            log.info("Id:" + id);
	            String optionText 	= (String)values.get(id);
	            log.info("optionText:" + optionText);

                log.info("selectedValue:" + selectedValue);
	            String checked = "";
	            if(selectedValue != null)
	            {
	                if(id.equalsIgnoreCase(selectedValue))
	                    checked = " checked=\"1\"";
	            }
	            
	    		sb.append("<input name=\"" + name + "\" value=\"" + id + "\" class=\"\" type=\"radio\" id=\"" + name + "\"" + checked + "><label for=\"" + name + "\"> " + this.getLabel(optionText) + "</label><br />");
	        }
        }
        sb.append("</div>");

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

    public void setLabel(String rawLabel) throws JspException
    {
        String translatedLabel = this.getLabel(rawLabel);
        if(translatedLabel != null && translatedLabel.length() > 0)
            this.label = translatedLabel;
        else
            this.label = evaluateString("SelectFieldTag", "label", rawLabel);
    }

    public void setSelectedValue(String selectedValue) throws JspException
    {
        log.info("Setting selectedValue:" + selectedValue);
        Object o = findOnValueStack(selectedValue);
        if(o != null) 
            this.selectedValue = o.toString();
        else
            this.selectedValue = null;        
        log.info("Setting selectedValue:" + this.selectedValue);
        
    }
    
    public void setLabelCssClass(String labelCssClass)
    {
        this.labelCssClass = labelCssClass;
    }
    
    public void setMandatory(String mandatory)
    {
        if(mandatory.equalsIgnoreCase("true"))
            this.mandatory = true;
        else
            this.mandatory = false;    
    }

    public void setValueMap(String valueMap) throws JspException
    {
        Object o = findOnValueStack(valueMap);
        if(o != null) 
        {
            this.values = (Map)o;
        }
        else
        {
            this.values = null;
        }
    }
    
 }
