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

import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.portlet.PortletURL;

import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.databeans.AdministrationUCCBean;
import org.infoglue.calendar.usecasecontroller.CalendarAdministrationUCCController;
import org.infoglue.common.util.DBSessionWrapper;

import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class CreateEventAction extends CalendarAbstractAction
{
    private String name;
    private String description;
    private String startDateTime;
    private String endDateTime;
    private Integer startTime;
    private Integer endTime;
    private String[] locationId;
    private String[] categoryId;
    private String[] participantUserName;
    
    private String date;
    private String time;
    private String mode;
    private Long calendarId;
    
    private List locations;
    private List categories;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        /*
        System.out.println("****************************");
        System.out.println("*      getContextMap       *");
        System.out.println("****************************");
        Iterator requestIterator = ActionContext.getContext().getContextMap().keySet().iterator();
        while(requestIterator.hasNext())
        {
            Object key = (Object)requestIterator.next();
            Object value = (Object)ActionContext.getContext().getContextMap().get(key);
            System.out.println("" + key + "=" + value);
            
        }
        System.out.println("calendarId:" + ActionContext.getContext().getContextMap().get("calendarId"));

        System.out.println("****************************");
        System.out.println("*      PARAMETERS          *");
        System.out.println("****************************");
        
        requestIterator = ActionContext.getContext().getParameters().keySet().iterator();
        while(requestIterator.hasNext())
        {
            Object key = (Object)requestIterator.next();
            Object value = (Object)ActionContext.getContext().getParameters().get(key);
            System.out.println("" + key + "=" + value);
            
        }

        System.out.println("calendarId:" + calendarId);
        System.out.println("name:" + name);
        System.out.println("description:" + description);
        System.out.println("startCalendar:" + startDateTime);
        System.out.println("endCalendar:" + endDateTime);

        System.out.println("calendarId:" + ActionContext.getContext().getParameters().get("calendarId"));
        System.out.println("****************************");
        */
        
        Calendar startCalendar 	= getCalendar(startDateTime, "yyyy-MM-dd", startTime); 
        Calendar endCalendar 	= getCalendar(endDateTime, "yyyy-MM-dd", endTime); 
        
        
        EventController.getController().createEvent(calendarId, name, description, startCalendar, endCalendar, locationId, categoryId, participantUserName);
        
        return Action.SUCCESS;
    } 

    /**
     * This is the entry point creating a new calendar.
     */
    
    public String input() throws Exception 
    {
        this.locations 	= LocationController.getController().getLocationList();
        this.categories = CategoryController.getController().getCategoryList();
        
        return Action.INPUT;
    } 
    
    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public Long getCalendarId()
    {
        return calendarId;
    }
    
    public void setCalendarId(Long calendarId)
    {
        this.calendarId = calendarId;
    }
    
    public String getDate()
    {
        return date;
    }
    
    public void setDate(String date)
    {
        this.date = date;
    }
    
    public String getEndDateTime()
    {
        return endDateTime;
    }
    
    public void setEndDateTime(String endDateTime)
    {
        this.endDateTime = endDateTime;
    }
    
    public String getMode()
    {
        return mode;
    }
    
    public void setMode(String mode)
    {
        this.mode = mode;
    }
    
    public String getStartDateTime()
    {
        return startDateTime;
    }
    
    public void setStartDateTime(String startDateTime)
    {
        this.startDateTime = startDateTime;
    }
    
    public Integer getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(Integer startTime)
    {
        this.startTime = startTime;
    }
    
    public String getTime()
    {
        return time;
    }
    
    public void setTime(String time)
    {
        this.time = time;
    }
    
    public Integer getEndTime()
    {
        return endTime;
    }
    
    public void setEndTime(Integer endTime)
    {
        this.endTime = endTime;
    }
    
    public List getCategories()
    {
        return categories;
    }
    
    public List getLocations()
    {
        return locations;
    }
    
    public void setCategoryId(String[] categoryId)
    {
        this.categoryId = categoryId;
    }
    
    public void setLocationId(String[] locationId)
    {
        this.locationId = locationId;
    }
    
    public void setParticipantUserName(String[] participantUserName)
    {
        this.participantUserName = participantUserName;
    }
}
