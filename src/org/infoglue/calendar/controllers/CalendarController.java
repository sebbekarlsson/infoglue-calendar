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

import net.sf.hibernate.*;
import net.sf.hibernate.cfg.*;

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
    
    public Calendar createCalendar(String name, String description) throws HibernateException, Exception 
    {
        System.out.println("Creating new calendar...");
        
        Calendar calendar = new Calendar();
        calendar.setName(name);
        calendar.setDescription(description);
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            session.save(calendar);
            tx.commit();
        }
        catch (Exception e) 
        {
            e.printStackTrace();
            
            if (tx!=null) 
                tx.rollback();
        }
        finally 
        {
            session.close();
        }
        
        System.out.println("Finished creating calendar...");
        
        return calendar;
    }
    
    /**
     * Updates an calendar.
     * 
     * @throws Exception
     */
    
    public void updateCalendar(Calendar calendar, String name, String description) throws Exception 
    {
        calendar.setName(name);
        calendar.setDescription(description);
	
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			session.update(calendar);
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
    
 
    /**
     * This method returns a Calendar based on it's primary key
     * @return Calendar
     * @throws Exception
     */
    
    public Calendar getCalendar(Long id) throws Exception
    {
        Calendar calendar = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			calendar = (Calendar)session.load(Calendar.class, id);
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
    
    public List getCalendar(String name) throws Exception 
    {
        List calendars = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            calendars = session.find("from Calendar as calendar where calendar.name = ?", name, Hibernate.STRING);
                
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
    
    
    /**
     * Deletes a calendar object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
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
    
}