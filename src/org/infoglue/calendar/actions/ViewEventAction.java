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

import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.controllers.ParticipantController;
import org.infoglue.calendar.controllers.ResourceController;
import org.infoglue.calendar.entities.Category;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Location;
import org.infoglue.calendar.entities.Participant;
import org.infoglue.common.security.InfoGluePrincipal;
import org.infoglue.common.security.UserControllerProxy;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;

/**
 * This action represents a Location Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEventAction extends CalendarAbstractAction
{
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
    
    private List assetKeys;
    
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
        if(this.eventId == null)
            this.eventId = new Long(ServletActionContext.getRequest().getParameter("eventId"));

        //if(this.calendarId == null)
        //    this.calendarId = new Long(ServletActionContext.getRequest().getParameter("calendarId"));

        this.event = EventController.getController().getEvent(eventId, getSession());
        this.calendarId = this.event.getCalendar().getId();
        //this.locations 	= LocationController.getController().getLocationList();
        //this.categories = CategoryController.getController().getCategoryList();
        
        this.assetKeys = EventController.getController().getAssetKeys();

        this.locations 	= LocationController.getController().getLocationList(getSession());
        this.categories = CategoryController.getController().getCategoryList(getSession());
        this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();

        this.yesOrNo = new ArrayList();
        this.yesOrNo.add("true");

        /*
        this.remainingLocations = LocationController.getController().getLocationList();
        this.selectedLocations.addAll(this.remainingLocations);
        
        Iterator selectedLocationsIterator = this.selectedLocations.iterator();
        while(selectedLocationsIterator.hasNext())
        {
            Location location = (Location)selectedLocationsIterator.next();
            boolean isSelected = false;
            Iterator selectedLocationsInterator = this.selectedLocations.iterator();
            while(selectedLocationsInterator.hasNext())
            {
                Location selectedLocation = (Location)selectedLocationsInterator.next();
                if(selectedLocation.getId().equals(location.getId()))
                    isSelected = true;
            }
            
            if(!isSelected)
                selectedLocationsIterator.remove();
            else
                remainingLocations.remove(location);
        }

        
        this.remainingCategories = CategoryController.getController().getCategoryList();
        this.selectedCategories.addAll(this.remainingCategories);
        
        Iterator selectedCategoriesIterator = this.selectedCategories.iterator();
        while(selectedCategoriesIterator.hasNext())
        {
            Category location = (Category)selectedCategoriesIterator.next();
            boolean isSelected = false;
            Iterator selectedCategoriesInterator = this.selectedCategories.iterator();
            while(selectedCategoriesInterator.hasNext())
            {
                Category selectedCategory = (Category)selectedCategoriesInterator.next();
                if(selectedCategory.getId().equals(location.getId()))
                    isSelected = true;
            }
            
            if(!isSelected)
                selectedCategoriesIterator.remove();
            else
                remainingCategories.remove(location);
        }
        
        
        this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();
        this.participatingPrincipals.addAll(this.infogluePrincipals);

        Iterator participatingPrincipalsIterator = this.participatingPrincipals.iterator();
        while(participatingPrincipalsIterator.hasNext())
        {
            InfoGluePrincipal infogluePrincipal = (InfoGluePrincipal)participatingPrincipalsIterator.next();
            boolean isParticipant = false;
            Iterator participantsInterator = this.event.getParticipants().iterator();
            while(participantsInterator.hasNext())
            {
                Participant participant = (Participant)participantsInterator.next();
                if(participant.getUserName().equals(infogluePrincipal.getName()))
                    isParticipant = true;
            }
            
            if(!isParticipant)
                participatingPrincipalsIterator.remove();
            else
                infogluePrincipals.remove(infogluePrincipal);
        }
        */
        
        return Action.SUCCESS;
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
    
    public List getAssetKeys()
    {
        return assetKeys;
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
