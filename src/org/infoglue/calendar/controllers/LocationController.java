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
import org.infoglue.calendar.entities.Location;


import java.util.Iterator;
import java.util.List;

import net.sf.hibernate.*;
import net.sf.hibernate.cfg.*;

public class LocationController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(LocationController.class);
        
    
    /**
     * Factory method to get LocationController
     * 
     * @return LocationController
     */
    
    public static LocationController getController()
    {
        return new LocationController();
    }
        
    
    /**
     * This method is used to create a new Location object in the database.
     */
    
    public Location createLocation(String name, String description) throws HibernateException, Exception 
    {
        Location location = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			location = createLocation(name, description, session);
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
		
        return location;
    }

    
    /**
     * This method is used to create a new Location object in the database inside a transaction.
     */
    
    public Location createLocation(String name, String description, Session session) throws HibernateException, Exception 
    {
        System.out.println("Creating new location...");
        
        Location location = new Location();
        location.setName(name);
        location.setDescription(description);
        
        session.save(location);
        
        System.out.println("Finished creating location...");
        
        return location;
    }
    
    
    /**
     * Updates an location.
     * 
     * @throws Exception
     */
    
    public void updateLocation(Long id, String name, String description) throws Exception 
    {
	    Session session = getSession();
	    
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
		
			Location location = getLocation(id, session);
			updateLocation(location, name, description, session);
			
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
     * Updates an location inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateLocation(Location location, String name, String description, Session session) throws Exception 
    {
        location.setName(name);
        location.setDescription(description);
	
		session.update(location);
	}
    
 
    /**
     * This method returns a Location based on it's primary key
     * @return Location
     * @throws Exception
     */
    
    public Location getLocation(Long id) throws Exception
    {
        Location location = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			location = getLocation(id, session);
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
		
		return location;
    }
    
    /**
     * This method returns a Location based on it's primary key inside a transaction
     * @return Location
     * @throws Exception
     */
    
    public Location getLocation(Long id, Session session) throws Exception
    {
        Location location = (Location)session.load(Location.class, id);
		
		return location;
    }
    
    
    /**
     * This method returns a list of Locations
     * @return List
     * @throws Exception
     */
    
    public List getLocationList() throws Exception
    {
        List list = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			list = getLocationList(session);
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
     * Gets a list of all locations available sorted by primary key.
     * @return List of Location
     * @throws Exception
     */
    
    public List getLocationList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Location location order by location.id");
   
        result = q.list();
        
        return result;
    }
    
    /**
     * Gets a list of locations fetched by name.
     * @return List of Location
     * @throws Exception
     */
    
    public List getLocation(String name) throws Exception 
    {
        List locations = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            locations = session.find("from Location as location where location.name = ?", name, Hibernate.STRING);
                
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
        
        return locations;
    }
    
    
    /**
     * Deletes a location object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
    public void deleteLocation(Long id) throws Exception 
    {
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            Location location = this.getLocation(id);
            session.delete(location);
            
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