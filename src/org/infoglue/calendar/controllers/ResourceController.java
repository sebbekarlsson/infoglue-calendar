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
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Blob;
import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Category;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Location;
import org.infoglue.calendar.entities.Participant;
import org.infoglue.calendar.entities.Resource;


import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import net.sf.hibernate.*;
import net.sf.hibernate.cfg.*;
import net.sf.hibernate.expression.Expression;
import net.sf.hibernate.type.Type;

public class ResourceController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(ResourceController.class);
        
    
    /**
     * Factory method to get EventController
     * 
     * @return EventController
     */
    
    public static ResourceController getController()
    {
        return new ResourceController();
    }
        
    
    /**
     * This method is used to create a new Event object in the database.
     */
    
    public Resource createResource(Long eventId, String assetKey, String contentType, String fileName, File file) throws HibernateException, Exception 
    {
        Resource resource = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			System.out.println("eventId:" + eventId);
			Event event = EventController.getController().getEvent(eventId, session);
			System.out.println("event:" + event);
			
			resource = createResource(event, assetKey, contentType, fileName, file, session);

			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
        return resource;
    }

    
    /**
     * This method is used to create a new Event object in the database inside a transaction.
     */
    
    public Resource createResource(Event event, String assetKey, String contentType, String fileName, File file, Session session) throws HibernateException, Exception 
    {
        System.out.println("Creating new resource...");
        
        Resource resource = new Resource();
        resource.setAssetKey(assetKey);
        resource.setResource(Hibernate.createBlob(new FileInputStream(file)));
        
        event.getResources().add(resource);
        
        session.save(resource);
        
        System.out.println("Finished creating resource...");
        
        return resource;
    }
    
    
    /**
     * Updates an event.
     * 
     * @throws Exception
     */
    /*
    public void updateEvent(Long id, String name, String description, java.util.Calendar startDateTime, java.util.Calendar endDateTime, String[] locationId, String[] categoryId, String[] participantUserName) throws Exception 
    {
	    Session session = getSession();
	    
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
		
			Event event = getEvent(id, session);
			
			Set locations = new HashSet();
			for(int i=0; i<locationId.length; i++)
			{
			    Location location = LocationController.getController().getLocation(new Long(locationId[i]), session);
			    locations.add(location);
			}

			Set categories = new HashSet();
			for(int i=0; i<categoryId.length; i++)
			{
			    Category category = CategoryController.getController().getCategory(new Long(categoryId[i]), session);
			    categories.add(category);
			}

			Set participants = new HashSet();
			for(int i=0; i<participantUserName.length; i++)
			{
			    Participant participant = new Participant();
			    participant.setUserName(participantUserName[i]);
			    participant.setEvent(event);
			    session.save(participant);
			    participants.add(participant);
			}

			updateEvent(event, name, description, startDateTime, endDateTime, locations, categories, participants, session);
			
			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
    }
    */
    
    /**
     * Updates an event inside an transaction.
     * 
     * @throws Exception
     */
    /*
    public void updateEvent(Event event, String name, String description, java.util.Calendar startDateTime, java.util.Calendar endDateTime, Set locations, Set categories, Set participants, Session session) throws Exception 
    {
        event.setName(name);
        event.setDescription(description);
        event.setStartDateTime(startDateTime);
        event.setEndDateTime(endDateTime);
        event.setLocations(locations);
        event.setCategories(categories);
        event.setParticipants(participants);
        
		session.update(event);
	}
    */
    
    /**
     * This method returns a Resource based on it's primary key
     * @return Resource
     * @throws Exception
     */
    
    public String getResourceUrl(Long id) throws Exception
    {
        String url = "";
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			Resource resource = getResource(id, session);
			
			FileOutputStream fos = new FileOutputStream("c:/temp/" + resource.getId() + "_" + resource.getAssetKey() + ".gif");
			Blob blob = resource.getResource();
			byte[] bytes = blob.getBytes(1, (int) blob.length());
			System.out.println(bytes.length);
			fos.write(bytes);
			fos.flush();
			fos.close(); 

			url = "file://c:/temp/" + resource.getId() + "_" + resource.getAssetKey() + ".gif";

			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
		return url;
    }
    
 
    /**
     * This method returns a Resource based on it's primary key
     * @return Resource
     * @throws Exception
     */
    
    public Resource getResource(Long id) throws Exception
    {
        Resource resource = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			resource = getResource(id, session);
			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
		return resource;
    }
    
    /**
     * This method returns a Resource based on it's primary key inside a transaction
     * @return Resource
     * @throws Exception
     */
    
    public Resource getResource(Long id, Session session) throws Exception
    {
        Resource resource = (Resource)session.load(Resource.class, id);
		
		return resource;
    }
    
    
    /**
     * Gets a list of all events available sorted by primary key.
     * @return List of Resource
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
     * Gets a list of all events available for a particular day.
     * @return List of Event
     * @throws Exception
     */
    
    public List getEventList(Calendar calendar, java.util.Calendar date, Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Event event order by event.id");
   
        result = q.list();
        
        return result;
    }
    
    
    /**
     * This method returns a list of Events based on a number of parameters
     * @return List
     * @throws Exception
     */
    
    public List getEventList(Long id, java.util.Calendar startDate, java.util.Calendar endDate) throws Exception
    {
        List list = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			Calendar calendar = CalendarController.getController().getCalendar(id);
			list = getEventList(calendar, startDate, endDate, session);
			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
		return list;
    }
    
    
    /**
     * This method returns a list of Events based on a number of parameters within a transaction
     * @return List
     * @throws Exception
     */
    
    public List getEventList(Calendar calendar, java.util.Calendar startDate, java.util.Calendar endDate, Session session) throws Exception
    {
        //System.out.println("**********************");
        
        Query q = session.createQuery("from Event as event inner join fetch event.calendar as calendar where event.calendar = ? AND event.startDateTime >= ? AND event.endDateTime <= ? order by event.startDateTime");
        q.setEntity(0, calendar);
        q.setCalendar(1, startDate);
        q.setCalendar(2, endDate);
        
        List list = q.list();
        
        Iterator iterator = list.iterator();
        while(iterator.hasNext())
        {
            Object o = iterator.next();
            //System.out.println("o:" + o.getClass().getName());
            Event event = (Event)o;
            //System.out.println("event:" + event);
        }
        
        //System.out.println("**********************");

        //System.out.println("list:" + list.size());
        
		return list;
    }
    
    /**
     * Gets a list of events fetched by name.
     * @return List of Event
     * @throws Exception
     */
    
    public List getEvent(String name) throws Exception 
    {
        List events = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            events = session.find("from Event as event where event.name = ?", name, Hibernate.STRING);
                
            tx.commit();
        }
        catch (Exception e) 
        {
            if (tx!=null) 
                tx.rollback();
            throw e;
        }
        finally 
        {
            session.close();
        }
        
        return events;
    }
    
    
    /**
     * Deletes a resource object in the database. Also cascades all resources associated to it.
     * @throws Exception
     */
    
    public void deleteResource(Long id) throws Exception 
    {
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            Resource resource = this.getResource(id);
            session.delete(resource);
            
            tx.commit();
        }
        catch (Exception e) 
        {
            if (tx!=null) 
                tx.rollback();
            throw e;
        }
        finally 
        {
            session.close();
        }
    }
    
}