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
import com.sun.rsasign.j;

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
    
    private java.util.Calendar startCalendar = null;
    private java.util.Calendar endCalendar = null;
    
    private Calendar calendar;
    private List events;
    private List dates;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        this.calendar = CalendarController.getController().getCalendar(calendarId);
        
        this.startCalendar = super.getCalendar(startDateTime, "yyyy-MM-dd", new Integer(0));
        this.endCalendar   = super.getCalendar(endDateTime, "yyyy-MM-dd", new Integer(23));
        System.out.println("startDateTime:" + startDateTime);
        System.out.println("startCalendar:" + startCalendar.getTime());
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new Date(startCalendar.getTime().getTime()));
        
        this.events = EventController.getController().getEventList(calendarId, startCalendar, endCalendar);
        this.dates = getDateList(calendar);
            
        System.out.println("startCalendar:" + startCalendar.getTime());
        
        return Action.SUCCESS;
    } 

    /**
     * Gets all dates that should be shown
     * @param hour
     * @return
     */
    
    private List getDateList(java.util.Calendar calendar)
    {
        System.out.println("DAY_OF_WEEK: " + calendar.get(java.util.Calendar.DAY_OF_WEEK));
        System.out.println("DAY_OF_WEEK_IN_MONTH: " + calendar.get(java.util.Calendar.DAY_OF_WEEK_IN_MONTH));
        System.out.println("DATE:" + startCalendar.getTime());
        calendar.set(java.util.Calendar.DAY_OF_WEEK, java.util.Calendar.MONDAY);
        calendar.set(java.util.Calendar.HOUR_OF_DAY, 12);
        System.out.println("DAY_OF_WEEK: " + calendar.get(java.util.Calendar.DAY_OF_WEEK));
        System.out.println("DAY_OF_WEEK_IN_MONTH: " + startCalendar.get(java.util.Calendar.DAY_OF_WEEK_IN_MONTH));
        System.out.println("DATE:" + calendar.getTime());
           
        List dateList = new ArrayList();
        for(int i=0; i<7; i++)
        {
            System.out.println("DATE:" + calendar.getTime());
            dateList.add(calendar.getTime());
            calendar.add(java.util.Calendar.DAY_OF_YEAR, 1);
        }
        
        return dateList;
    }
    
    /**
     * 
     * @param hour
     * @return
     */

    public List getEvents(Date date, String hour)
    {
        System.out.println("getEvents with hour:" + date + ":" + hour);
        List hourEvents = new ArrayList();
        
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(date);
        
        Iterator eventIterator = this.events.iterator();
        while(eventIterator.hasNext())
        {
            Event event = (Event)eventIterator.next();
            if(mode.equalsIgnoreCase("day") && event.getStartDateTime().get(java.util.Calendar.DAY_OF_YEAR) == calendar.get(java.util.Calendar.DAY_OF_YEAR) && event.getStartDateTime().get(java.util.Calendar.HOUR_OF_DAY) == Integer.parseInt(hour))
            {
                hourEvents.add(event);
            }
        }
        
        //System.out.println("returning:" + hourEvents.size());
        
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

    public String getFormattedDate(Date date, String pattern)
    {
        return this.formatDate(date, pattern);
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
    
    public List getDates()
    {
        return dates;
    }
        
    public java.util.Calendar getStartCalendar()
    {
        return startCalendar;
    }

    public java.util.Calendar getEndCalendar()
    {
        return endCalendar;
    }
}
