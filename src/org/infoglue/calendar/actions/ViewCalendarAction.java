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

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.portlet.PortletURL;

import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.databeans.AdministrationUCCBean;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.usecasecontroller.CalendarAdministrationUCCController;
import org.infoglue.common.util.DBSessionWrapper;

import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewCalendarAction extends CalendarAbstractAction
{
    private Long calendarId;
    private String mode;
    private String selectedFormattedDate;
    private String startDateTime;
    private String endDateTime;
    
    private Calendar calendar;
    private List events;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        this.calendar = CalendarController.getController().getCalendar(calendarId);
        
        java.util.Calendar startCalendar = super.getCalendar(startDateTime, "yyyy-MM-dd", new Integer(0));
        java.util.Calendar endCalendar 	 = super.getCalendar(endDateTime, "yyyy-MM-dd", new Integer(23));
        
        this.events = EventController.getController().getEventList(calendarId, startCalendar, endCalendar);
        
        return Action.SUCCESS;
    } 

    /**
     * 
     * @param hour
     * @return
     */

    public List getEvents(String hour)
    {
        System.out.println("getEvents with hour:" + hour);
        List hourEvents = new ArrayList();
        
        Iterator eventIterator = this.events.iterator();
        while(eventIterator.hasNext())
        {
            Event event = (Event)eventIterator.next();
            if(mode.equalsIgnoreCase("day") && event.getStartDateTime().get(java.util.Calendar.HOUR_OF_DAY) == Integer.parseInt(hour))
            {
                hourEvents.add(event);
            }
        }
        
        System.out.println("returning:" + hourEvents.size());
        
        return hourEvents;
    }
    
    public Long getCalendarId()
    {
        return calendarId;
    }
    
    public void setCalendarId(Long calendarId)
    {
        this.calendarId = calendarId;
    }

    public Calendar getCalendar()
    {
        return calendar;
    }

    public String getMode()
    {
        return mode;
    }
    
    public void setMode(String mode)
    {
        this.mode = mode;
    }

    public String getFormattedStartDate()
    {
        Date parsedDate = this.parseDate(startDateTime, "yyyy-MM-dd");
        
        return this.formatDate(parsedDate, "yyyy/MM/dd");
    }

    public String getFormattedEndDate()
    {
        Date parsedDate = this.parseDate(endDateTime, "yyyy-MM-dd");
        
        return this.formatDate(parsedDate, "yyyy/MM/dd");
    }
    
    public String getFormattedDate(String date, String pattern)
    {
        Date parsedDate = this.parseDate(date, "yyyy-MM-dd");
        
        return this.formatDate(parsedDate, pattern);
    }

    public String getEndDateTime()
    {
        return endDateTime;
    }
    
    public void setEndDateTime(String endDateTime)
    {
        this.endDateTime = endDateTime;
    }
    
    public List getEvents()
    {
        return events;
    }
    
    public void setEvents(List events)
    {
        this.events = events;
    }
    
    public String getStartDateTime()
    {
        return startDateTime;
    }
    
    public void setStartDateTime(String startDateTime)
    {
        this.startDateTime = startDateTime;
    }
}
