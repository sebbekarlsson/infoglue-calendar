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
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.EntryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.EventTypeCategoryAttributeController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.controllers.ResourceController;
import org.infoglue.calendar.entities.Entry;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Location;
import org.infoglue.calendar.util.EntrySearchResultfilesConstructor;
import org.infoglue.common.util.PropertyHelper;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;

/**
 * This action represents a Location Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEntrySearchAction extends CalendarAbstractAction
{
    private static Log log = LogFactory.getLog(ViewEntrySearchAction.class);

    private Long[] searchEventId;
    private String searchFirstName;
    private String searchLastName;
    private String searchEmail;
    private boolean onlyFutureEvents = true;
    private String[] categoryId;
    private String[] locationId;
    
    private Set eventList;
    private List categoryList;
    private List locationList;
    private List categoryAttributes;
    
    private String andSearch = "false";
    
    private Set entries;
    private String emailAddresses = "";

	private Map searchResultFiles;
	private List resultValues = new LinkedList(); 
    
    private Map categoryAttributesMap = new HashMap();

    private void initialize() throws Exception
    {
        this.eventList = EventController.getController().getPublishedEventList(this.getInfoGlueRemoteUser(), this.getInfoGlueRemoteUserRoles(), this.getInfoGlueRemoteUserGroups(), null, getSession());
        this.categoryList = CategoryController.getController().getRootCategoryList(getSession());
        this.locationList = LocationController.getController().getLocationList(getSession());
        this.categoryAttributes = EventTypeCategoryAttributeController.getController().getEventTypeCategoryAttributeList(getSession());
        log.debug("calendars:" + categoryAttributes.size());
		String entryResultValues = PropertyHelper.getProperty("entryResultsValues");
        StringTokenizer st = new StringTokenizer( entryResultValues, ",", false );
        while( st.hasMoreTokens() ) 
        {
        	String resultValue = st.nextToken();
        	resultValues.add( resultValue );
        }
    }
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception
    {
        initialize();

        int i = 0;
        String idKey = ServletActionContext.getRequest().getParameter("categoryAttributeId_" + i);
        log.info("idKey:" + idKey);
        while(idKey != null && idKey.length() > 0)
        {
            String[] categoryIds = ServletActionContext.getRequest().getParameterValues("categoryAttribute_" + idKey + "_categoryId");
            log.info("categoryIds:" + categoryIds);
            if(categoryIds != null)
            {
	            Long[] categoryIdsLong = new Long[categoryIds.length];
	            for(int j=0; j<categoryIds.length; j++)
	            	categoryIdsLong[j] = new Long(categoryIds[j]);
	            
	            categoryAttributesMap.put(idKey, categoryIdsLong);
            }
            
            i++;
            idKey = ServletActionContext.getRequest().getParameter("categoryAttributeId_" + i);
            log.info("idKey:" + idKey);
        }
        

        log.info("searchEventId:::::" + this.searchEventId);
        log.info("andSearch:" + this.andSearch);
        
        this.andSearch = ServletActionContext.getRequest().getParameter("andSearch");
        log.info("andSearch:" + andSearch);

        
        this.entries = EntryController.getController().getEntryList(this.getInfoGlueRemoteUser(), 
        															this.getInfoGlueRemoteUserRoles(), 
        															this.getInfoGlueRemoteUserGroups(),
        															searchFirstName, 
                													searchLastName, 
                													searchEmail,
                													onlyFutureEvents,
                													searchEventId, 
                													categoryAttributesMap,
                													Boolean.parseBoolean(andSearch),
                													locationId,
                													getSession());

        /*
        this.entries = EntryController.getController().getEntryList(searchFirstName, 
				searchLastName, 
				searchEmail, 
				searchEventId, 
				categoryId, 
				locationId,
				getSession());
		*/
        
        Iterator entriesIterator = entries.iterator();
        while(entriesIterator.hasNext())
        {
            Entry entry = (Entry)entriesIterator.next();
            if(emailAddresses.length() != 0)
                emailAddresses += ";" + entry.getEmail();
            else
                emailAddresses += entry.getEmail();
        }
        
        // should we create result files?
        boolean exportEntryResults = PropertyHelper.getBooleanProperty("exportEntryResults");
        if( entries.size() > 0 && exportEntryResults ) 
        {
        	HttpServletRequest request = ServletActionContext.getRequest();
        	EntrySearchResultfilesConstructor results = new EntrySearchResultfilesConstructor( entries, getTempFilePath(), request.getScheme(), request.getServerName(), request.getServerPort(), resultValues, this );
        	searchResultFiles = results.getResults();
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
        
    public Set getEntries()
    {
        return entries;
    }

    public List getEntriesAsList()
    {
    	List result = new ArrayList();
    	result.addAll(entries);
    	log.debug("result:" + result.size());
        return result;
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
 
    public Long[] getSearchEventId()
    {
        return searchEventId;
    }
    
    public void setSearchEventId(Long[] searchEventId)
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

	public void setOnlyFutureEvents(boolean onlyFutureEvents)
	{
		this.onlyFutureEvents = onlyFutureEvents;
	}

	public boolean getOnlyFutureEvents()
	{
		return this.onlyFutureEvents;
	}

	public List getCategoryAttributes()
	{
		return categoryAttributes;
	}

	public void setAndSearch(String andSearch)
	{
		this.andSearch = andSearch;
	}

	/**
	 * @return Returns the searchResultFiles.
	 */
	public Map getSearchResultFiles() {
		return searchResultFiles;
	}

	/**
	 * @param searchResultFiles The searchResultFiles to set.
	 */
	public void setSearchResultFiles(Map searchResultFiles) {
		this.searchResultFiles = searchResultFiles;
	}

	/**
	 * @return Returns the resultValues.
	 */
	public List getResultValues() {
		return resultValues;
	}

	/**
	 * @param resultValues The resultValues to set.
	 */
	public void setResultValues(List resultValues) {
		this.resultValues = resultValues;
	}
	
	public boolean getSingleEventSearch()
	{
		if(searchEventId == null || searchEventId.length > 1 || searchEventId[0] == null)
			return false;
		else
			return true;
	}
}
