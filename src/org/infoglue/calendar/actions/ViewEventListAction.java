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
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.portlet.PortletURL;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventCategory;
import org.infoglue.calendar.entities.EventTypeCategoryAttribute;
import org.infoglue.calendar.entities.EventVersion;
import org.infoglue.common.util.RemoteCacheUpdater;
import org.infoglue.common.util.rss.RssHelper;
import org.infoglue.deliver.util.Timer;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.sun.syndication.feed.synd.SyndCategory;
import com.sun.syndication.feed.synd.SyndCategoryImpl;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.feed.synd.SyndContent;
import com.sun.syndication.feed.synd.SyndContentImpl;
import com.sun.syndication.feed.synd.SyndEntryImpl;
import com.sun.syndication.feed.synd.SyndFeedImpl;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEventListAction extends CalendarAbstractAction
{
	private static Log log = LogFactory.getLog(ViewEventListAction.class);

    private String calendarId = "";
    private String categories = "";
    private String categoryAttribute = "";
    private String categoryNames = "";
    private String includedLanguages = "";
    private Calendar calendar;
    
    private Set events;
    //private List categoriesList;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        String[] calendarIds = calendarId.split(",");
        String[] categoryNamesArray = categoryNames.split(",");
        
        Session session = getSession(true);
    	        
        this.events = EventController.getController().getEventList(calendarIds, categoryAttribute, categoryNamesArray, includedLanguages, session);
        
        log.info("Registering usage at least:" + calendarId + " for siteNodeId:" + this.getSiteNodeId());
        RemoteCacheUpdater.setUsage(this.getSiteNodeId(), calendarIds);
        
        return Action.SUCCESS;
    } 

    public String listAsRSS() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "RSS";
    }

    public String listAsAggregatedRSS() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "AggregratedRSS";
    }

    public String listGU() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "GU";
    }

    public String listCustom() throws Exception
    {
        execute();
        return Action.SUCCESS + "Custom";
    }

    public String listSlottedGU() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "SlotGU";
    }

    public String shortListGU() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "ShortGU";
    }

    public String listSlottedCustom() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "SlotCustom";
    }

    public String shortListCustom() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "ShortCustom";
    }

    public String getCalendarId()
    {
        return calendarId;
    }
    
    public void setCalendarId(String calendarId)
    {
        this.calendarId = calendarId;
    }
    
    public Set getEvents()
    {
        return events;
    }

    public void setCategories(String categories)
    {
        this.categories = categories;
    }
    
    public String getIncludedLanguages()
    {
    	String includedLanguages = (String)ServletActionContext.getRequest().getAttribute("includedLanguages");
       	if(includedLanguages == null || includedLanguages.equals(""))
       		includedLanguages = (String)ServletActionContext.getRequest().getParameter("includedLanguages");

    	if(includedLanguages == null || includedLanguages.equals(""))
    		includedLanguages = "*";
    	
        return includedLanguages;
    }

    public Integer getNumberOfItems()
    {
        Object o = ServletActionContext.getRequest().getAttribute("numberOfItems");
        if(o != null && o.toString().length() > 0)
            return new Integer((String)o);
        else
            return new Integer(10);
    }
    
    public List getEventCategories(String eventString, EventTypeCategoryAttribute categoryAttribute)
    {
        Object object = findOnValueStack(eventString);
        Event event = (Event)object;
        
        List categories = new ArrayList();
        
        Iterator i = event.getEventCategories().iterator();
        while(i.hasNext())
        {
            EventCategory eventCategory = (EventCategory)i.next();
            if(eventCategory.getEventTypeCategoryAttribute().getId().equals(categoryAttribute.getId()))
                categories.add(eventCategory.getCategory());
        }

        return categories;
    }

    public String getRSSXML()
    {
    	String rssXML = null;
    	
    	try
    	{
    		String eventURL = this.getStringAttributeValue("detailUrl");
    		if(eventURL == null)
    			eventURL = "";
    		
	    	SyndFeed feed = new SyndFeedImpl();
	        feed.setFeedType("atom_1.0");
	
	        feed.setTitle(this.getStringAttributeValue("feedTitle"));
	        feed.setLink(this.getStringAttributeValue("feedLink"));
	        feed.setDescription(this.getStringAttributeValue("feedDescription"));
	        
	        List entries = new ArrayList();
	        SyndEntry entry;
	        SyndContent description;
	        
	    	Iterator eventsIterator = events.iterator();
	    	while(eventsIterator.hasNext())
	    	{
	    		Event event = (Event)eventsIterator.next();
	    		EventVersion eventVersion = this.getEventVersion(event);
	    		
	    		entry = new SyndEntryImpl();
	    		entry.setTitle(eventVersion.getName());
    			entry.setLink(eventURL.replaceAll("\\{eventId\\}", "" + event.getId()));
	    		entry.setPublishedDate(new Date());
	
	    		List categories = new ArrayList();
	    		Iterator eventCategoriesIterator = event.getEventCategories().iterator();
	    		while(eventCategoriesIterator.hasNext())
	    		{
	    			EventCategory eventCategory = (EventCategory)eventCategoriesIterator.next();
	    			SyndCategory syndCategory = new SyndCategoryImpl();
	    			syndCategory.setName(eventCategory.getCategory().getLocalizedName(this.getLanguageCode(), "sv"));
	    			categories.add(syndCategory);
	    		}
	    				    		
	    		entry.setCategories(categories);
	    		
	    		description = new SyndContentImpl();
	    		description.setType("text/html");
	    		description.setValue(eventVersion.getShortDescription());
	    		entry.setDescription(description);

	    		List contents = new ArrayList();

	    		SyndContent metaData = new SyndContentImpl();

	    		StringBuffer xml = new StringBuffer("<![CDATA[<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	    		xml.append("<metadata>");
	    		xml.append("<startDateTime>" + this.formatDate(event.getStartDateTime().getTime(), "yyyy-MM-dd HH:mm") + "</startDateTime>");
	    		xml.append("<endDateTime>" + this.formatDate(event.getEndDateTime().getTime(), "yyyy-MM-dd HH:mm") + "</endDateTime>");
	    		xml.append("</metadata>]]>");

	    		metaData.setType("text/xml");
	    		metaData.setValue(xml.toString());
	    		
	    		contents.add(metaData);

	    		entry.setContents(contents);
	    		
	    		entries.add(entry);
	    	}
	    	
	    	feed.setEntries(entries);
	    	RssHelper rssHelper = new RssHelper();
	    	rssXML = rssHelper.render(feed);
    	}
    	catch(Throwable t)
    	{
    		t.printStackTrace();
    	}
    	
        return rssXML;
    }

    public void setCategoryAttribute(String categoryAttribute)
    {
        this.categoryAttribute = categoryAttribute;
    }
    
    public void setCategoryNames(String categoryNames)
    {
        this.categoryNames = categoryNames;
    }
    
    public void setIncludedLanguages(String includedLanguages)
    {
    	this.includedLanguages = includedLanguages;
    }
    /*
    public List getCategoriesList()
    {
        return categoriesList;
    }
    */

}
