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
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.entities.Event;
import org.infoglue.cms.controllers.kernel.impl.simple.UserControllerProxy;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.validator.ValidationException;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class CreateEventAction extends CalendarAbstractAction
{
	private static Log log = LogFactory.getLog(CreateEventAction.class);

    //private Map dataBean = new HashMap();

    private String name;
    private String description;
    private String startDateTime;
    private String endDateTime;
    private Integer startTime;
    private Integer endTime;

    private Boolean isInternal = new Boolean(false);
    private Boolean isOrganizedByGU = new Boolean(false);
    private String organizerName;
    private String lecturer;
    private String customLocation;
    private String shortDescription;
    private String longDescription;
    private String eventUrl;
    private String contactName;
    private String contactEmail;
    private String contactPhone;
    private Float price;
    private String lastRegistrationDateTime;
    private Integer lastRegistrationTime;
    private Integer maximumParticipants;
    
    private String[] locationId;
    private String[] categoryId;
    private String[] participantUserName;
    
    private String date;
    private String time;
    private String mode;
    private Long calendarId;
    
    private org.infoglue.calendar.entities.Calendar calendar;
    private List locations;
    //private List categories;
    private Map categoryAttributes = new HashMap();
    private List infogluePrincipals;
        
    private Calendar startCalendar;
    private Calendar endCalendar;
    private Calendar lastRegistrationCalendar;
    
    private Event newEvent = null;
        
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        startCalendar 	= getCalendar(startDateTime, "yyyy-MM-dd", startTime); 
        endCalendar 	= getCalendar(endDateTime, "yyyy-MM-dd", endTime); 
        lastRegistrationCalendar = getCalendar(lastRegistrationDateTime, "yyyy-MM-dd", lastRegistrationTime); 

        log.info("isInternal:" + this.isInternal);

        try
        {
            int i = 0;
            String idKey = ServletActionContext.getRequest().getParameter("categoryAttributeId_" + i);
            log.info("idKey:" + idKey);
            while(idKey != null && idKey.length() > 0)
            {
                String[] categoryIds = ServletActionContext.getRequest().getParameterValues("categoryAttribute_" + idKey + "_categoryId");
                log.info("categoryIds:" + categoryIds);
                categoryAttributes.put(idKey, categoryIds);
                
                i++;
                idKey = ServletActionContext.getRequest().getParameter("categoryAttributeId_" + i);
                log.info("idKey:" + idKey);
            }

            validateInput(this);
            
            Integer stateId = Event.STATE_PUBLISHED;
            if(useEventPublishing())
                stateId = Event.STATE_WORKING;
                        
            newEvent = EventController.getController().createEvent(calendarId,
									                    name, 
									                    description,
									                    isInternal, 
									                    isOrganizedByGU, 
									                    organizerName, 
									                    lecturer, 
									                    customLocation,
									                    shortDescription,
									                    longDescription,
									                    eventUrl,
									                    contactName,
									                    contactEmail,
									                    contactPhone,
									                    price,
									                    lastRegistrationCalendar,
									                    maximumParticipants,
									                    startCalendar, 
									                    endCalendar, 
									                    locationId, 
									                    categoryAttributes, 
									                    participantUserName,
									                    stateId,
									                    this.getInfoGlueRemoteUser(),
									                    getSession());

        }
        catch(ValidationException e)
        {
            log.error("An validation error occcurred:" + e.getMessage(), e);
            return Action.ERROR;            

        }

        return Action.SUCCESS;
    } 

    
    /**
     * Creates an event by copying an old one
     */
    
    public String copy() throws Exception 
    {
        startCalendar 	= getCalendar(startDateTime, "yyyy-MM-dd", startTime); 
        endCalendar 	= getCalendar(endDateTime, "yyyy-MM-dd", endTime); 
        lastRegistrationCalendar = getCalendar(lastRegistrationDateTime, "yyyy-MM-dd", lastRegistrationTime); 
   
        log.info("isInternal:" + this.isInternal);
        try
        {
            int i = 0;
            String idKey = ServletActionContext.getRequest().getParameter("categoryAttributeId_" + i);
            log.info("idKey:" + idKey);
            while(idKey != null && idKey.length() > 0)
            {
                String[] categoryIds = ServletActionContext.getRequest().getParameterValues("categoryAttribute_" + idKey + "_categoryId");
                log.info("categoryIds:" + categoryIds);
                categoryAttributes.put(idKey, categoryIds);
                
                i++;
                idKey = ServletActionContext.getRequest().getParameter("categoryAttributeId_" + i);
                log.info("idKey:" + idKey);
            }
            
            validateInput(this);
            
            Integer stateId = Event.STATE_PUBLISHED;
            if(useEventPublishing())
                stateId = Event.STATE_WORKING;
            
            newEvent = EventController.getController().createEvent(calendarId,
									                    name, 
									                    description,
									                    isInternal, 
									                    isOrganizedByGU, 
									                    organizerName, 
									                    lecturer, 
									                    customLocation,
									                    shortDescription,
									                    longDescription,
									                    eventUrl,
									                    contactName,
									                    contactEmail,
									                    contactPhone,
									                    price,
									                    lastRegistrationCalendar,
									                    maximumParticipants,
									                    startCalendar, 
									                    endCalendar, 
									                    locationId, 
									                    categoryAttributes, 
									                    participantUserName,
									                    stateId,
									                    this.getInfoGlueRemoteUser(),
									                    getSession());

            
        }
        catch(ValidationException e)
        {
            log.error("An validation error occcurred:" + e.getMessage(), e);
            return Action.ERROR;            

        }
        
        return Action.SUCCESS;
    } 
    
    /**
     * This is the entry point creating a new calendar.
     */
    
    public String input() throws Exception 
    {
        this.calendar = CalendarController.getController().getCalendar(this.calendarId, getSession());
        this.locations 	= LocationController.getController().getLocationList(getSession());
        //this.categories = CategoryController.getController().getRootCategoryList(getSession());
        this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();
            
        return Action.INPUT;
    } 
    
    public Long getCalendarId()
    {
        return calendarId;
    }
    
    public void setCalendarId(Long calendarId)
    {
        this.calendarId = calendarId;
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
    public String getEventUrl()
    {
        return eventUrl;
    }
    public void setEventUrl(String eventUrl)
    {
        this.eventUrl = eventUrl;
    }
    public Boolean getIsInternal()
    {
        return isInternal;
    }
    public void setIsInternal(Boolean isInternal)
    {
        this.isInternal = isInternal;
    }
    public Boolean getIsOrganizedByGU()
    {
        return isOrganizedByGU;
    }
    public void setIsOrganizedByGU(Boolean isOrganizedByGU)
    {
        this.isOrganizedByGU = isOrganizedByGU;
    }
    public String getLastRegistrationDateTime()
    {
        return lastRegistrationDateTime;
    }
    public void setLastRegistrationDateTime(String lastRegistrationDateTime)
    {
        this.lastRegistrationDateTime = lastRegistrationDateTime;
    }
    public String getLecturer()
    {
        return lecturer;
    }
    public void setLecturer(String lecturer)
    {
        this.lecturer = lecturer;
    }
    public String getLongDescription()
    {
        return longDescription;
    }
    public void setLongDescription(String longDescription)
    {
        this.longDescription = longDescription;
    }
    public Integer getMaximumParticipants()
    {
        return maximumParticipants;
    }
    public void setMaximumParticipants(Integer maximumParticipants)
    {
        this.maximumParticipants = maximumParticipants;
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
        this.price = price;
    }
    public String getShortDescription()
    {
        return shortDescription;
    }
    public void setShortDescription(String shortDescription)
    {
        this.shortDescription = shortDescription;
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
    /*
    public List getCategories()
    {
        return categories;
    }
    */
    
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
    
    public List getInfogluePrincipals()
    {
        return infogluePrincipals;
    }
    
    public void setInfogluePrincipals(List infogluePrincipals)
    {
        this.infogluePrincipals = infogluePrincipals;
    }
    
    public String[] getCategoryId()
    {
        return categoryId;
    }
    
    public String[] getLocationId()
    {
        return locationId;
    }
    
    public String[] getParticipantUserName()
    {
        return participantUserName;
    }
    
    public Calendar getEndCalendar()
    {
        return endCalendar;
    }
    public Calendar getLastRegistrationCalendar()
    {
        return lastRegistrationCalendar;
    }
    public Calendar getStartCalendar()
    {
        return startCalendar;
    }
    
    public Event getNewEvent()
    {
        return newEvent;
    }
    
    public org.infoglue.calendar.entities.Calendar getCalendar()
    {
        return calendar;
    }
    
    public void setLastRegistrationTime(Integer lastRegistrationTime)
    {
        this.lastRegistrationTime = lastRegistrationTime;
    }
    
    public Integer getLastRegistrationTime()
    {
        return lastRegistrationTime;
    }
}
