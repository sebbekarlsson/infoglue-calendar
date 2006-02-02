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
import org.infoglue.calendar.controllers.EntryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.databeans.AdministrationUCCBean;
import org.infoglue.calendar.entities.Entry;
import org.infoglue.calendar.entities.Event;
import org.infoglue.common.util.DBSessionWrapper;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.validator.ValidationException;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class CreateEntryAction extends CalendarAbstractAction
{
    private String firstName;
    private String lastName;
    private String email;
    
    private String organisation;
    private String address;
    private String zipcode;
    private String city;
    private String phone;
    private String fax;
    private String message;

    private Long eventId;
    private Long entryId;
    private String returnAddress;
    
    private Event event;
    private Entry newEntry;
    private Entry entry;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        System.out.println("execute start...");
        /*
        if(useEntryLimitation())
        {
		    Event event = EventController.getController().getEvent(eventId, getSession());
	        List entries = EntryController.getController().getEntryList(null, null, null, eventId, null, null, getSession());
	        
	        if(event.getMaximumParticipants() != null && event.getMaximumParticipants().intValue() <= entries.size())
	            return "maximumReachedPublic";
        }
        
        System.out.println("execute start2...");
        */
        try
        {
            validateInput(this);

	        newEntry = EntryController.getController().createEntry(firstName, 
	                									lastName, 
	                									email, 
	                									organisation,
	                									address,
	                									zipcode,
	                									city,
	                									phone,
	                									fax,
	                									message, 
	                									eventId,
	                									getSession());
	        
	        EntryController.getController().mailVerification(newEntry);
        
        }
        catch(ValidationException e)
        {
            e.printStackTrace();
            return Action.ERROR;            
        }
        
        System.out.println("execute end...");

        return Action.SUCCESS;
    } 
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String doPublic() throws Exception 
    {
        /*
        if(useEntryLimitation())
        {
		    Event event = EventController.getController().getEvent(eventId, getSession());
	        List entries = EntryController.getController().getEntryList(null, null, null, eventId, null, null, getSession());
	        
	        if(event.getMaximumParticipants() != null && event.getMaximumParticipants().intValue() <= entries.size())
	            return "maximumReachedPublic";
        }
        */
        
        try
        {
            validateInput(this);

            this.execute();
        }
        catch(ValidationException e)
        {
            return Action.ERROR + "Public";            
        }
        
        return Action.SUCCESS + "Public";
    } 

    public String doPublicGU() throws Exception 
    {
        /*
        if(useEntryLimitation())
        {
		    Event event = EventController.getController().getEvent(eventId, getSession());
	        List entries = EntryController.getController().getEntryList(null, null, null, eventId, null, null, getSession());
	        
	        if(event.getMaximumParticipants() != null && event.getMaximumParticipants().intValue() <= entries.size())
	            return "maximumReachedPublic";
        }
        */
        
        try
        {
            validateInput(this);

            this.execute();
        }
        catch(ValidationException e)
        {
            return Action.ERROR + "PublicGU";            
        }
        
        return Action.SUCCESS + "PublicGU";
    } 

    
    /**
     * This is the entry point creating a new calendar.
     */
    
    public String input() throws Exception 
    {
        event = EventController.getController().getEvent(eventId, getSession());
        /*
        if(useEntryLimitation())
        {
	        List entries = EntryController.getController().getEntryList(null, null, null, eventId, null, null, getSession());
	        
	        if(event.getMaximumParticipants() != null && event.getMaximumParticipants().intValue() <= entries.size())
	            return "maximumReached";
        }
        */
        return Action.INPUT;
    } 
    
    /**
     * This is the entry point creating a new calendar.
     */
    
    public String inputPublic() throws Exception 
    {
	    event = EventController.getController().getEvent(eventId, getSession());
        /*
	    if(useEntryLimitation())
        {
	        List entries = EntryController.getController().getEntryList(null, null, null, eventId, null, null, getSession());
	        
	        if(event.getMaximumParticipants() != null && event.getMaximumParticipants().intValue() <= entries.size())
	            return "maximumReachedPublic";
        }
        */
        return Action.INPUT + "Public";
    } 

    /**
     * This is the entry point creating a new calendar.
     */
    
    public String inputPublicGU() throws Exception 
    {
        event = EventController.getController().getEvent(eventId, getSession());
	    /*
        if(useEntryLimitation())
        {
		    List entries = EntryController.getController().getEntryList(null, null, null, eventId, null, null, getSession());
	        
	        if(event.getMaximumParticipants() != null && event.getMaximumParticipants().intValue() <= entries.size())
	            return "maximumReachedPublic";
        }
        */
        
        return Action.INPUT + "PublicGU";
    } 

    public String receipt() throws Exception 
    {
        String requestEntryId = ServletActionContext.getRequest().getParameter("entryId");
        if(this.entryId == null && requestEntryId != null && !requestEntryId.equalsIgnoreCase(""))
            entryId = new Long(requestEntryId);
        
        event = EventController.getController().getEvent(eventId, getSession());
        entry = EntryController.getController().getEntry(entryId, this.getSession());
        
        return "receipt";
    } 

    public String receiptPublic() throws Exception 
    {
        String requestEntryId = ServletActionContext.getRequest().getParameter("entryId");
        if(this.entryId == null && requestEntryId != null && !requestEntryId.equalsIgnoreCase(""))
            entryId = new Long(requestEntryId);
        
        event = EventController.getController().getEvent(eventId, getSession());
        entry = EntryController.getController().getEntry(entryId, this.getSession());

        return "receiptPublic";
    } 

    public String receiptPublicGU() throws Exception 
    {
        System.out.println("Receipt public GU start");
        String requestEntryId = ServletActionContext.getRequest().getParameter("entryId");
        System.out.println("requestEntryId:" + requestEntryId);
        if(this.entryId == null && requestEntryId != null && !requestEntryId.equalsIgnoreCase(""))
            entryId = new Long(requestEntryId);

        System.out.println("entryId:" + entryId);

        event = EventController.getController().getEvent(eventId, getSession());
        entry = EntryController.getController().getEntry(entryId, this.getSession());

        System.out.println("Receipt public GU end");

        return "receiptPublicGU";
    } 
    
    
    public String getEmail()
    {
        return email;
    }
    
    public void setEmail(String email)
    {
        this.email = email;
    }
    
    public String getFirstName()
    {
        return firstName;
    }
    
    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }
    
    public String getLastName()
    {
        return lastName;
    }
    
    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }
    
    public Long getEventId()
    {
        return eventId;
    }
    
    public void setEventId(Long eventId)
    {
        this.eventId = eventId;
    }
    

    public String getAddress()
    {
        return address;
    }
    public void setAddress(String address)
    {
        this.address = address;
    }
    public String getCity()
    {
        return city;
    }
    public void setCity(String city)
    {
        this.city = city;
    }
    public String getFax()
    {
        return fax;
    }
    public void setFax(String fax)
    {
        this.fax = fax;
    }
    public String getMessage()
    {
        return message;
    }
    public void setMessage(String message)
    {
        this.message = message;
    }
    public String getOrganisation()
    {
        return organisation;
    }
    public void setOrganisation(String organisation)
    {
        this.organisation = organisation;
    }
    public String getPhone()
    {
        return phone;
    }
    public void setPhone(String phone)
    {
        this.phone = phone;
    }
    public String getZipcode()
    {
        return zipcode;
    }
    public void setZipcode(String zipcode)
    {
        this.zipcode = zipcode;
    }
    public String getReturnAddress()
    {
        return returnAddress;
    }
    public void setReturnAddress(String returnAddress)
    {
        this.returnAddress = returnAddress;
    }
    public Event getEvent()
    {
        return event;
    }
    public Entry getNewEntry()
    {
        return newEntry;
    }
    public Long getEntryId()
    {
        return entryId;
    }
    public void setEntryId(Long entryId)
    {
        this.entryId = entryId;
    }
    public Entry getEntry()
    {
        return entry;
    }
}
