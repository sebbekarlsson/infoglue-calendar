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

package org.infoglue.calendar.controllers;

import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Category;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventCategory;
import org.infoglue.calendar.entities.EventTypeCategoryAttribute;
import org.infoglue.calendar.entities.Location;
import org.infoglue.calendar.entities.Participant;
import org.infoglue.common.security.InfoGluePrincipal;
import org.infoglue.common.security.UserControllerProxy;
import org.infoglue.common.util.PropertyHelper;
import org.infoglue.common.util.RemoteCacheUpdater;
import org.infoglue.common.util.VelocityTemplateProcessor;
import org.infoglue.common.util.io.FileHelper;
import org.infoglue.common.util.mail.MailServiceFactory;


import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class EventController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(EventController.class);
        
    
    /**
     * Factory method to get EventController
     * 
     * @return EventController
     */
    
    public static EventController getController()
    {
        return new EventController();
    }
        
    
    /**
     * This method is used to create a new Event object in the database.
     */
    
    public Event createEvent(Long calendarId, 
            				String name, 
            				String description, 
            				Boolean isInternal, 
            	            Boolean isOrganizedByGU, 
            	            String organizerName, 
            	            String lecturer, 
            	            String customLocation,
            	            String shortDescription,
            	            String longDescription,
            	            String eventUrl,
            	            String contactName,
            	            String contactEmail,
            	            String contactPhone,
            	            Float price,
            	            java.util.Calendar lastRegistrationCalendar,
            	            Integer maximumParticipants,
            	            java.util.Calendar startDateTime, 
            	            java.util.Calendar endDateTime, 
            	            String[] locationId, 
            	            Map categoryAttributes, 
            	            String[] participantUserName,
            	            Integer stateId,
            	            String creator,
            	            Session session) throws HibernateException, Exception 
    {
        Event event = null;
 
		Calendar calendar = CalendarController.getController().getCalendar(calendarId, session);
		
		Set locations = new HashSet();
		if(locationId != null)
		{
			for(int i=0; i<locationId.length; i++)
			{
			    Location location = LocationController.getController().getLocation(new Long(locationId[i]), session);
			    locations.add(location);
			}
		}
		
		Set participants = new HashSet();
		if(participantUserName != null)
		{
			for(int i=0; i<participantUserName.length; i++)
			{
			    Participant participant = new Participant();
			    participant.setUserName(participantUserName[i]);
			    participant.setEvent(event);
			    session.save(participant);
			    participants.add(participant);
			}
		}
		
		event = createEvent(calendar, 
		        			name, 
		        			description, 
		        			isInternal, 
		                    isOrganizedByGU, 
		                    organizerName, 
		                    lecturer, 
		                    customLocation,
		                    shortDescription,
		                    longDescription,
		                    eventUrl,
		                    contactName,
		                    contactEmail,
		                    contactPhone,
		                    price,
		                    lastRegistrationCalendar,
		                    maximumParticipants,
		        			startDateTime, 
		        			endDateTime, 
		        			locations, 
		        			participants,
		        			stateId,
		        			creator,
		        			session);
		
		Set eventCategories = new HashSet();
		if(categoryAttributes != null)
		{
			Iterator categoryAttributesIterator = categoryAttributes.keySet().iterator();
			while(categoryAttributesIterator.hasNext())
			{
			    String categoryAttributeId = (String)categoryAttributesIterator.next(); 
			    System.out.println("categoryAttributeId:" + categoryAttributeId);
			    EventTypeCategoryAttribute eventTypeCategoryAttribute = EventTypeCategoryAttributeController.getController().getEventTypeCategoryAttribute(new Long(categoryAttributeId), session);
			     
			    String[] categoriesArray = (String[])categoryAttributes.get(categoryAttributeId);
			    for(int i=0; i < categoriesArray.length; i++)
			    {
			        Category category = CategoryController.getController().getCategory(new Long(categoriesArray[i]), session);
			        
			        EventCategory eventCategory = new EventCategory();
				    eventCategory.setEvent(event);
				    eventCategory.setCategory(category);
				    eventCategory.setEventTypeCategoryAttribute(eventTypeCategoryAttribute);
				    session.save(eventCategory);
				    
			        eventCategories.add(eventCategory);
			    }
			}
		}
		event.setEventCategories(eventCategories);
		
        return event;
    }

    
    /**
     * This method is used to create a new Event object in the database inside a transaction.
     */
    
    public Event createEvent(Calendar calendar, 
            				String name, 
            				String description, 
            				Boolean isInternal, 
            	            Boolean isOrganizedByGU, 
            	            String organizerName, 
            	            String lecturer, 
            	            String customLocation,
            	            String shortDescription,
            	            String longDescription,
            	            String eventUrl,
            	            String contactName,
            	            String contactEmail,
            	            String contactPhone,
            	            Float price,
            	            java.util.Calendar lastRegistrationCalendar,
            	            Integer maximumParticipants,
            	            java.util.Calendar startDateTime, 
            				java.util.Calendar endDateTime, 
            				Set locations, 
            				Set participants,
            				Integer stateId,
            				String creator,
            				Session session) throws HibernateException, Exception 
    {
        
        Event event = new Event();
        event.setName(name);
        event.setDescription(description);
        event.setIsInternal(isInternal);
        event.setIsOrganizedByGU(isOrganizedByGU);
        event.setOrganizerName(organizerName);
        event.setLecturer(lecturer);
        event.setCustomLocation(customLocation);
        event.setShortDescription(shortDescription);
        event.setLongDescription(longDescription);
        event.setEventUrl(eventUrl);
        event.setContactName(contactName);
        event.setContactEmail(contactEmail);
        event.setContactPhone(contactPhone);
        event.setPrice(price);
        event.setMaximumParticipants(maximumParticipants);
        event.setLastRegistrationDateTime(lastRegistrationCalendar);
        event.setStartDateTime(startDateTime);
        event.setEndDateTime(endDateTime); 
        event.setStateId(stateId);
        event.setCreator(creator);
        
        event.setCalendar(calendar);
        event.setLocations(locations);
        event.setParticipants(participants);
        calendar.getEvents().add(event);
        
        session.save(event);
        
        return event;
    }
    
    
    /**
     * Updates an event.
     * 
     * @throws Exception
     */
    
    public void updateEvent(
            Long id, 
            String name, 
            String description, 
            Boolean isInternal, 
            Boolean isOrganizedByGU, 
            String organizerName, 
            String lecturer, 
            String customLocation,
            String shortDescription,
            String longDescription,
            String eventUrl,
            String contactName,
            String contactEmail,
            String contactPhone,
            Float price,
            java.util.Calendar lastRegistrationCalendar,
            Integer maximumParticipants,
            java.util.Calendar startDateTime, 
            java.util.Calendar endDateTime, 
            String[] locationId, 
            Map categoryAttributes, 
            String[] participantUserName,
            Session session) throws Exception 
    {

        Event event = getEvent(id, session);
		
		Set locations = new HashSet();
		if(locationId != null)
		{
			for(int i=0; i<locationId.length; i++)
			{
			    Location location = LocationController.getController().getLocation(new Long(locationId[i]), session);
			    locations.add(location);
			}
		}
		
	    System.out.println("participantUserName: " + participantUserName);
		Set participants = new HashSet();
		if(participantUserName != null)
		{
			for(int i=0; i<participantUserName.length; i++)
			{
			    Participant participant = new Participant();
			    participant.setUserName(participantUserName[i]);
			    participant.setEvent(event);
			    System.out.println("Adding " + participantUserName[i]);

			    session.save(participant);
			    participants.add(participant);
			}
		}
		
		updateEvent(
		        event, 
		        name, 
		        description, 
		        isInternal, 
		        isOrganizedByGU, 
		        organizerName, 
		        lecturer, 
		        customLocation,
                shortDescription,
                longDescription,
                eventUrl,
                contactName,
                contactEmail,
                contactPhone,
                price,
                lastRegistrationCalendar,
                maximumParticipants,
		        startDateTime, 
		        endDateTime, 
		        locations, 
		        categoryAttributes, 
		        participants, 
		        session);
		
    }
    
    /**
     * Updates an event inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateEvent(
            Event event, 
            String name, 
            String description, 
            Boolean isInternal, 
            Boolean isOrganizedByGU, 
            String organizerName, 
            String lecturer, 
            String customLocation,
            String shortDescription,
            String longDescription,
            String eventUrl,
            String contactName,
            String contactEmail,
            String contactPhone,
            Float price,
            java.util.Calendar lastRegistrationCalendar,
            Integer maximumParticipants,
            java.util.Calendar startDateTime, 
            java.util.Calendar endDateTime, 
            Set locations, 
            Map categoryAttributes, 
            Set participants, 
            Session session) throws Exception 
    {
        event.setName(name);
        event.setDescription(description);
        event.setIsInternal(isInternal);
        event.setIsOrganizedByGU(isOrganizedByGU);
        event.setOrganizerName(organizerName);
        event.setLecturer(lecturer);
        event.setCustomLocation(customLocation);
        event.setShortDescription(shortDescription);
        event.setLongDescription(longDescription);
        event.setEventUrl(eventUrl);
        event.setContactName(contactName);
        event.setContactEmail(contactEmail);
        event.setContactPhone(contactPhone);
        event.setPrice(price);
        event.setMaximumParticipants(maximumParticipants);
        event.setLastRegistrationDateTime(lastRegistrationCalendar);
        event.setStartDateTime(startDateTime);
        event.setEndDateTime(endDateTime);
        event.setLocations(locations);
        
        Iterator eventCategoryIterator = event.getEventCategories().iterator();
		while(eventCategoryIterator.hasNext())
		{
		    EventCategory eventCategory = (EventCategory)eventCategoryIterator.next();
		    session.delete(eventCategory);
		}
		
        Set eventCategories = new HashSet();
		if(categoryAttributes != null)
		{
			Iterator categoryAttributesIterator = categoryAttributes.keySet().iterator();
			while(categoryAttributesIterator.hasNext())
			{
			    String categoryAttributeId = (String)categoryAttributesIterator.next(); 
			    System.out.println("categoryAttributeId:" + categoryAttributeId);
			    EventTypeCategoryAttribute eventTypeCategoryAttribute = EventTypeCategoryAttributeController.getController().getEventTypeCategoryAttribute(new Long(categoryAttributeId), session);
			     
			    String[] categoriesArray = (String[])categoryAttributes.get(categoryAttributeId);
			    for(int i=0; i < categoriesArray.length; i++)
			    {
			        Category category = CategoryController.getController().getCategory(new Long(categoriesArray[i]), session);
			        
			        EventCategory eventCategory = new EventCategory();
				    eventCategory.setEvent(event);
				    eventCategory.setCategory(category);
				    eventCategory.setEventTypeCategoryAttribute(eventTypeCategoryAttribute);
				    session.save(eventCategory);
				    
			        eventCategories.add(eventCategory);
			    }
			}
		}
		event.setEventCategories(eventCategories);
        
        event.setParticipants(participants);
        
		session.update(event);
	}
    

    /**
     * Submits an event for publication.
     * 
     * @throws Exception
     */
    
    public void submitForPublishEvent(Long id, String publishEventUrl, Session session) throws Exception 
    {
		Event event = getEvent(id, session);
		event.setStateId(Event.STATE_PUBLISH);
		
        if(useEventPublishing())
        {
            try
            {
                EventController.getController().notifyPublisher(event, publishEventUrl);
            }
            catch(Exception e)
            {
                log.warn("An error occcurred:" + e.getMessage(), e);
            }
        }

    }    

    
    /**
     * Publishes an event.
     * 
     * @throws Exception
     */
    
    public void publishEvent(Long id, Session session) throws Exception 
    {
		Event event = getEvent(id, session);
		event.setStateId(Event.STATE_PUBLISHED);
		
		new RemoteCacheUpdater().updateRemoteCaches();
    }    
    
    /**
     * This method returns a Event based on it's primary key inside a transaction
     * @return Event
     * @throws Exception
     */
    
    public Event getEvent(Long id, Session session) throws Exception
    {
        Event event = (Event)session.load(Event.class, id);
		
		return event;
    }
    
    
    
    /**
     * Gets a list of all events available for a particular day.
     * @return List of Event
     * @throws Exception
     */
    
    public List getEventList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Event event order by event.id");
   
        result = q.list();
        
        return result;
    }
    
    
    /**
     * Gets a list of all events matching the arguments given.
     * @return List of Event
     * @throws Exception
     */
    
    public List getEventList(String name,
            java.util.Calendar startDateTime,
            java.util.Calendar endDateTime,
        	String organizerName,
            String customLocation,
            String contactName,
            String contactEmail,
            String contactPhone,
            Float price,
            Integer maximumParticipants,
            Session session) throws Exception 
    {
        List result = null;
        
        List arguments = new ArrayList();
        List values = new ArrayList();
        
        if(name != null && name.length() > 0)
        {
            arguments.add("event.name like ?");
            values.add("%" + name + "%");
        }
        if(organizerName != null && organizerName.length() > 0)
        {
            arguments.add("event.organizerName like ?");
            values.add("%" + organizerName + "%");
        }
        if(customLocation != null && customLocation.length() > 0)
        {
            arguments.add("event.customLocation like ?");
            values.add("%" + customLocation + "%");
        }
        if(contactName != null && contactName.length() > 0)
        {
            arguments.add("event.contactName like ?");
            values.add("%" + contactName + "%");
        }
        if(contactEmail != null && contactEmail.length() > 0)
        {
            arguments.add("event.contactEmail like ?");
            values.add("%" + contactEmail + "%");
        }
        if(contactPhone != null && contactPhone.length() > 0)
        {
            arguments.add("event.contactPhone like ?");
            values.add("%" + contactPhone + "%");
        }
        if(price != null && price.floatValue() > 0.0)
        {
            arguments.add("event.price = ?");
            values.add(price);
        }
        if(maximumParticipants != null)
        {						 
            arguments.add("event.maximumParticipants = ?");
            values.add(maximumParticipants);
        }
        if(startDateTime != null)
        {						 
            arguments.add("event.startDateTime >= ?");
            values.add(startDateTime);
        }
        if(endDateTime != null)
        {						 
            arguments.add("event.endDateTime <= ?");
            values.add(endDateTime);
        }

        String argumentsSQL = "";
        Iterator argumentsIterator = arguments.iterator();
        while(argumentsIterator.hasNext())
        {
            if(argumentsSQL.length() > 0)
                argumentsSQL += " AND ";
            argumentsSQL += (String)argumentsIterator.next();
        }
        System.out.println("argumentsSQL:" + argumentsSQL);
        
        Query q = session.createQuery("from Event event " + (argumentsSQL.length() > 0 ? "WHERE " + argumentsSQL : "") + " order by event.id");
   
        int i = 0;
        Iterator valuesIterator = values.iterator();
        while(valuesIterator.hasNext())
        {
            Object o = valuesIterator.next();
            if(o instanceof Float)
                q.setFloat(i, ((Float)o).floatValue());
            else if(o instanceof Integer)
                q.setInteger(i, ((Integer)o).intValue());
            else if(o instanceof String)
                q.setString(i, (String)o);
            else if(o instanceof java.util.Calendar)
                q.setCalendar(i, (java.util.Calendar)o);
            
            i++;
        }
        
        result = q.list();
        
        return result;
    }
    
    

    /**
     * Gets a list of all events available for a particular user which are in working mode.
     * @return List of Event
     * @throws Exception
     */
    
    public List getMyWorkingEventList(String userName, Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Event event where event.creator = ? AND event.stateId = ? order by event.id");
        q.setString(0, userName);
        q.setInteger(1, Event.STATE_WORKING.intValue());
        
        result = q.list();
        
        return result;
    }

    /**
     * Gets a list of all events available for a particular user which are in working mode.
     * @return List of Event
     * @throws Exception
     */
    
    public List getWaitingEventList(String userName, Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Event event where event.calendar.owner = ? AND event.stateId = ? order by event.id");
        q.setString(0, userName);
        q.setInteger(1, Event.STATE_PUBLISH.intValue());
        
        result = q.list();
        
        return result;
    }

    /**
     * Gets a list of all events available for a particular user which are in working mode.
     * @return List of Event
     * @throws Exception
     */
    
    public List getPublishedEventList(String userName, Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Event event where event.calendar.owner = ? AND event.stateId = ? order by event.id");
        q.setString(0, userName);
        q.setInteger(1, Event.STATE_PUBLISHED.intValue());
        
        result = q.list();
        
        return result;
    }

    /**
     * This method returns a list of Events based on a number of parameters
     * @return List
     * @throws Exception
     */
    
    public List getEventList(Long id, Integer stateId, java.util.Calendar startDate, java.util.Calendar endDate, Session session) throws Exception
    {
        List list = null;
        
		Calendar calendar = CalendarController.getController().getCalendar(id, session);
		list = getEventList(calendar, stateId, startDate, endDate, session);
		
		return list;
    }
    
    /**
     * Gets a list of all events available for a particular day.
     * @return List of Event
     * @throws Exception
     */
    
    public List getEventList(String[] calendarIds, Session session) throws Exception 
    {
        List result = null;
        
        String calendarSQL = null;
        if(calendarIds != null && calendarIds.length > 0)
        {
	        calendarSQL = "(";
	        for(int i=0; i<calendarIds.length; i++)
	        {
	            if(i > 0)
	                calendarSQL += ",";
	            
	            calendarSQL += calendarIds[i];
	        }
	        calendarSQL += ")";
        }
/*
        String categoriesSQL = null;
        if(categories != null && categories.length > 0)
        {
            categoriesSQL = "(";
	        for(int i=0; i<calendarIds.length; i++)
	        {
	            if(i > 0)
	                categoriesSQL += ",";
	            
	            categoriesSQL += calendarIds[i];
	        }
	        categoriesSQL += ")";
        }
*/
        Query q = session.createQuery("from Event event WHERE event.stateId = ? AND event.startDateTime >= ? " + (calendarSQL != null ? "AND event.calendar.id IN " + calendarSQL : "") + " ORDER BY event.startDateTime");
        q.setInteger(0, Event.STATE_PUBLISHED.intValue());
        q.setCalendar(1, java.util.Calendar.getInstance());
        
        result = q.list();
        
        return result;
    }
    
    /**
     * This method returns a list of Events based on a number of parameters within a transaction
     * @return List
     * @throws Exception
     */
    
    public List getEventList(Calendar calendar, Integer stateId, java.util.Calendar startDate, java.util.Calendar endDate, Session session) throws Exception
    {
        Query q = session.createQuery("from Event as event inner join fetch event.calendar as calendar where event.calendar = ? AND event.stateId = ? AND event.startDateTime >= ? AND event.endDateTime <= ? order by event.startDateTime");
        q.setEntity(0, calendar);
        q.setInteger(1, stateId.intValue());
        q.setCalendar(2, startDate);
        q.setCalendar(3, endDate);
        
        List list = q.list();
        
        Iterator iterator = list.iterator();
        while(iterator.hasNext())
        {
            Object o = iterator.next();
            Event event = (Event)o;
        }
        
		return list;
    }


    /**
     * Gets a list of events fetched by name.
     * @return List of Event
     * @throws Exception
     */
    
    public List getEvent(String name, Session session) throws Exception 
    {
        List events = null;
        
        events = session.createQuery("from Event as event where event.name = ?").setString(0, name).list();
        
        return events;
    }
    
    
    /**
     * Deletes a event object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
    public void deleteEvent(Long id, Session session) throws Exception 
    {
        Event event = this.getEvent(id, session);
        session.delete(event);
    }
    
    
    /**
     * This method emails the owner of an event the new information and an address to visit.
     * @throws Exception
     */
    
    public void notifyPublisher(Event event, String publishEventUrl) throws Exception
    {
	    String email = "";
	    
	    try
	    {
	        InfoGluePrincipal inforgluePrincipal = UserControllerProxy.getController().getUser(event.getCalendar().getOwner());
	        
	        String template;
	        
	        String contentType = PropertyHelper.getProperty("mail.contentType");
	        if(contentType == null || contentType.length() == 0)
	            contentType = "text/html";
	        
	        if(contentType.equalsIgnoreCase("text/plain"))
	            template = FileHelper.getFileAsString(new File(PropertyHelper.getProperty("contextRootPath") + "templates/newEventNotification_plain.vm"));
		    else
	            template = FileHelper.getFileAsString(new File(PropertyHelper.getProperty("contextRootPath") + "templates/newEventNotification_html.vm"));
		    
		    Map parameters = new HashMap();
		    parameters.put("event", event);
		    parameters.put("publishEventUrl", publishEventUrl.replaceAll("\\{eventId\\}", event.getId().toString()));
		    
			StringWriter tempString = new StringWriter();
			PrintWriter pw = new PrintWriter(tempString);
			new VelocityTemplateProcessor().renderTemplate(parameters, pw, template);
			email = tempString.toString();
	    
			String systemEmailSender = PropertyHelper.getProperty("systemEmailSender");
			if(systemEmailSender == null || systemEmailSender.equalsIgnoreCase(""))
				systemEmailSender = "infoglueCalendar@" + PropertyHelper.getProperty("mail.smtp.host");

			MailServiceFactory.getService().send(systemEmailSender, inforgluePrincipal.getEmail(), null, "InfoGlue Calendar - new event waiting", email, contentType, "UTF-8");
		}
		catch(Exception e)
		{
		    e.printStackTrace();
			log.error("The notification was not sent. Reason:" + e.getMessage(), e);
		}
		
    }
    
    public List getAssetKeys()
    {
        List assetKeys = new ArrayList();
        
        int i = 0;
        String assetKey = PropertyHelper.getProperty("assetKey." + i);
        while(assetKey != null && assetKey.length() > 0)
        {
            assetKeys.add(assetKey);
            
            i++;
            assetKey = PropertyHelper.getProperty("assetKey." + i);
        }
        
        return assetKeys;
    }



}