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
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.ObjectNotFoundException;
import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.ContentTypeDefinitionController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.EventTypeController;
import org.infoglue.calendar.controllers.LanguageController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventCategory;
import org.infoglue.calendar.entities.EventType;
import org.infoglue.calendar.entities.EventTypeCategoryAttribute;
import org.infoglue.calendar.entities.EventVersion;
import org.infoglue.calendar.entities.Language;
import org.infoglue.cms.controllers.kernel.impl.simple.UserControllerProxy;
import org.infoglue.deliver.util.Timer;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;

/**
 * This action represents a Location Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEventAction extends CalendarAbstractAction
{
    private static Log log = LogFactory.getLog(ViewEventAction.class);

    private Long eventId;
    private Long versionLanguageId;
    private Event event;
    private EventVersion eventVersion;
    
    private Long calendarId;
    private String mode = "day";

    private List locations;
    private List categories;
    private List infogluePrincipals;

    private List yesOrNo = new ArrayList();

    private List remainingLocations;
    private List selectedLocations = new ArrayList();
    
    private List remainingCategories;
    private List selectedCategories = new ArrayList();
    
    private List remainingInfogluePrincipals;
    private List participatingPrincipals = new ArrayList();
            
    private Boolean forceRequestEventId = new Boolean(false);
    private Boolean eventCopy			= new Boolean(false);
    
    private List entryFormEventTypes;
    private EventType entryFormEventType;
    
    private List attributes;
    private List availableLanguages = new ArrayList();
    
    private Boolean skipLanguageTabs;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        try
        {
        	log.info("this.eventId:" + eventId);
	        
	        String requestEventId = ServletActionContext.getRequest().getParameter("eventId");
	        String forceRequestEventIdString = ServletActionContext.getRequest().getParameter("forceRequestEventId");
	        if(forceRequestEventIdString != null && forceRequestEventIdString.length() > 0)
	            this.forceRequestEventId = new Boolean(forceRequestEventIdString);
	        
	        String requestEventCopy = ServletActionContext.getRequest().getParameter("eventCopy");
	        if(forceRequestEventIdString != null && forceRequestEventIdString.length() > 0)
	            this.eventCopy = new Boolean(requestEventCopy);
	        
	        if((this.eventId == null || this.forceRequestEventId.booleanValue()) && requestEventId != null && !requestEventId.equalsIgnoreCase(""))
	            this.eventId = new Long(requestEventId);
	
	        this.availableLanguages = LanguageController.getController().getLanguageList(getSession());
            if(this.versionLanguageId == null && this.availableLanguages.size() > 0)
            {
            	this.versionLanguageId = ((Language)this.availableLanguages.get(0)).getId();
            }
            
	        if(this.eventId != null)
	        {
	            this.event = EventController.getController().getEvent(eventId, getSession());
	            Iterator eventVersionsIterator = this.event.getVersions().iterator();
	            while(eventVersionsIterator.hasNext())
	            {
	            	EventVersion currentEventVersion = (EventVersion)eventVersionsIterator.next();
	            	if(currentEventVersion.getVersionLanguageId().equals(versionLanguageId))
	            	{
	            		this.eventVersion = currentEventVersion;
	            		break;
	            	}
	            }
	            
	            this.calendarId = this.event.getOwningCalendar().getId();
	            
	            this.locations 	= LocationController.getController().getLocationList(getSession());
	            this.categories = CategoryController.getController().getRootCategoryList(getSession());
	            this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();
	            this.entryFormEventTypes = EventTypeController.getController().getEventTypeList(EventType.ENTRY_DEFINITION, getSession());
	            this.entryFormEventType = EventTypeController.getController().getEventType(event.getEntryFormId(), getSession());
	            
	            EventType eventType = this.event.getOwningCalendar().getEventType();
	    		if(eventType != null)
	    			this.attributes = ContentTypeDefinitionController.getController().getContentTypeAttributes(eventType.getSchemaValue());

	            this.yesOrNo = new ArrayList();
	            this.yesOrNo.add("true");            
	
	            return Action.SUCCESS;
	        }
	        else
	        {
	            throw new ObjectNotFoundException("EventId was empty", "");
	        }
        }
        catch(ObjectNotFoundException o)
        {
            log.warn("Det fanns inget evenemang med id " + this.eventId + ":" + o.getMessage());
            setError("Det fanns inget evenemang med id " + this.eventId, o);
        }
        catch(Exception e)
        {
            log.error("Ett fel uppstod när evenemang med id " + this.eventId + " skulle visas:" + e.getMessage(), e);
            setError("Ett fel uppstod när evenemang med id " + this.eventId + " skulle visas.", e);
        }
        
        return Action.ERROR;
    } 

    public String chooseLanguageForEdit() throws Exception 
    {
        this.availableLanguages = LanguageController.getController().getLanguageList(getSession());

        if(this.eventId != null)
        {
            this.event = EventController.getController().getEvent(eventId, getSession());
            Iterator eventVersionIterator = this.event.getVersions().iterator();
            while(eventVersionIterator.hasNext())
            {
            	EventVersion eventVersion = (EventVersion)eventVersionIterator.next();
            	this.availableLanguages.remove(eventVersion.getLanguage());
            }
        }
        
    	return "successChooseLanguageForEdit";
    }
    
    public String edit() throws Exception 
    {
        if(this.execute().equals(Action.ERROR))
            return Action.ERROR;
        else
            return "successEdit";
    }

    public String doPublic() throws Exception 
    {
        try
        {
            log.info("this.eventId:" + eventId);
	        String requestEventId = ServletActionContext.getRequest().getParameter("eventId");
	        if(this.eventId == null && requestEventId != null && !requestEventId.equalsIgnoreCase(""))
	            this.eventId = new Long(requestEventId);
	
	        if(this.eventId != null)
	        {
	            this.event = EventController.getController().getEvent(eventId, getSession());
	
	            return "successPublic";
	        }
	        else
	        {
	            throw new ObjectNotFoundException("EventId was empty", "");
	        }
        }
        catch(ObjectNotFoundException o)
        {
            log.warn("Det fanns inget evenemang med id " + this.eventId + ":" + o.getMessage());
            setError("Det fanns inget evenemang med id " + this.eventId, o);
        }
        catch(Exception e)
        {
            log.error("Ett fel uppstod när evenemang med id " + this.eventId + " skulle visas:" + e.getMessage(), e);
            setError("Ett fel uppstod när evenemang med id " + this.eventId + " skulle visas.", e);
        }

        return Action.ERROR;
    }

    public String doPublicGU() throws Exception 
    {
        try
        {
	        log.info("this.eventId:" + eventId);
	        String requestEventId = ServletActionContext.getRequest().getParameter("eventId");
	        if(this.eventId == null && requestEventId != null && !requestEventId.equalsIgnoreCase(""))
	            this.eventId = new Long(requestEventId);
	
	        if(this.eventId != null)
	        {
	            this.event = EventController.getController().getEvent(eventId, getSession());
	
	            return "successPublicGU";
	        }
	        else
	        {
	            throw new ObjectNotFoundException("EventId was empty", "");
	        }
        }
        catch(ObjectNotFoundException o)
        {
            log.warn("Det fanns inget evenemang med id " + this.eventId + ":" + o.getMessage());
            setError("Det fanns inget evenemang med id " + this.eventId, o);
        }
        catch(Exception e)
        {
            log.error("Ett fel uppstod när evenemang med id " + this.eventId + " skulle visas:" + e.getMessage(), e);
            setError("Ett fel uppstod när evenemang med id " + this.eventId + " skulle visas.", e);
        }
        
        return Action.ERROR;
    }
    
    public List getEventCategories(EventTypeCategoryAttribute categoryAttribute)
    {
        //Timer timer = new Timer();

        List categories = new ArrayList();
        
        Iterator i = this.event.getEventCategories().iterator();
        while(i.hasNext())
        {
            EventCategory eventCategory = (EventCategory)i.next();
            if(eventCategory.getEventTypeCategoryAttribute().getId().equals(categoryAttribute.getId()))
                categories.add(eventCategory.getCategory());
        }

        //timer.printElapsedTime("getEventCategories took");

        return categories;
    }
    
    public Event getEvent()
    {
        return event;
    }
    
    public void setEvent(Event event)
    {
        this.event = event;
    }
    
    public Long getEventId()
    {
        return eventId;
    }
    
    public void setEventId(Long eventId)
    {
        this.eventId = eventId;
    }
    
    
    public Long getCalendarId()
    {
        return calendarId;
    }
        
    public String getMode()
    {
        return mode;
    }
    
    public void setMode(String mode)
    {
        this.mode = mode;
    }
    
    public List getInfogluePrincipals()
    {
        return infogluePrincipals;
    }
    
    public List getParticipatingPrincipals()
    {
        return participatingPrincipals;
    }
    
    public List getRemainingCategories()
    {
        return remainingCategories;
    }
    
    public List getRemainingLocations()
    {
        return remainingLocations;
    }
    
    public List getSelectedCategories()
    {
        return selectedCategories;
    }
    
    public List getSelectedLocations()
    {
        return selectedLocations;
    }
        
    public List getCategories()
    {
        return categories;
    }
    public List getLocations()
    {
        return locations;
    }
    
    public List getYesOrNo()
    {
        return yesOrNo;
    }
    
    public void setForceRequestEventId(Boolean forceRequestEventId)
    {
        this.forceRequestEventId = forceRequestEventId;
    }
    
    public String[] getCategoryAttributeValues(Long key)
    {
        String[] value = (String[])((Map)ServletActionContext.getRequest().getSession().getAttribute("categoryAttributes")).get(key.toString());
        return value;
    }

    public Boolean getEventCopy()
    {
        return eventCopy;
    }
    
    public void setEventCopy(Boolean eventCopy)
    {
        this.eventCopy = eventCopy;
    }

	public List getEntryFormEventTypes()
	{
		return entryFormEventTypes;
	}

	public EventType getEntryFormEventType()
	{
		return entryFormEventType;
	}

	public List getAttributes()
	{
		return attributes;
	}

	public List getAvailableLanguages() 
	{
		return availableLanguages;
	}

	public Long getVersionLanguageId() 
	{
		return versionLanguageId;
	}

	public void setVersionLanguageId(Long versionLanguageId) 
	{
		this.versionLanguageId = versionLanguageId;
	}

	public EventVersion getEventVersion() 
	{
		return eventVersion;
	}

	public void setEventVersion(EventVersion eventVersion) 
	{
		this.eventVersion = eventVersion;
	}

	public Boolean getSkipLanguageTabs() 
	{
		return skipLanguageTabs;
	}

	public void setSkipLanguageTabs(Boolean skipLanguageTabs) 
	{
		this.skipLanguageTabs = skipLanguageTabs;
	}
}
