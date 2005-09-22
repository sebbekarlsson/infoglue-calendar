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

import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.EventType;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class EventTypeController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(EventTypeController.class);
        
    
    /**
     * Factory method to get EventTypeController
     * 
     * @return EventTypeController
     */
    
    public static EventTypeController getController()
    {
        return new EventTypeController();
    }
        
        
    /**
     * This method is used to create a new EventType object in the database inside a transaction.
     */
    
    public EventType createEventType(String name, String description, Session session) throws HibernateException, Exception 
    {
        EventType eventType = new EventType();
        eventType.setName(name);
        eventType.setDescription(description);
        
        session.save(eventType);
        
        return eventType;
    }
    
    
    /**
     * Updates an eventType.
     * 
     * @throws Exception
     */
    
    public void updateEventType(Long id, String name, String description, Session session) throws Exception 
    {
		EventType eventType = getEventType(id, session);
		updateEventType(eventType, name, description, session);
    }
    
    /**
     * Updates an eventType inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateEventType(EventType eventType, String name, String description, Session session) throws Exception 
    {
        eventType.setName(name);
        eventType.setDescription(description);
	
		session.update(eventType);
	}
    
 
    
    /**
     * This method returns a EventType based on it's primary key inside a transaction
     * @return EventType
     * @throws Exception
     */
    
    public EventType getEventType(Long id, Session session) throws Exception
    {
        EventType eventType = (EventType)session.load(EventType.class, id);
		
		return eventType;
    }
    
    
    
    /**
     * Gets a list of all eventTypes available sorted by primary key.
     * @return List of EventType
     * @throws Exception
     */
    
    public List getEventTypeList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from EventType eventType order by eventType.id");
   
        result = q.list();
        
        return result;
    }
    
    /**
     * Gets a list of eventTypes fetched by name.
     * @return List of EventType
     * @throws Exception
     */
    
    public List getEventType(String name, Session session) throws Exception 
    {
        List eventTypes = null;
        
        eventTypes = session.createQuery("from EventType as eventType where eventType.name = ?").setString(0, name).list();
        
        return eventTypes;
    }
    
    
    /**
     * Deletes a eventType object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
    public void deleteEventType(Long id, Session session) throws Exception 
    {
        EventType eventType = this.getEventType(id, session);
        session.delete(eventType);
    }
    
}