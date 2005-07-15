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
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.controllers.ResourceController;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.webwork.util.AttributeMap;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.util.OgnlValueStack;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class UpdateEventAction extends CalendarUploadAbstractAction
{
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
    private Integer maxumumParticipants;

    private String[] locationId;
    private String[] categoryId;
    private String[] participantUserName;

    private Long calendarId;
    private String mode;
    
    private String nameErrorMessage = "Mandatory field";
    private String descriptionErrorMessage = "Mandatory field";
    private String locationErrorMessage = "Mandatory field";
    private String categoryErrorMessage = "Mandatory field";
    private String participantsErrorMessage = "Mandatory field";

    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        Calendar startCalendar 	= getCalendar(startDateTime, "yyyy-MM-dd", startTime); 
        Calendar endCalendar 	= getCalendar(endDateTime, "yyyy-MM-dd", endTime); 
        Calendar lastRegistrationCalendar = getCalendar(lastRegistrationDateTime, "yyyy-MM-dd", lastRegistrationTime); 

        if(name == null || 
           name.equalsIgnoreCase("") || 
           description == null || 
           description.equalsIgnoreCase("") || 
           locationId == null || 
           locationId[0].equalsIgnoreCase("") || 
           categoryId == null ||
           categoryId[0].equalsIgnoreCase("") 
           )
        {
            ActionContext.getContext().getSession().put("eventErrorName", this.name);
            ActionContext.getContext().getSession().put("eventErrorDescription", this.description);
            
            if(this.name == null || this.name.length() == 0)
                ActionContext.getContext().getSession().put("nameErrorMessage", this.nameErrorMessage);
            if(this.description == null || this.description.length() == 0)
                ActionContext.getContext().getSession().put("descriptionErrorMessage", this.descriptionErrorMessage);
            if(this.locationId == null)
                ActionContext.getContext().getSession().put("locationErrorMessage", this.locationErrorMessage);
            if(this.categoryId == null)
                ActionContext.getContext().getSession().put("categoryErrorMessage", this.categoryErrorMessage);
            
            //ActionContext.getContext().getSession().put("participantsErrorMessage", this.participantsErrorMessage);

            return "error";
            //return Action.INPUT;
        }

        System.out.println("isInternal: " + isInternal);
        System.out.println("isOrganizedByGU: " + isOrganizedByGU);
        System.out.println("price: " + price);
        System.out.println("lastRegistrationCalendar: " + lastRegistrationCalendar.getTime());
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
                maxumumParticipants,
                startCalendar, 
                endCalendar, 
                locationId, 
                categoryId, 
                participantUserName);
        
        
        return Action.SUCCESS;
    } 
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String upload() throws Exception 
    {
        System.out.println("-------------Uploading file.....");
        
        try
        {
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // Configure the factory here, if desired.
	        PortletFileUpload upload = new PortletFileUpload(factory);
	        // Configure the uploader here, if desired.
	        List fileItems = upload.parseRequest(ServletActionContext.getRequest());
            System.out.println("fileItems:" + fileItems.size());
	        Iterator i = fileItems.iterator();
	        while(i.hasNext())
	        {
	            Object o = i.next();
	            DiskFileItem dfi = (DiskFileItem)o;
	            System.out.println("dfi:" + dfi.getFieldName());
	            System.out.println("dfi:" + dfi);
	            
	            if (!dfi.isFormField()) {
	                String fieldName = dfi.getFieldName();
	                String fileName = dfi.getName();
	                String contentType = dfi.getContentType();
	                boolean isInMemory = dfi.isInMemory();
	                long sizeInBytes = dfi.getSize();
	                
	                System.out.println("fieldName:" + fieldName);
	                System.out.println("fileName:" + fileName);
	                System.out.println("contentType:" + contentType);
	                System.out.println("isInMemory:" + isInMemory);
	                System.out.println("sizeInBytes:" + sizeInBytes);
	                File uploadedFile = new File("c:/temp/uploads/" + fileName);
	                dfi.write(uploadedFile);
	            }

	        }
	        
	    }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        System.out.println("");
        ResourceController.getController().createResource(this.eventId, this.getAssetKey(), this.getFileContentType(), this.getFileFileName(), this.getFile());
        
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
    
    public String getCategoryErrorMessage()
    {
        return categoryErrorMessage;
    }
    
    public String getDescriptionErrorMessage()
    {
        return descriptionErrorMessage;
    }
    
    public String getLocationErrorMessage()
    {
        return locationErrorMessage;
    }
    
    public String getNameErrorMessage()
    {
        return nameErrorMessage;
    }
    
    public String getParticipantsErrorMessage()
    {
        return participantsErrorMessage;
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
        System.out.println("Setting isInternal: " + isInternal);
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
    public Integer getMaxumumParticipants()
    {
        return maxumumParticipants;
    }
    public void setMaxumumParticipants(Integer maxumumParticipants)
    {
        this.maxumumParticipants = maxumumParticipants;
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
    public void setCategoryErrorMessage(String categoryErrorMessage)
    {
        this.categoryErrorMessage = categoryErrorMessage;
    }
    public void setDescriptionErrorMessage(String descriptionErrorMessage)
    {
        this.descriptionErrorMessage = descriptionErrorMessage;
    }
    public void setLocationErrorMessage(String locationErrorMessage)
    {
        this.locationErrorMessage = locationErrorMessage;
    }
    public void setNameErrorMessage(String nameErrorMessage)
    {
        this.nameErrorMessage = nameErrorMessage;
    }
    public void setParticipantsErrorMessage(String participantsErrorMessage)
    {
        this.participantsErrorMessage = participantsErrorMessage;
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
