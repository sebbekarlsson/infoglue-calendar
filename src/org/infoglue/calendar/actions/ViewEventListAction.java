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

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import org.infoglue.calendar.util.CalendarHelper;
import org.infoglue.common.util.RemoteCacheUpdater;
import org.infoglue.common.util.rss.RssHelper;
import org.infoglue.deliver.util.Timer;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.sun.syndication.feed.synd.SyndCategory;
import com.sun.syndication.feed.synd.SyndCategoryImpl;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.feed.synd.SyndContent;
import com.sun.syndication.feed.synd.SyndContentImpl;
import com.sun.syndication.feed.synd.SyndEntryImpl;
import com.sun.syndication.feed.synd.SyndFeedImpl;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEventListAction extends CalendarAbstractAction
{
	private static Log log = LogFactory.getLog(ViewEventListAction.class);

    private String calendarId 			= "";
    private String categories 			= "";
    private String categoryAttribute	= "";
    private String categoryNames 		= "";
    private String includedLanguages 	= "";
    private Calendar calendar;    
    private Set events;
    private List aggregatedEntries 		= null;
    private String message				= "";
    
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
        
        return Action.SUCCESS + "AggregatedRSS";
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

    public String listAggregatedCustom() throws Exception
    {
        execute();
            		
		String externalRSSUrl = this.getStringAttributeValue("externalRSSUrl");
		
		try
		{
			String eventURL = this.getStringAttributeValue("detailUrl");
			if(eventURL == null)
				eventURL = "";
		
		    
			if(externalRSSUrl == null || externalRSSUrl.equalsIgnoreCase(""))
			{
				log.error("You must send in an attribute called externalRSSUrl to this view. Defaulting to default example feed now.");
				externalRSSUrl = "http://aktuellt.slu.se/kalendarium_rss.cfm";
			}
			
		    List entries = getExternalFeedEntries(externalRSSUrl);
			List internalEntries = getInternalFeedEntries(eventURL);	
		
			entries.addAll(internalEntries);
			
			sortEntries(entries);
		
			log.info("entries:" + entries.size());
			
			aggregatedEntries = entries;
		}
		catch(Exception e)
		{
			//setError("Could not connect to the RSS feed \"" + externalRSSUrl + "\".", e);
			setError(getParameterizedLabel("labels.internal.event.error.couldNotConnectToRSS", externalRSSUrl), e);
			return Action.ERROR + "Custom";
		}

        return Action.SUCCESS + "AggregatedCustom";
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

    public String shortListAggregatedCustom() throws Exception
    {
        execute();
        
        return Action.SUCCESS + "ShortAggregatedCustom";
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
	        
	        List entries = getInternalFeedEntries(eventURL);
	        
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
    
    public String getAggregatedRSSXML()
    {
    	String rssXML = null;
    	
    	try
    	{
	    	SyndFeed feed = new SyndFeedImpl();
	        feed.setFeedType("atom_1.0");
	
	        feed.setTitle(this.getStringAttributeValue("feedTitle"));
	        feed.setLink(this.getStringAttributeValue("feedLink"));
	        feed.setDescription(this.getStringAttributeValue("feedDescription"));

    		String eventURL = this.getStringAttributeValue("detailUrl");
    		if(eventURL == null)
    			eventURL = "";

	        String externalRSSUrl = this.getStringAttributeValue("externalRSSUrl");
    		if(externalRSSUrl == null || externalRSSUrl.equalsIgnoreCase(""))
    		{
    			log.error("You must send in an attribute called externalRSSUrl to this view. Defaulting to default example feed now.");
    			externalRSSUrl = "http://aktuellt.slu.se/kalendarium_rss.cfm";
    		}
    		
            List entries = getExternalFeedEntries(externalRSSUrl);
    		List internalEntries = getInternalFeedEntries(eventURL);	

    		entries.addAll(internalEntries);
    		
    		sortEntries(entries);
    		
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

    public List getAggregatedEntries()
    {
        return aggregatedEntries;
    }


    private List getInternalFeedEntries(String eventURL)
    {
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
    		entry.setPublishedDate(event.getStartDateTime().getTime());
    		entry.setUri(eventURL.replaceAll("\\{eventId\\}", "" + event.getId()));
    		
    		List categories = new ArrayList();
    		Iterator eventCategoriesIterator = event.getEventCategories().iterator();
    		while(eventCategoriesIterator.hasNext())
    		{
    			EventCategory eventCategory = (EventCategory)eventCategoriesIterator.next();
    			SyndCategory syndCategory = new SyndCategoryImpl();
    			syndCategory.setTaxonomyUri(eventCategory.getEventTypeCategoryAttribute().getInternalName());
    			syndCategory.setName(eventCategory.getCategory().getLocalizedName(this.getLanguageCode(), "sv"));
    			categories.add(syndCategory);
    		}

    		//--------------------------------------------
    		// Add an extra category to internal entries, 
    		// so that we can identify them later.
    		//--------------------------------------------
    		
			SyndCategory syndCategory = new SyndCategoryImpl();
			syndCategory.setTaxonomyUri("isInfoGlueLink");
			syndCategory.setName("true");
			categories.add(syndCategory);

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

    	return entries;
    }
    
    public List getExternalFeedEntries(String externalRSSUrl) throws Exception
    {    	
    	URL url = new URL(externalRSSUrl);
        URLConnection urlConn = url.openConnection();
        urlConn.setConnectTimeout(5000);
        urlConn.setReadTimeout(10000);
        
        SyndFeedInput input = new SyndFeedInput();
        SyndFeed inputFeed = input.build(new XmlReader(urlConn));
        
        List entries = inputFeed.getEntries();
        Iterator entriesIterator = entries.iterator();
        while(entriesIterator.hasNext())
        {
        	SyndEntry entry = (SyndEntry)entriesIterator.next();
        	Iterator contentIterator = entry.getContents().iterator();
        	while(contentIterator.hasNext())
        	{
        		SyndContent content = (SyndContent)contentIterator.next();
        		log.info("content:" + content.getValue());
        		if(content.getType().equalsIgnoreCase("text/xml"))
        			content.setValue("<![CDATA[" + content.getValue() + "]]>");
        	}
        }

        return entries;    	
    }
    
    private void sortEntries(List entries)
    {
    	Collections.sort(entries, Collections.reverseOrder(new OrderByDate()));
    	//Collections.sort(entries, Collections.reverseOrder(new OrderByEventDate(this.getLanguageCode())));
    }

    
    public List getDates(String entryString)
    {
    	List dates = new ArrayList();
    	
    	try
		{
			
	        Object object = findOnValueStack(entryString);
	        SyndEntry entry = (SyndEntry)object;
	        if(object != null)
	        	dates = CalendarHelper.getDates(entry, this.getLanguageCode());
	        else
	        	log.info("entryString:" + entryString);
		} 
    	catch (Exception e)
		{
    		e.printStackTrace();
		}
        
        if(dates.size() < 2)
        {
	        dates.add(new Date());
	    	dates.add(new Date());
        }	        

        return dates;
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
    
    public String getMessage()
    {
    	return this.message;
    }
    
    /*
    public List getCategoriesList()
    {
        return categoriesList;
    }
    */
    
    public void setError(String message, Exception e)
    {
        String context = ActionContext.getContext().getName();
        ActionContext.getContext().getValueStack().getContext().put("message", message);
        ActionContext.getContext().getValueStack().getContext().put("error", e);
    }

}

//--------------------------------------------------
//Inner class for sorting entries by date.
//--------------------------------------------------

final class OrderByDate implements Comparator
{
	public int compare(final Object aObj, final Object bObj)
	{
		final Date aDate = ((SyndEntry)aObj).getPublishedDate();
		final Date bDate = ((SyndEntry)bObj).getPublishedDate();
		return (aDate == null) ? 1 : (bDate == null) ? -1 : bDate.compareTo(aDate);
	}
}

