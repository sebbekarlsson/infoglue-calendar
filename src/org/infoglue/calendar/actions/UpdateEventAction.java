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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.portlet.ActionRequest;
import javax.servlet.ServletInputStream;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.portlet.PortletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.controllers.ResourceController;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.webwork.util.AttributeMap;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.util.OgnlValueStack;
import com.opensymphony.xwork.validator.ValidationException;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class UpdateEventAction extends CalendarUploadAbstractAction
{
	private static Log log = LogFactory.getLog(UpdateEventAction.class);

    private Long eventId;
    private String name;
    private String description;
    private String startDateTime;
    private String endDateTime;
    private Integer startTime;
    private Integer endTime;

    private Boolean isInternal;
    private Boolean isOrganizedByGU;
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

    private Long calendarId;
    private String mode;
        
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        Calendar startCalendar 	= getCalendar(startDateTime, "yyyy-MM-dd", startTime); 
        Calendar endCalendar 	= getCalendar(endDateTime, "yyyy-MM-dd", endTime); 
        Calendar lastRegistrationCalendar = getCalendar(lastRegistrationDateTime, "yyyy-MM-dd", lastRegistrationTime); 

        try
        {
            validateInput(this);
            
            EventController.getController().updateEvent(
                    eventId, 
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
                    categoryId, 
                    participantUserName,
                    getSession());
            
        }
        catch(ValidationException e)
        {
            return Action.ERROR;            
        }

        return Action.SUCCESS;
    } 
    
    
    /**
     * This is the action command for publishing an event.
     */
    
    public String publishEvent() throws Exception 
    {
        EventController.getController().publishEvent(eventId, getSession());

        return Action.SUCCESS;
    } 
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String upload() throws Exception 
    {
        
        try
        {
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // Configure the factory here, if desired.
	        PortletFileUpload upload = new PortletFileUpload(factory);
	        // Configure the uploader here, if desired.
	        List fileItems = upload.parseRequest(ServletActionContext.getRequest());
            log.debug("fileItems:" + fileItems.size());
	        Iterator i = fileItems.iterator();
	        while(i.hasNext())
	        {
	            Object o = i.next();
	            DiskFileItem dfi = (DiskFileItem)o;
	            log.debug("dfi:" + dfi.getFieldName());
	            log.debug("dfi:" + dfi);
	            
	            if (!dfi.isFormField()) {
	                String fieldName = dfi.getFieldName();
	                String fileName = dfi.getName();
	                String contentType = dfi.getContentType();
	                boolean isInMemory = dfi.isInMemory();
	                long sizeInBytes = dfi.getSize();
	                
	                log.debug("fieldName:" + fieldName);
	                log.debug("fileName:" + fileName);
	                log.debug("contentType:" + contentType);
	                log.debug("isInMemory:" + isInMemory);
	                log.debug("sizeInBytes:" + sizeInBytes);
	                File uploadedFile = new File(getTempFilePath() + File.separator + fileName);
	                dfi.write(uploadedFile);
	            }

	        }
	        
	    }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        log.debug("");
        ResourceController.getController().createResource(this.eventId, this.getAssetKey(), this.getFileContentType(), this.getFileFileName(), this.getFile(), getSession());
        
        return Action.SUCCESS;
    } 
    
    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description;
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
    
    public Long getEventId()
    {
        return eventId;
    }
    
    public void setEventId(Long eventId)
    {
        this.eventId = eventId;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
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
    
    public void setCategoryId(String[] categoryId)
    {
        this.categoryId = categoryId;
    }
    
    public void setLocationId(String[] locationId)
    {
        this.locationId = locationId;
    }
    
    public Long getCalendarId()
    {
        return calendarId;
    }
    
    public void setCalendarId(Long calendarId)
    {
        this.calendarId = calendarId;
    }
    
    public String getMode()
    {
        return mode;
    }
    
    public void setMode(String mode)
    {
        this.mode = mode;
    }
    
    public String[] getParticipantUserName()
    {
        return participantUserName;
    }
    
    public void setParticipantUserName(String[] participantUserName)
    {
        this.participantUserName = participantUserName;
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
    public String[] getCategoryId()
    {
        return categoryId;
    }
    public String[] getLocationId()
    {
        return locationId;
    }
    public Integer getLastRegistrationTime()
    {
        return lastRegistrationTime;
    }
    public void setLastRegistrationTime(Integer lastRegistrationTime)
    {
        this.lastRegistrationTime = lastRegistrationTime;
    }
    
}
