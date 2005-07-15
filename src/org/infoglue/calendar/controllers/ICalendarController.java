package org.infoglue.calendar.controllers;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Blob;
import java.util.Date;
import java.util.LinkedList;

import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.Resource;
import org.infoglue.calendar.util.ICalendar;
import org.infoglue.calendar.util.ICalendarVEvent;
import org.infoglue.common.util.PropertyHelper;

public class ICalendarController extends BasicController
{
    private ICalendarController(){}
    
    public static final ICalendarController getICalendarController()
    {
        return new ICalendarController();
    }
    
    /**
     * This method returns a ICalendar based on it's primary key
     */
    
    public String getICalendarUrl(Long id) throws Exception
    {
        String url = "";
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			Event event = EventController.getController().getEvent(id, session);
			
			String calendarPath = PropertyHelper.getProperty("calendarPath");
			String fileName = "event_" + event.getId() + ".vcs";
			
			getVCalendar(event, calendarPath + fileName);
			
			String urlBase = PropertyHelper.getProperty("urlBase");
			
			url = urlBase + "calendars/" + fileName;

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

    
    public void getVCalendar(Event event, String file) throws Exception
    {
		ICalendar iCal = new ICalendar();
		iCal.icalEventCollection = new LinkedList();
		iCal.setProdId("InfoGlueCalendar");
		iCal.setVersion("1.0");
		// Event Test
		ICalendarVEvent vevent = new ICalendarVEvent();
		Date workDate = new Date();
		vevent.setDateStart(event.getStartDateTime().getTime());
		vevent.setDateEnd(event.getEndDateTime().getTime());
		vevent.setSummary(event.getName());
		vevent.setDescription(event.getDescription());
		vevent.setSequence(0);
		vevent.setEventClass("PUBLIC");
		vevent.setTransparency("OPAQUE");
		vevent.setDateStamp(workDate);
		vevent.setCreated(workDate);
		vevent.setLastModified(workDate);
		vevent.setOrganizer("MAILTO:sfg@eurekait.com");
		vevent.setUid("igcal-"+workDate);
		vevent.setPriority(3);
		
		iCal.icalEventCollection.add(vevent);
    	
		// Now write to string and view as file.
		System.out.println(iCal.getVCalendar()); 
		
		//writeUTF8ToFile(new File(file), iCal.getVCalendar(), false);
		writeISO88591ToFile(new File(file), iCal.getVCalendar(), false);
		//writeUTF8ToFile(new File("c:/calendar.vcs"), iCal.getVCalendar(), false);
    }
    
    
    public synchronized void writeUTF8ToFile(File file, String text, boolean isAppend) throws Exception
	{
        Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF8"));
        out.write(text);
        out.flush();
        out.close();
	}

    public synchronized void writeISO88591ToFile(File file, String text, boolean isAppend) throws Exception
	{
        Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "ISO-8859-1"));
        out.write(text);
        out.flush();
        out.close();
	}

}