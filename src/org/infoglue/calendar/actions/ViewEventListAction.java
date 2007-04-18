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
import java.util.Set;

import javax.portlet.PortletURL;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.databeans.AdministrationUCCBean;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventCategory;
import org.infoglue.calendar.entities.EventTypeCategoryAttribute;
import org.infoglue.common.util.DBSessionWrapper;
import org.infoglue.common.util.RemoteCacheUpdater;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;

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

        this.events = EventController.getController().getEventList(calendarIds, categoryAttribute, categoryNamesArray, includedLanguages, getSession());
        
        log.info("Registering usage at least:" + calendarId + " for siteNodeId:" + this.getSiteNodeId());
        RemoteCacheUpdater.setUsage(this.getSiteNodeId(), calendarIds);
        
        return Action.SUCCESS;
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
