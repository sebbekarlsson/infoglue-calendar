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

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.portlet.PortletResponse;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.ActionSupport;

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

    
}

