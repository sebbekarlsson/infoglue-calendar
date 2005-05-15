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
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.ServletInputStream;

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

        EventController.getController().updateEvent(eventId, name, description, startCalendar, endCalendar, locationId, categoryId, participantUserName);
        
        
        return Action.SUCCESS;
    } 
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String upload() throws Exception 
    {
        Enumeration enum = ServletActionContext.getRequest().getParameterNames();
        while(enum.hasMoreElements())
        {
            String name = (String)enum.nextElement();
            System.out.println("Parameter name:" + name);
        }

        enum = ServletActionContext.getRequest().getHeaderNames();
        while(enum.hasMoreElements())
        {
            String name = (String)enum.nextElement();
            System.out.println("Header name:" + name);
        }

        enum = ServletActionContext.getRequest().getAttributeNames();
        while(enum.hasMoreElements())
        {
            String name = (String)enum.nextElement();
            System.out.println("Attribute name:" + name);
        }

        OgnlValueStack o = (OgnlValueStack)ServletActionContext.getRequest().getAttribute("webwork.valueStack");
        System.out.println("O:" + o.toString());
        System.out.println("O:" + o.getContext().keySet().toString());
        
        Map parameters2 = (Map) o.getContext().get("parameters");
        System.out.println("parameters:" + parameters2.keySet().toString());

        AttributeMap attr = (AttributeMap) o.getContext().get("attr");
        System.out.println("attr:" + attr.toString());

        ServletInputStream in = ServletActionContext.getRequest().getInputStream();
        int i = in.read();
        while (i != -1) {
            System.out.print((char)i);
            i = in.read();
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
}
