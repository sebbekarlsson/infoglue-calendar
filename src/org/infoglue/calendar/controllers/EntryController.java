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
import org.infoglue.calendar.entities.Category;
import org.infoglue.calendar.entities.Entry;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Location;
import org.infoglue.common.util.PropertyHelper;
import org.infoglue.common.util.VelocityTemplateProcessor;
import org.infoglue.common.util.io.FileHelper;
import org.infoglue.common.util.mail.MailServiceFactory;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.hibernate.*;
import net.sf.hibernate.cfg.*;

public class EntryController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(EntryController.class);
        
    
    /**
     * Factory method to get EntryController
     * 
     * @return EntryController
     */
    
    public static EntryController getController()
    {
        return new EntryController();
    }
        
    
    /**
     * This method is used to create a new Entry object in the database.
     */
    
    public Entry createEntry(String firstName, 
				            String lastName, 
				            String email, 
				            String organisation,
				            String address,
				            String zipcode,
				            String city,
				            String phone,
				            String fax,
				            String message,
							Long eventId) throws HibernateException, Exception 
    {
        Entry entry = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			Event event = EventController.getController().getEvent(eventId, session);
			entry = createEntry(firstName, 
						        lastName, 
						        email, 
						        organisation,
								address,
								zipcode,
								city,
								phone,
								fax,
								message, 
								event, 
								session);
			
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
		
        return entry;
    }

    
    /**
     * This method is used to create a new Entry object in the database inside a transaction.
     */
    
    public Entry createEntry(String firstName, 
            				 String lastName, 
            				 String email, 
            				 String organisation,
 				             String address,
 				             String zipcode,
 				             String city,
 				             String phone,
 				             String fax,
 				             String message,
 				             Event event, 
 				             Session session) throws HibernateException, Exception 
    {
        System.out.println("Creating new entry...");
        
        Entry entry = new Entry();
        entry.setFirstName(firstName);
        entry.setLastName(lastName);
        entry.setEmail(email);
        entry.setOrganisation(organisation);
        entry.setAddress(address);
        entry.setZipcode(zipcode);
        entry.setCity(city);
        entry.setPhone(phone);
        entry.setFax(fax);
        entry.setMessage(message);
        
        entry.setEvent(event);
        
        session.save(entry);
        
        System.out.println("Finished creating entry...");
        
        return entry;
    }
    
    
    /**
     * Updates an entry.
     * 
     * @throws Exception
     */
    
    public void updateEntry(Long id, 
            				String firstName, 
            				String lastName, 
            				String email,
            				String organisation,
				            String address,
				            String zipcode,
				            String city,
				            String phone,
				            String fax,
				            String message) throws Exception 
    {
	    Session session = getSession();
	    
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
		
			Entry entry = getEntry(id, session);
			
			updateEntry(entry, 
			        	firstName, 
			        	lastName, 
			        	email, 
			        	organisation,
						address,
						zipcode,
						city,
						phone,
						fax,
						message,
						session);
			
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
     * Updates an entry inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateEntry(Entry entry, 
            				String firstName, 
            				String lastName, 
            				String email,
            				String organisation,
				            String address,
				            String zipcode,
				            String city,
				            String phone,
				            String fax,
				            String message,
            				Session session) throws Exception 
    {
        entry.setFirstName(firstName);
        entry.setLastName(lastName);
        entry.setEmail(email);
        entry.setOrganisation(organisation);
        entry.setAddress(address);
        entry.setZipcode(zipcode);
        entry.setCity(city);
        entry.setPhone(phone);
        entry.setFax(fax);
        entry.setMessage(message);
        
		session.update(entry);
	}
    
 
    /**
     * This method returns a Entry based on it's primary key
     * @return Entry
     * @throws Exception
     */
    
    public Entry getEntry(Long id) throws Exception
    {
        Entry entry = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			entry = getEntry(id, session);
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
		
		return entry;
    }
    
    /**
     * This method returns a Entry based on it's primary key inside a transaction
     * @return Entry
     * @throws Exception
     */
    
    public Entry getEntry(Long id, Session session) throws Exception
    {
        Entry entry = (Entry)session.load(Entry.class, id);
		
		return entry;
    }
    
    
    /**
     * This method returns a list of Locations
     * @return List
     * @throws Exception
     */
    
    public List getEntryList() throws Exception
    {
        List list = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			list = getEntryList(session);
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
     * Gets a list of all entrys available sorted by primary key.
     * @return List of Entry
     * @throws Exception
     */
    
    public List getEntryList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Entry entry order by entry.id");
   
        result = q.list();
        
        return result;
    }
    
    
    /**
     * This method returns a list of Entries which matches a certain search
     * @return List
     * @throws Exception
     */
    
    public List getEntryList(String firstName, String lastName, String email, Long eventId, String[] categories, String[] locations) throws Exception
    {
        System.out.println("firstName:" + firstName);
        System.out.println("lastName:" + lastName);
        System.out.println("email:" + email);
        System.out.println("eventId:" + eventId);
        System.out.println("categories:" + categories);
        System.out.println("locations:" + locations);
        
        List list = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			
			list = getEntryList(eventId, firstName, lastName, email, session);
			
			Iterator entryListIterator = list.iterator();
			while(entryListIterator.hasNext())
			{
			    Entry entry = (Entry)entryListIterator.next();
			    
			    boolean isValid = true;

			    if(categories != null)
			    {
				    Map categoryHash = new HashMap();
				    Iterator categoryIterator = entry.getEvent().getCategories().iterator();
				    while(categoryIterator.hasNext())
				    {
				        Category category = (Category)categoryIterator.next();
				        categoryHash.put(category.getId().toString(), category.getId().toString());
				    }
			    
				    for(int i=0; i<categories.length; i++)
			        {
			            if(!categoryHash.containsKey(categories[i]))
				        {
				            isValid = false;
				            break;
				        }    
			        }
			    }
			    
			    if(locations != null)
			    {
				    Map locationHash = new HashMap();
				    Iterator locationIterator = entry.getEvent().getLocations().iterator();
				    while(locationIterator.hasNext())
				    {
				        Location location = (Location)locationIterator.next();
				        locationHash.put(location.getId().toString(), location.getId().toString());
				    }
				    
				    for(int i=0; i<locations.length; i++)
			        {
			            if(!locationHash.containsKey(locations[i]))
				        {
				            isValid = false;
				            break;
				        }    
			        }
			    }
			    
			    if(!isValid)
			        entryListIterator.remove();
			}
			
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
     * Gets a list of all entrys available sorted by primary key.
     * @return List of Entry
     * @throws Exception
     */
    
    public List getEntryList(Long eventId, String firstName, String lastName, String email, Session session) throws Exception 
    {
        List result = null;

        String arguments = "";
        
        
        if(eventId != null)
            arguments += "entry.event.id = :eventId ";
        if(firstName != null && firstName.length() != 0)
            arguments += (arguments.length() == 0 ? "" : "and ") + "entry.firstName = :firstName ";
        if(lastName != null && lastName.length() != 0)
            arguments += (arguments.length() == 0 ? "" : "and ") + "entry.lastName = :lastName ";
        if(email != null && email.length() != 0)
            arguments += (arguments.length() == 0 ? "" : "and ") + "entry.email = :email ";
            
        String sql = "from Entry entry where " + arguments + " order by entry.id";
        System.out.println("sql:" + sql);
        
        Query q = session.createQuery(sql);

        if(eventId != null)
            q.setParameter("eventId", eventId, Hibernate.LONG);
        if(firstName != null && firstName.length() != 0)
            q.setParameter("firstName", firstName, Hibernate.STRING);
        if(lastName != null && lastName.length() != 0)
            q.setParameter("lastName", lastName, Hibernate.STRING);
        if(email != null && email.length() != 0)
            q.setParameter("email", email, Hibernate.STRING);
        
        result = q.list();
        
        return result;
    }
    
    /**
     * Gets a list of entrys fetched by name.
     * @return List of Entry
     * @throws Exception
     */
    
    public List getEntry(String firstName) throws Exception 
    {
        List entrys = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            entrys = session.find("from Entry as entry where entry.firstName = ?", firstName, Hibernate.STRING);
                
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
        
        return entrys;
    }
    
    
    /**
     * Deletes a entry object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
    public void deleteEntry(Long id) throws Exception 
    {
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            Entry entry = this.getEntry(id);
            session.delete(entry);
            
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
     * This method emails all persons in an email-address string a message.
     * @throws Exception
     */
    
    public void mailEntries(String emailAddresses, String subject, String message) throws Exception
    {
	    String email = "";
	    
	    try
	    {
	        System.out.println("emailAddresses:" + emailAddresses);
	        System.out.println("subject:" + subject);
		    System.out.println("message:" + message);
	        
	        String template;
	        
	        String contentType = PropertyHelper.getProperty("mail.contentType");
	        if(contentType == null || contentType.length() == 0)
	            contentType = "text/html";
	        
	        if(contentType.equalsIgnoreCase("text/plain"))
	            template = FileHelper.getFileAsString(new File(PropertyHelper.getProperty("contextRootPath") + "templates/entryMessage_plain.vm"));
		    else
	            template = FileHelper.getFileAsString(new File(PropertyHelper.getProperty("contextRootPath") + "templates/entryMessage_html.vm"));
		    
		    Map parameters = new HashMap();
		    parameters.put("message", message);
		    
			StringWriter tempString = new StringWriter();
			PrintWriter pw = new PrintWriter(tempString);
			new VelocityTemplateProcessor().renderTemplate(parameters, pw, template);
			email = tempString.toString();
	    
			String systemEmailSender = PropertyHelper.getProperty("systemEmailSender");
			if(systemEmailSender == null || systemEmailSender.equalsIgnoreCase(""))
				systemEmailSender = "infoglueCalendar@" + PropertyHelper.getProperty("mail.smtp.host");

			System.out.println("email:" + email);
			MailServiceFactory.getService().send(systemEmailSender, emailAddresses, subject, email, contentType, "UTF-8");
		}
		catch(Exception e)
		{
		    e.printStackTrace();
			log.error("The notification was not sent. Reason:" + e.getMessage(), e);
		}
		
    }
 
    
    /**
     * This method emails the person with a confirmation message.
     * @throws Exception
     */
    
    public void mailVerification(Entry entry) throws Exception
    {
	    String email = "";
	    
	    try
	    {
	        System.out.println("emailAddresse:" + entry.getEmail());
	        
	        String template;
	        
	        String contentType = PropertyHelper.getProperty("mail.contentType");
	        if(contentType == null || contentType.length() == 0)
	            contentType = "text/html";
	        
	        if(contentType.equalsIgnoreCase("text/plain"))
	            template = FileHelper.getFileAsString(new File(PropertyHelper.getProperty("contextRootPath") + "templates/entryVerificationMessage_plain.vm"));
		    else
	            template = FileHelper.getFileAsString(new File(PropertyHelper.getProperty("contextRootPath") + "templates/entryVerificationMessage_html.vm"));
		    
		    Map parameters = new HashMap();
		    parameters.put("entry", entry);
		    
			StringWriter tempString = new StringWriter();
			PrintWriter pw = new PrintWriter(tempString);
			new VelocityTemplateProcessor().renderTemplate(parameters, pw, template);
			email = tempString.toString();
	    
			String systemEmailSender = PropertyHelper.getProperty("systemEmailSender");
			if(systemEmailSender == null || systemEmailSender.equalsIgnoreCase(""))
				systemEmailSender = "infoglueCalendar@" + PropertyHelper.getProperty("mail.smtp.host");

			System.out.println("email:" + email);
			MailServiceFactory.getService().send(systemEmailSender, entry.getEmail(), entry.getEvent().getName() + " - Verification", email, contentType, "UTF-8");
		}
		catch(Exception e)
		{
		    e.printStackTrace();
			log.error("The notification was not sent. Reason:" + e.getMessage(), e);
		}
		
    }
 
}