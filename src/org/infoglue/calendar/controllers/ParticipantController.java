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
import org.infoglue.calendar.entities.Participant;


import java.util.Iterator;
import java.util.List;

import net.sf.hibernate.*;
import net.sf.hibernate.cfg.*;

public class ParticipantController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(ParticipantController.class);
        
    
    /**
     * Factory method to get ParticipantController
     * 
     * @return ParticipantController
     */
    
    public static ParticipantController getController()
    {
        return new ParticipantController();
    }
        
    
    /**
     * This method is used to create a new Participant object in the database.
     */
    
    public Participant createParticipant(String userName, Event event) throws HibernateException, Exception 
    {
        Participant participant = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			participant = createParticipant(userName, event, session);
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
		
        return participant;
    }

    
    /**
     * This method is used to create a new Participant object in the database inside a transaction.
     */
    
    public Participant createParticipant(String userName, Event event, Session session) throws HibernateException, Exception 
    {
        System.out.println("Creating new participant...");
        
        Participant participant = new Participant();
        participant.setUserName(userName);
        participant.setEvent(event);
        
        session.save(participant);
        
        System.out.println("Finished creating participant...");
        
        return participant;
    }
    
    
    /**
     * Updates an participant.
     * 
     * @throws Exception
     */
    
    public void updateParticipant(Long id, String userName) throws Exception 
    {
	    Session session = getSession();
	    
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
		
			Participant participant = getParticipant(id, session);
			updateParticipant(participant, userName, session);
			
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
     * Updates an participant inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateParticipant(Participant participant, String userName, Session session) throws Exception 
    {
        participant.setUserName(userName);
	
		session.update(participant);
	}
    
 
    /**
     * This method returns a Participant based on it's primary key
     * @return Participant
     * @throws Exception
     */
    
    public Participant getParticipant(Long id) throws Exception
    {
        Participant participant = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			participant = getParticipant(id, session);
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
		
		return participant;
    }
    
    /**
     * This method returns a Participant based on it's primary key inside a transaction
     * @return Participant
     * @throws Exception
     */
    
    public Participant getParticipant(Long id, Session session) throws Exception
    {
        Participant participant = (Participant)session.load(Participant.class, id);
		
		return participant;
    }
    
    
    /**
     * This method returns a list of Participants
     * @return List
     * @throws Exception
     */
    
    public List getParticipantList() throws Exception
    {
        List list = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			list = getParticipantList(session);
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
     * Gets a list of all participants available sorted by primary key.
     * @return List of Participant
     * @throws Exception
     */
    
    public List getParticipantList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Participant participant order by participant.id");
   
        result = q.list();
        
        return result;
    }
    
    /**
     * Gets a list of participants fetched by name.
     * @return List of Participant
     * @throws Exception
     */
    
    public List getParticipant(String userName) throws Exception 
    {
        List participants = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            participants = session.find("from Participant as participant where participant.userName = ?", userName, Hibernate.STRING);
                
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
        
        return participants;
    }
    
    
    /**
     * Deletes a participant object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
    public void deleteParticipant(Long id) throws Exception 
    {
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            Participant participant = this.getParticipant(id);
            session.delete(participant);
            
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