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

import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Event;
import org.infoglue.common.security.UserControllerProxy;

import com.opensymphony.xwork.Action;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewCalendarAction extends CalendarAbstractAction
{
    private Integer componentId;
    private Long calendarId;
    private String mode;
    private String selectedFormattedDate;
    private String startDateTime;
    private String endDateTime;
    
    private java.util.Calendar startCalendar = null;
    private java.util.Calendar endCalendar = null;
    
    private Calendar calendar;
    private List events;
    private List weekEvents;
    private List monthEvents;
    private List dates;
    
    private List infogluePrincipals;

    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        this.componentId = getComponentId();
        System.out.println("****************************");
        System.out.println("calendarId:" + calendarId);
        System.out.println("componentId:" + componentId);
        System.out.println("startDateTime:" + startDateTime);
        System.out.println("endDateTime:" + endDateTime);
        System.out.println("mode:" + mode);
        System.out.println("****************************");
        this.calendar = CalendarController.getController().getCalendar(calendarId);
        
        this.startCalendar = super.getCalendar(startDateTime, "yyyy-MM-dd", new Integer(0));
        this.endCalendar   = super.getCalendar(endDateTime, "yyyy-MM-dd", new Integer(23));
        //System.out.println("startDateTime:" + startDateTime);
        //System.out.println("startCalendar:" + startCalendar.getTime());
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new Date(startCalendar.getTime().getTime()));

        java.util.Calendar monthStartCalendar = java.util.Calendar.getInstance();
        monthStartCalendar.setTime(new Date(startCalendar.getTime().getTime()));
        monthStartCalendar.set(java.util.Calendar.DAY_OF_MONTH, 1);
        monthStartCalendar.set(java.util.Calendar.HOUR_OF_DAY, 0);
        monthStartCalendar.set(java.util.Calendar.MINUTE, 0);
        monthStartCalendar.set(java.util.Calendar.SECOND, 0);
        monthStartCalendar.set(java.util.Calendar.MILLISECOND, 0);
        System.out.println("monthStartCalendar:" + monthStartCalendar.getTime());
        
        java.util.Calendar monthEndCalendar = java.util.Calendar.getInstance();
        monthEndCalendar.setTime(new Date(startCalendar.getTime().getTime()));
        monthEndCalendar.set(java.util.Calendar.DAY_OF_MONTH, monthEndCalendar.getActualMaximum(java.util.Calendar.DAY_OF_MONTH) );
        monthEndCalendar.set(java.util.Calendar.HOUR_OF_DAY, 23);
        monthEndCalendar.set(java.util.Calendar.MINUTE, 59);
        monthEndCalendar.set(java.util.Calendar.SECOND, 59);
        monthEndCalendar.set(java.util.Calendar.MILLISECOND, 999);
        System.out.println("monthEndCalendar:" + monthEndCalendar.getTime());

        java.util.Calendar weekStartCalendar = java.util.Calendar.getInstance();
        weekStartCalendar.setTime(new Date(startCalendar.getTime().getTime()));
        weekStartCalendar.set(java.util.Calendar.DAY_OF_WEEK, java.util.Calendar.MONDAY);
        weekStartCalendar.set(java.util.Calendar.HOUR_OF_DAY, 0);
        weekStartCalendar.set(java.util.Calendar.MINUTE, 0);
        weekStartCalendar.set(java.util.Calendar.SECOND, 0);
        weekStartCalendar.set(java.util.Calendar.MILLISECOND, 0);
        
        java.util.Calendar weekEndCalendar = java.util.Calendar.getInstance();
        weekEndCalendar.setTime(new Date(startCalendar.getTime().getTime()));
        weekEndCalendar.set(java.util.Calendar.DAY_OF_WEEK, weekEndCalendar.getActualMaximum(java.util.Calendar.DAY_OF_WEEK));
        weekEndCalendar.set(java.util.Calendar.HOUR_OF_DAY, 23);
        weekEndCalendar.set(java.util.Calendar.MINUTE, 59);
        weekEndCalendar.set(java.util.Calendar.SECOND, 59);
        weekEndCalendar.set(java.util.Calendar.MILLISECOND, 999);

        //System.out.println("DAY_OF_WEEK: " + weekStartCalendar.get(java.util.Calendar.DAY_OF_WEEK));
        //System.out.println("DAY_OF_WEEK_IN_MONTH: " + weekStartCalendar.get(java.util.Calendar.DAY_OF_WEEK_IN_MONTH));
        //System.out.println("DATE:" + weekStartCalendar.getTime());
        //System.out.println("DAY_OF_WEEK: " + weekEndCalendar.get(java.util.Calendar.DAY_OF_WEEK));
        //System.out.println("DAY_OF_WEEK_IN_MONTH: " + weekEndCalendar.get(java.util.Calendar.DAY_OF_WEEK_IN_MONTH));
        //System.out.println("DATE:" + weekEndCalendar.getTime());

        //System.out.println("weekStartCalendar:" + weekStartCalendar.getTime());
        //System.out.println("weekEndCalendar:" + weekEndCalendar.getTime());

        
        this.events = EventController.getController().getEventList(calendarId, startCalendar, endCalendar);
        this.weekEvents = EventController.getController().getEventList(calendarId, weekStartCalendar, weekEndCalendar);
        this.monthEvents = EventController.getController().getEventList(calendarId, monthStartCalendar, monthEndCalendar);
        this.dates = getDateList(calendar);
            
        this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();

        System.out.println("startCalendar:" + startCalendar.getTime());
        
        return Action.SUCCESS;
    } 

    public String doPublic() throws Exception 
    {
        this.execute();
        return "successPublic";
    }
    
    /**
     * Gets all dates that should be shown
     * @param hour
     * @return
     */
    
    private List getDateList(java.util.Calendar calendar)
    {
        //System.out.println("DAY_OF_WEEK: " + calendar.get(java.util.Calendar.DAY_OF_WEEK));
        //System.out.println("DAY_OF_WEEK_IN_MONTH: " + calendar.get(java.util.Calendar.DAY_OF_WEEK_IN_MONTH));
        //System.out.println("DATE:" + calendar.getTime());
        calendar.set(java.util.Calendar.DAY_OF_WEEK, java.util.Calendar.MONDAY);
        calendar.set(java.util.Calendar.HOUR_OF_DAY, 12);
        //System.out.println("DAY_OF_WEEK: " + calendar.get(java.util.Calendar.DAY_OF_WEEK));
        //System.out.println("DAY_OF_WEEK_IN_MONTH: " + calendar.get(java.util.Calendar.DAY_OF_WEEK_IN_MONTH));
        //System.out.println("DATE:" + calendar.getTime());
           
        List dateList = new ArrayList();
        for(int i=0; i<7; i++)
        {
            //System.out.println("DATE:" + calendar.getTime());
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
        List hourEvents = new ArrayList();
        
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(date);
        
        Iterator eventIterator = this.events.iterator();
        while(eventIterator.hasNext())
        {
            Event event = (Event)eventIterator.next();
            //System.out.println("event:" + event.getName());
            if(event.getStartDateTime().get(java.util.Calendar.DAY_OF_YEAR) == calendar.get(java.util.Calendar.DAY_OF_YEAR) && (event.getStartDateTime().get(java.util.Calendar.HOUR_OF_DAY) <= Integer.parseInt(hour) && event.getEndDateTime().get(java.util.Calendar.HOUR_OF_DAY) >= Integer.parseInt(hour)))
            {
                hourEvents.add(event);
            }
        }
        
        /*
        if(hourEvents.size() > 0)
        {
            System.out.println("getEvents with hour:" + date + ":" + hour);
            System.out.println("returning:" + hourEvents.size());
        }
        */
        
        return hourEvents;
    }

    
    /**
     * 
     * @param hour
     * @return
     */

    public List getWeekEvents(Date date, String hour)
    {
        List hourEvents = new ArrayList();
        
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(date);
        
        //System.out.println("this.weekEvents:" + this.weekEvents.size());
        
        Iterator eventIterator = this.weekEvents.iterator();
        while(eventIterator.hasNext())
        {
            Event event = (Event)eventIterator.next();
            //System.out.println("event:" + event.getName());
            if(event.getStartDateTime().get(java.util.Calendar.DAY_OF_YEAR) == calendar.get(java.util.Calendar.DAY_OF_YEAR) && (event.getStartDateTime().get(java.util.Calendar.HOUR_OF_DAY) <= Integer.parseInt(hour) && event.getEndDateTime().get(java.util.Calendar.HOUR_OF_DAY) >= Integer.parseInt(hour)))
            {
                hourEvents.add(event);
            }
        }
        
        return hourEvents;
    }
    
    /**
     * 
     * @param hour
     * @return
     */

    public List getMonthEvents(Date date)
    {
        List hourEvents = new ArrayList();
        
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(date);
        
        Iterator eventIterator = this.monthEvents.iterator();
        while(eventIterator.hasNext())
        {
            Event event = (Event)eventIterator.next();
            //System.out.println("event:" + event.getName());
            if(event.getStartDateTime().get(java.util.Calendar.DAY_OF_YEAR) == calendar.get(java.util.Calendar.DAY_OF_YEAR))
            {
                hourEvents.add(event);
            }
        }
        
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

    public void setCalendarId(String calendarId)
    {
        System.out.println("calendarId in String" + calendarId);
        this.calendarId = new Long(calendarId);
    }

    public void setCalendarId(String[] calendarId)
    {
        System.out.println("calendarId in String[]" + calendarId[0]);
        this.calendarId = new Long(calendarId[0]);
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
    
    public List getInfogluePrincipals()
    {
        return infogluePrincipals;
    }
}
