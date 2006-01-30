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

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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

public class ViewEntrySearchAction extends CalendarAbstractAction
{
    private static Log log = LogFactory.getLog(ViewEntrySearchAction.class);

    private Long searchEventId;
    private String searchFirstName;
    private String searchLastName;
    private String searchEmail;
    private String[] categoryId;
    private String[] locationId;
    
    private Set eventList;
    private List categoryList;
    private List locationList;
    
    private List entries;
    private String emailAddresses = "";
    
    private void initialize() throws Exception
    {
        this.eventList = EventController.getController().getPublishedEventList(this.getInfoGlueRemoteUser(), this.getInfoGlueRemoteUserRoles(), this.getInfoGlueRemoteUserGroups(), getSession());
        this.categoryList = CategoryController.getController().getRootCategoryList(getSession());
        this.locationList = LocationController.getController().getLocationList(getSession());
    }
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception
    {
        initialize();

        log.info("searchEventId:::::" + this.searchEventId);
        this.entries = EntryController.getController().getEntryList(searchFirstName, 
                													searchLastName, 
                													searchEmail, 
                													searchEventId, 
                													categoryId, 
                													locationId,
                													getSession());
        
        Iterator entriesIterator = entries.iterator();
        while(entriesIterator.hasNext())
        {
            Entry entry = (Entry)entriesIterator.next();
            if(emailAddresses.length() != 0)
                emailAddresses += ";" + entry.getEmail();
            else
                emailAddresses += entry.getEmail();
        }
        
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
        
    public List getEntries()
    {
        return entries;
    }
    
    public List getCategoryList()
    {
        return categoryList;
    }
    
    public void setCategoryList(List categoryList)
    {
        this.categoryList = categoryList;
    }
    
    public List getLocationList()
    {
        return locationList;
    }
    
    public void setLocationList(List locationList)
    {
        this.locationList = locationList;
    }
    
    public String[] getCategoryId()
    {
        return categoryId;
    }
    
    public void setCategoryId(String[] categoryId)
    {
        this.categoryId = categoryId;
    }
    
    public String[] getLocationId()
    {
        return locationId;
    }
    
    public void setLocationId(String[] locationId)
    {
        this.locationId = locationId;
    }
    
    public Set getEventList()
    {
        return eventList;
    }
 
    public Long getSearchEventId()
    {
        return searchEventId;
    }
    
    public void setSearchEventId(Long searchEventId)
    {
        this.searchEventId = searchEventId;
    }
    
    public String getSearchEmail()
    {
        return searchEmail;
    }
    public void setSearchEmail(String searchEmail)
    {
        this.searchEmail = searchEmail;
    }
    public String getSearchFirstName()
    {
        return searchFirstName;
    }
    public void setSearchFirstName(String searchFirstName)
    {
        this.searchFirstName = searchFirstName;
    }
    public String getSearchLastName()
    {
        return searchLastName;
    }
    public void setSearchLastName(String searchLastName)
    {
        this.searchLastName = searchLastName;
    }
    public String getEmailAddresses()
    {
        return emailAddresses;
    }
}
