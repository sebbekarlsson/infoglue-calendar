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
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Location;
import org.infoglue.calendar.entities.Participant;
import org.infoglue.common.security.InfoGluePrincipal;
import org.infoglue.common.security.UserControllerProxy;

import com.opensymphony.xwork.Action;

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
    private List participatingPrincipals = new ArrayList();
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        this.event = EventController.getController().getEvent(eventId);
        this.calendarId = this.event.getCalendar().getId();
        this.locations 	= LocationController.getController().getLocationList();
        this.categories = CategoryController.getController().getCategoryList();
        
        this.infogluePrincipals = UserControllerProxy.getController().getAllUsers();
        this.participatingPrincipals.addAll(this.infogluePrincipals);
        
        System.out.println("this.infogluePrincipals:" + this.infogluePrincipals.size());
        System.out.println("this.participatingPrincipals:" + this.participatingPrincipals.size());

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
        
        System.out.println("this.infogluePrincipals:" + this.infogluePrincipals.size());
        System.out.println("this.participatingPrincipals:" + this.participatingPrincipals.size());
        
        return Action.SUCCESS;
    } 

    public String doPublic() throws Exception 
    {
        this.execute();
        return "successPublic";
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
    
    public List getCategories()
    {
        return categories;
    }
    
    public List getLocations()
    {
        return locations;
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
}
