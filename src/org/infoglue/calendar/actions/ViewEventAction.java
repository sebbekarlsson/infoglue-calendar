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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventCategory;
import org.infoglue.calendar.entities.EventTypeCategoryAttribute;
import org.infoglue.cms.controllers.kernel.impl.simple.UserControllerProxy;

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
    private Event event;
    
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
            
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        log.info("this.eventId:" + eventId);
        if(this.eventId == null)
            this.eventId = new Long(ServletActionContext.getRequest().getParameter("eventId"));

        //if(this.calendarId == null)
        //    this.calendarId = new Long(ServletActionContext.getRequest().getParameter("calendarId"));

        this.event = EventController.getController().getEvent(eventId, getSession());
        this.calendarId = this.event.getOwningCalendar().getId();
        //this.locations 	= LocationController.getController().getLocationList();
        //this.categories = CategoryController.getController().getCategoryList();
        
        this.locations 	= LocationController.getController().getLocationList(getSession());
        this.categories = CategoryController.getController().getRootCategoryList(getSession());
        this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();

        this.yesOrNo = new ArrayList();
        this.yesOrNo.add("true");
        
        return Action.SUCCESS;
    } 

    public String edit() throws Exception 
    {
        log.info("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
        this.execute();
        log.info("KALAAAA");
        return "successEdit";
    }

    public String doPublic() throws Exception 
    {
        this.execute();
        return "successPublic";
    }

    public String doPublicGU() throws Exception 
    {
        this.execute();
        return "successPublicGU";
    }
    
    public List getEventCategories(EventTypeCategoryAttribute categoryAttribute)
    {
        log.info("AAAAAAAAAAAAAAAAAAAAAAAAAA getEventCategories:" + categoryAttribute);
        List categories = new ArrayList();
        
        log.info("this.event.getEventCategories():" + this.event.getEventCategories().size());
        Iterator i = this.event.getEventCategories().iterator();
        while(i.hasNext())
        {
            EventCategory eventCategory = (EventCategory)i.next();
            log.info("eventCategory:" + eventCategory.getId() + ":" + eventCategory.getEventTypeCategoryAttribute().getId() + "=" + categoryAttribute.getId());
            if(eventCategory.getEventTypeCategoryAttribute().getId().equals(categoryAttribute.getId()))
                categories.add(eventCategory.getCategory());
        }

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
}
