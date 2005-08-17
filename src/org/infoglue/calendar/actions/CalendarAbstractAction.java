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

package org.infoglue.calendar.actions;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.portlet.PortletResponse;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.infoglue.calendar.controllers.ICalendarController;
import org.infoglue.calendar.controllers.ParticipantController;
import org.infoglue.calendar.controllers.ResourceController;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Participant;
import org.infoglue.common.exceptions.ConstraintException;
import org.infoglue.common.util.ActionValidatorManager;
import org.infoglue.common.util.PropertyHelper;
import org.infoglue.common.util.ResourceBundleHelper;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.ActionSupport;
import com.opensymphony.xwork.validator.ValidationException;

/**
* @author Mattias Bogeblad
*
* This is an abstract action used for all calendar actions.
*  Just to not have to put to much in the WebworkAbstractAction.
*/

public abstract class CalendarAbstractAction extends ActionSupport
{
   
	/**
	 * This method lets the velocity template get hold of all actions inheriting.
	 * 
	 * @return The action object currently invoked 
	 */
	
	public CalendarAbstractAction getThis()
	{
		return this;
	}

    public Integer getComponentId()
    {
        return (Integer)ServletActionContext.getRequest().getAttribute("componentId");
    }

    public String getLanguageCode()
    {
        return (String)ServletActionContext.getRequest().getAttribute("languageCode");
    }

    public String getInfoGlueRemoteUser()
    {
        return (String)ServletActionContext.getRequest().getAttribute("infoglueRemoteUser");
    }

    public String formatDate(Date date, String pattern, Locale locale)
    {	
    	if(date == null)
            return "";
     
        // Format the current time.
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
        String dateString = formatter.format(date);

        return dateString;
    }
    
    public Date parseDate(String dateString, String pattern, Locale locale)
    {	
        if(dateString == null)
            return new Date();
        
        Date date = new Date();    
        
        try
        {
	        // Format the current time.
	        SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
	        date = formatter.parse(dateString);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return date;
    }

    public String formatDate(Date date, String pattern)
    {	
    	if(date == null)
            return "";
     
        // Format the current time.
        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
        String dateString = formatter.format(date);

        return dateString;
    }
    
    public Date parseDate(String dateString, String pattern)
    {	
        if(dateString == null)
            return new Date();
        
        Date date = new Date();    
        
        try
        {
	        // Format the current time.
	        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
	        date = formatter.parse(dateString);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return date;
    }

    /**
     * Gets a calendar object with date and hour
     * 
     * @param dateString
     * @param pattern
     * @param hour
     * @return
     */
    
    public Calendar getCalendar(String dateString, String pattern, Integer hour)
    {	
        Calendar calendar = Calendar.getInstance();
        if(dateString == null)
        {
            calendar.set(Calendar.HOUR_OF_DAY, hour.intValue());
            return calendar;
        }
        
        Date date = new Date();    
        
        try
        {
	        // Format the current time.
	        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
	        date = formatter.parse(dateString);
	        calendar.setTime(date);
	        calendar.set(Calendar.HOUR_OF_DAY, hour.intValue());
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return calendar;
    }

    
    public String getVCalendar(Long eventId) throws Exception
    {
        return ICalendarController.getICalendarController().getICalendarUrl(eventId);
    }
    
    public String getResourceUrl(Long resourceId) throws Exception
    {
        return ResourceController.getController().getResourceUrl(resourceId);
    }
      
    public Participant getParticipant(Long participantId) throws Exception
    {
        return ParticipantController.getController().getParticipant(participantId);
    }
    
    public void validateInput(CalendarAbstractAction action) throws ValidationException
    {
        String context = ActionContext.getContext().getName();
        ActionValidatorManager.validate(this, context);
        if(this.getFieldErrors() != null && this.getFieldErrors().size() > 0)
        {
            ActionContext.getContext().getValueStack().getContext().put("actionErrors", this.getActionErrors());
            ActionContext.getContext().getValueStack().getContext().put("fieldErrors", this.getFieldErrors());
            ActionContext.getContext().getValueStack().getContext().put("errorAction", this);
            throw new ValidationException("An validation error occurred - more information is in the valuestack...");
        }
    }
    
    public boolean useEventPublishing()
    {
        String useEventPublishing = PropertyHelper.getProperty("useEventPublishing");
        
        return (useEventPublishing.equalsIgnoreCase("true") ? true : false);
    }

    public boolean useEntryLimitation()
    {
        String useEntryLimitation = PropertyHelper.getProperty("useEntryLimitation");
        
        return (useEntryLimitation.equalsIgnoreCase("true") ? true : false);
    }
    
    public String getLabel(String key)
    {
        String label = key;
	    
	    try
	    {
	    	Locale locale = new Locale(this.getLanguageCode());
	    	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
	        
	        label = resourceBundle.getString(key);
	        if(label == null || label.equals(""))
	            label = key;
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	        System.out.println("Problem but nothing important...:" + key);
	    }
	    
	    return label;
    }
}

