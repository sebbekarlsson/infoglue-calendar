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

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.entities.BaseEntity;
import org.infoglue.calendar.entities.Role;
import org.infoglue.calendar.entities.Group;

import org.infoglue.cms.security.InfoGluePrincipal;
import org.infoglue.cms.security.InfoGlueRole;
import org.infoglue.cms.security.InfoGlueGroup;


/**
 * 
 */
public class SelectFieldTag extends AbstractCalendarTag 
{
    private static Log log = LogFactory.getLog(SelectFieldTag.class);

	private static final long serialVersionUID = 3617579309963752240L;
	
	private String name;
	private String labelCssClass = "";
	private String cssClass = "";
	private String size = "";
	private String multiple = "false";
	private String[] selectedValues;
	private List selectedValueList;
	private Set selectedValueSet;
	private Collection values;
	private String label;
	private List fieldErrors;
	private Object errorAction = null;
	
    private boolean mandatory;

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
	          	errorMessage = "<span class=\"errorMessage\">" + fieldError + "</span>";
	        }
	    }	

	    StringBuffer sb = new StringBuffer();

	    sb.append("<div class=\"fieldrow\">");

	    if(this.label != null)
	        sb.append("<label for=\"" + this.name + "\">" + this.label + "</label>" + (mandatory ? "<span class=\"redstar\">*</span>" : "") + " " + errorMessage + "<br>");
		else
		    sb.append("<label for=\"" + this.name + "\">" + this.name + "</label>" + (mandatory ? "<span class=\"redstar\">*</span>" : "") + " " + errorMessage + "<br>");
			    
        sb.append("<select id=\"" + name + "\" name=\"" + name + "\" " + (multiple.equals("false") ? "" : "multiple=\"true\"") + " " + (size.equals("") ? "" : "size=\"" + size + "\"") + " class=\"" + cssClass + "\">");
        
        if(values != null)
        {
	        Iterator valuesIterator = values.iterator();
	        while(valuesIterator.hasNext())
		    {
	            String id;
	            String optionText;
	            Object obj = valuesIterator.next();
	            if(obj instanceof InfoGluePrincipal)
	            {
	                InfoGluePrincipal value = (InfoGluePrincipal)obj;
	                id = value.getName().toString();
	                optionText = value.getFirstName() + " " + value.getLastName();
	            } 
	            else if(obj instanceof InfoGlueRole)
	            {
	                InfoGlueRole value = (InfoGlueRole)obj;
	                id = value.getName().toString();
	                optionText = value.getName();
	            } 
	            else if(obj instanceof InfoGlueGroup)
	            {
	                InfoGlueGroup value = (InfoGlueGroup)obj;
	                id = value.getName().toString();
	                optionText = value.getName();
	            } 
	            else if(obj instanceof BaseEntity)
	            {
	                BaseEntity value = (BaseEntity)obj;
	                id = value.getId().toString();
	                optionText = value.getName();
	            }
	            else
	            {
	                String value = obj.toString();
	                id = value;
	                optionText = value;
	            }
	            
	            //System.out.println("Checking ID:" + id);
	            
	            String selected = "";
	            if(selectedValues != null)
	            {
	                //System.out.println("Comparing with selectedValues");
		            for(int i=0; i<selectedValues.length; i++)
		            {
		                if(id.equalsIgnoreCase(selectedValues[i]))
		                    selected = " selected=\"1\"";
		                else
		                    selected = "";
		            }
	            }
	            else if(selectedValueList != null)
	            {
	                //System.out.println("Comparing with selectedValueList");

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
	    	            else if(selObj instanceof InfoGlueRole)
	    	            {
	    	                InfoGlueRole value = (InfoGlueRole)selObj;
	    	                selId = value.getName().toString();
	    	            } 
	    	            else if(selObj instanceof InfoGlueGroup)
	    	            {
	    	                InfoGlueGroup value = (InfoGlueGroup)selObj;
	    	                selId = value.getName().toString();
	    	            } 
	    	            else if(selObj instanceof Role)
	    	            {
	    	                Role value = (Role)selObj;
	    	                selId = value.getName().toString();
	    	            } 
	    	            else if(selObj instanceof Group)
	    	            {
	    	                Group value = (Group)selObj;
	    	                selId = value.getName().toString();
	    	            }
	    	            else
	    	            {
	    	                BaseEntity selValue = (BaseEntity)selObj;
	    	                selId = selValue.getId().toString();
	    	            }
	    	            
	    	            log.info(id + "=" + selId);
		                if(id.equalsIgnoreCase(selId))
		                    selected = " selected=\"1\"";
		            }
	            }
	            else if(selectedValueSet != null)
	            {
	                //System.out.println("Comparing with selectedValueSet:" + selectedValueSet);

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
	    	            else if(selObj instanceof InfoGlueRole)
	    	            {
	    	                InfoGlueRole value = (InfoGlueRole)selObj;
	    	                selId = value.getName().toString();
	    	            } 
	    	            else if(selObj instanceof InfoGlueGroup)
	    	            {
	    	                InfoGlueGroup value = (InfoGlueGroup)selObj;
	    	                selId = value.getName().toString();
	    	            } 
	    	            else if(selObj instanceof Role)
	    	            {
	    	                Role value = (Role)selObj;
		                	selId = value.getName().toString();
	    	            } 
	    	            else if(selObj instanceof Group)
	    	            {
	    	                Group value = (Group)selObj;
	    	                selId = value.getName().toString();
	    	            }
	    	            else
	    	            {
	    	                BaseEntity selValue = (BaseEntity)selObj;
	    	                selId = selValue.getId().toString();
	    	            }
	    	            
	                	//System.out.println(id + "=" + selId);
		                if(id.equalsIgnoreCase(selId))
		                    selected = " selected=\"1\"";
		            }
	            }
	            
	            sb.append("<option value=\"" + id + "\"" + selected + ">" + optionText + "</option>");
	        }
        }
        sb.append("</select>");
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
        Object o = findOnValueStack(name);
        String evaluatedString = evaluateString("SelectFieldTag", "name", name);
        log.info("o:" + o);
        log.info("evaluatedString:" + evaluatedString);
        log.warn("O:" + o);
        if(o != null && !(o instanceof String[]))
            this.name = o.toString();
        else if(evaluatedString != null && !evaluatedString.equals(name))
            this.name = evaluatedString;
        else
        {
            this.name = name;
        }
    }

    public void setLabel(String rawLabel) throws JspException
    {
        Object o = findOnValueStack(rawLabel);
        String evaluatedString = evaluateString("SelectFieldTag", "label", rawLabel);
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

    public void setMultiple(String multiple)
    {
        this.multiple = multiple;
    }

    public void setSelectedValues(String selectedValues) throws JspException
    {
        this.selectedValues = evaluateStringArray("SelectTag", "selectedValues", selectedValues);
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

    public void setValue(String value) throws JspException
    {
        Object o = findOnValueStack(value);
        if(o != null)
        {
            this.values = (Collection)o;
        }
        else
            this.selectedValues = null;
        
        //this.values = evaluateList("SelectTag", "values", values);
    }

    public void setSelectedValueList(String value) throws JspException
    {
        log.info("setSelectedValueList VALUE:" + value);
        Object o = findOnValueStack(value);
        log.info("o in setSelectedValueList: " + o);
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
        log.info("setSelectedValueSet VALUE:" + value);
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

    
    public void setSize(String size)
    {
        this.size = size;
    }
    public void setLabelCssClass(String labelCssClass)
    {
        this.labelCssClass = labelCssClass;
    }
    
    public void setMandatory(boolean mandatory)
    {
        this.mandatory = mandatory;
    }
}
