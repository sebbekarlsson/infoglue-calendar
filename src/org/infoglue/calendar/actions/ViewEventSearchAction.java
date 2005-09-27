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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.EntryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.controllers.ResourceController;
import org.infoglue.calendar.entities.Entry;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Location;

import com.opensymphony.xwork.Action;

/**
 * This action represents a Location Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEventSearchAction extends CalendarAbstractAction
{
    private String name;
    private String startDateTime;
    private String endDateTime;
    private Integer startTime;
    private Integer endTime;
    private String organizerName;
    private String customLocation;
    private String contactName;
    private String contactEmail;
    private String contactPhone;
    private Float price = null;
    private Integer maximumParticipants = null;
    
    private Calendar startCalendar;
    private Calendar endCalendar;

    private List events;
    
    private void initialize() throws Exception
    {
    }
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception
    {
        if(startDateTime != null && startDateTime.length() > 0)
            startCalendar = getCalendar(startDateTime, "yyyy-MM-dd", startTime); 
        
        if(endDateTime != null && endDateTime.length() > 0)
            endCalendar = getCalendar(endDateTime, "yyyy-MM-dd", endTime); 

        System.out.println("price:" + price);
        
        this.events = EventController.getController().getEventList(name,
                													startCalendar,
                													endCalendar,
                													organizerName,
															        customLocation,
															        contactName,
															        contactEmail,
															        contactPhone,
															        price,
															        maximumParticipants,
															        getSession());
        
        
        return Action.SUCCESS;
    } 

    /**
     * This is the entry point for the search form.
     */
    
    public String doInput() throws Exception 
    {
        initialize();

        return Action.INPUT;
    } 

    
    public List getEvents()
    {
        return events;
    }
    
    public String getContactEmail()
    {
        return contactEmail;
    }
    
    public void setContactEmail(String contactEmail)
    {
        this.contactEmail = contactEmail;
    }
    
    public String getContactName()
    {
        return contactName;
    }
    
    public void setContactName(String contactName)
    {
        this.contactName = contactName;
    }
    
    public String getContactPhone()
    {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone)
    {
        this.contactPhone = contactPhone;
    }
    
    public String getCustomLocation()
    {
        return customLocation;
    }
    
    public void setCustomLocation(String customLocation)
    {
        this.customLocation = customLocation;
    }
    
    public String getEndDateTime()
    {
        return endDateTime;
    }
    
    public void setEndDateTime(String endDateTime)
    {
        this.endDateTime = endDateTime;
    }
    
    public Integer getEndTime()
    {
        return endTime;
    }
    
    public void setEndTime(Integer endTime)
    {
        this.endTime = endTime;
    }
    
    public Integer getMaximumParticipants()
    {
        return maximumParticipants;
    }
    
    public void setMaximumParticipants(Integer maximumParticipants)
    {
        this.maximumParticipants = maximumParticipants;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getOrganizerName()
    {
        return organizerName;
    }
    
    public void setOrganizerName(String organizerName)
    {
        this.organizerName = organizerName;
    }
    
    public Float getPrice()
    {
        return price;
    }
    
    public void setPrice(Float price)
    {
        System.out.println("price:" + price);

        this.price = price;
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
    
    public void setEvents(List events)
    {
        this.events = events;
    }
}

