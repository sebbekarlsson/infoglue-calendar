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
import org.infoglue.calendar.entities.Event;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class CalendarController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(CalendarController.class);
        
    
    /**
     * Factory method to get CalendarController
     * 
     * @return CalendarController
     */
    
    public static CalendarController getController()
    {
        return new CalendarController();
    }
        
    
    /**
     * This method is used to create a new Calendar object in the database.
     */
    /*
    public Calendar createCalendar(String name, String description, String owner) throws HibernateException, Exception 
    {
        Calendar calendar = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			calendar = createCalendar(name, description, owner, session);
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
		
        return calendar;
    }
    */

    
    /**
     * This method is used to create a new Calendar object in the database inside a transaction.
     */
    
    public Calendar createCalendar(String name, String description, String owner, Session session) throws HibernateException, Exception 
    {
        Calendar calendar = new Calendar();
        calendar.setName(name);
        calendar.setDescription(description);
        calendar.setOwner(owner);
        
        session.save(calendar);
        
        return calendar;
    }
    
    
    /**
     * Updates an calendar.
     * 
     * @throws Exception
     */
    
    public void updateCalendar(Long id, String name, String description, String owner, Session session) throws Exception 
    {
		Calendar calendar = getCalendar(id, session);
		updateCalendar(calendar, name, description, owner, session);
    }
    
    /**
     * Updates an calendar inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateCalendar(Calendar calendar, String name, String description, String owner, Session session) throws Exception 
    {
        calendar.setName(name);
        calendar.setDescription(description);
        calendar.setOwner(owner);
	
		session.update(calendar);
	}
    
 
    /**
     * This method returns a Calendar based on it's primary key
     * @return Calendar
     * @throws Exception
     */
    /*
    public Calendar getCalendar(Long id) throws Exception
    {
        Calendar calendar = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			calendar = getCalendar(id, session);
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
		
		return calendar;
    }
    */
    
    /**
     * This method returns a Calendar based on it's primary key inside a transaction
     * @return Calendar
     * @throws Exception
     */
    
    public Calendar getCalendar(Long id, Session session) throws Exception
    {
        Calendar calendar = (Calendar)session.load(Calendar.class, id);
		
		return calendar;
    }
    

    /**
     * Gets a list of all calendars available sorted by primary key.
     * @return List of Calendar
     * @throws Exception
     */
    /*
    public List getCalendarList() throws Exception 
    {
        List calendars = null;

        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			calendars = getCalendarList(session);
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
        
        return calendars;
    }
    */

    /**
     * Gets a list of all calendars available sorted by primary key.
     * @return List of Calendar
     * @throws Exception
     */
    
    public List getCalendarList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Calendar calendar order by calendar.id");
   
        result = q.list();
        
        return result;
    }
    
    /**
     * Gets a list of calendars fetched by name.
     * @return List of Calendar
     * @throws Exception
     */
    /*
    public List getCalendar(String name) throws Exception 
    {
        List calendars = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            calendars = session.createQuery("from Calendar as calendar where calendar.name = ?").setString(0, name).list();
                
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
        
        return calendars;
    }
    */

    public List getCalendar(String name, Session session) throws Exception 
    {
        List calendars = null;
        
        calendars = session.createQuery("from Calendar as calendar where calendar.name = ?").setString(0, name).list();
        
        return calendars;
    }

    /**
     * Deletes a calendar object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
 /*
    public void deleteCalendar(Long id) throws Exception 
    {
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            Calendar calendar = this.getCalendar(id);
            session.delete(calendar);
            
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
    public void deleteCalendar(Long id, Session session) throws Exception 
    {
        Calendar calendar = this.getCalendar(id, session);
        session.delete(calendar);
    }
    
}