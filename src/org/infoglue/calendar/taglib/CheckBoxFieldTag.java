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
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;

import org.infoglue.calendar.actions.CalendarAbstractAction;
import org.infoglue.calendar.entities.BaseEntity;

import org.infoglue.common.security.InfoGluePrincipal;

import com.opensymphony.xwork.ActionContext;


/**
 * 
 */
public class CheckBoxFieldTag extends AbstractCalendarTag 
{
	private static final long serialVersionUID = 3617579309963752240L;
	
	private String name;
	private String labelCssClass = "";
	private String cssClass = "";
	private String size = "";
	private String multiple = "false";
	private String[] selectedValues;
	private List selectedValueList;
	private Set selectedValueSet;
	private Map values;
	private String label;
	private List fieldErrors;
	private Object errorAction = null;

    private boolean mandatory;
	
	/**
	 * 
	 */
	public CheckBoxFieldTag() 
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
	            selectedValues = new String[]{(String)obj};
	        else if(obj instanceof String[])
	            selectedValues = (String[])obj;
        }

	    String errorMessage = "";
	    if(fieldErrors != null && fieldErrors.size() > 0)
	    {   
	        Iterator i = fieldErrors.iterator();
	        while(i.hasNext())
		    {
	            String fieldError = (String)i.next();
	            errorMessage = "<span class=\"errorMessage\">- " + fieldError + "</span>";
	        }
	    }	

	    StringBuffer sb = new StringBuffer();
	    
	    sb.append("<div class=\"fieldrow\">");
	    //if(this.label != null)
	    //{
	    //	sb.append("<label>" + this.label + "</label><span class=\"redstar\">*</span><br>");
	    //}
	    //else
	    //    sb.append("<label>" + this.name + "</label><span class=\"redstar\">*</span><br>");
		            
        if(values != null)
        {
	        Iterator valuesIterator = values.keySet().iterator();
	        while(valuesIterator.hasNext())
		    {
	            String id 			= (String)valuesIterator.next();
	            String optionText 	= (String)values.get(id);

	            System.out.println("Id:" + id);
	            System.out.println("optionText:" + optionText);

                System.out.println("selectedValue:" + selectedValues);

	            String checked = "";

	            if(selectedValues != null)
	            {
		            for(int i=0; i<selectedValues.length; i++)
		            {
		                if(id.equalsIgnoreCase(selectedValues[i]))
		                    checked = " checked=\"1\"";
		            }
	            }
	            else if(selectedValueList != null)
	            {
	                Iterator selectedValueListIterator = selectedValueList.iterator();
	                while(selectedValueListIterator.hasNext())
		            {
	                    String selId;
	                	Object selObj = selectedValueListIterator.next();
	    	            if(selObj instanceof InfoGluePrincipal)
	    	            {
	    	                InfoGluePrincipal selValue = (InfoGluePrincipal)selObj;
	    	                selId = selValue.getName().toString();
	    	            } 
	    	            else
	    	            {
	    	                BaseEntity selValue = (BaseEntity)selObj;
	    	                selId = selValue.getId().toString();
	    	            }
	    	            
		                if(id.equalsIgnoreCase(selId))
		                    checked = " checked=\"1\"";
		            }
	            }
	            else if(selectedValueSet != null)
	            {
	                Iterator selectedValueSetIterator = selectedValueSet.iterator();
	                while(selectedValueSetIterator.hasNext())
		            {
	                    String selId;
	                	Object selObj = selectedValueSetIterator.next();
	    	            if(selObj instanceof InfoGluePrincipal)
	    	            {
	    	                InfoGluePrincipal selValue = (InfoGluePrincipal)selObj;
	    	                selId = selValue.getName().toString();
	    	            } 
	    	            else
	    	            {
	    	                BaseEntity selValue = (BaseEntity)selObj;
	    	                selId = selValue.getId().toString();
	    	            }
	    	            
		                if(id.equalsIgnoreCase(selId))
		                    checked = " checked=\"1\"";
		            }
	            }
	            
	    		sb.append("<input name=\"" + name + "\" value=\"" + id + "\" class=\"\" type=\"checkbox\" id=\"" + name + "\"" + checked + "><label for=\"" + name + "\"> " + this.getLabel(optionText) + "</label><br />");

	            //sb.append("<input type=\"checkbox\" name=\"" + name + "\" value=\"" + id + "\" class=\"" + cssClass + "\"" + checked + "><span class=\"" + cssClass + "\">" + optionText + "</span>");
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

    public void setMultiple(String multiple)
    {
        this.multiple = multiple;
    }

    public void setSelectedValues(String selectedValues) throws JspException
    {
        Object o = findOnValueStack(selectedValues);
        if(o != null)
        {
            if(o instanceof String[])
                this.selectedValues = (String[])o;
            else
                this.selectedValues = new String[] {o.toString()};
        }
        else
            this.selectedValues = null;
        //this.selectedValues = evaluateStringArray("SelectTag", "selectedValues", selectedValues);
    }

    public void setSelectedValue(String selectedValue) throws JspException
    {
        Object o = findOnValueStack(selectedValue);
        if(o != null) 
            this.selectedValues = new String[] {o.toString()};
        else
            this.selectedValues = null;
        
        //this.selectedValues = new String[] {evaluateString("SelectTag", "selectedValue", selectedValue)};
    }

    public void setSelectedValueList(String value) throws JspException
    {
        Object o = findOnValueStack(value);
        if(o != null) 
        {
            this.selectedValueList = (List)o;
        }
        else
        {
            this.selectedValueList = null;
        }

        //this.values = evaluateList("SelectTag", "values", values);
    }

    public void setSelectedValueSet(String value) throws JspException
    {
        Object o = findOnValueStack(value);
        if(o != null) 
        {
            this.selectedValueSet = (Set)o;
        }
        else
        {
            this.selectedValueSet = null;
        }
        //this.values = evaluateList("SelectTag", "values", values);
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

    
    public void setSize(String size)
    {
        this.size = size;
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

}
