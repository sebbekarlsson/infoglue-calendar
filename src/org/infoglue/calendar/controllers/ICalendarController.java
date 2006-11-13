package org.infoglue.calendar.controllers;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Blob;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Set;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventVersion;
import org.infoglue.calendar.entities.Language;
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
    
    public String getICalendarUrl(Long id, Session session) throws Exception
    {
        String url = "";

        Event event = EventController.getController().getEvent(id, session);
        Language masterLanguage = LanguageController.getController().getMasterLanguage(session);
        
		String calendarPath = PropertyHelper.getProperty("calendarPath");
		String fileName = "event_" + event.getId() + ".vcs";
		
		getVCalendar(event, masterLanguage, calendarPath + fileName);
		
		String urlBase = PropertyHelper.getProperty("urlBase");
		
		url = urlBase + "calendars/" + fileName;
		
		return url;
    }

    
    public void getVCalendar(Event event, Language language, String file) throws Exception
    {
    	Set versions = event.getVersions();
    	Iterator versionsIterator = versions.iterator();
		EventVersion eventVersion = null;
    	while(versionsIterator.hasNext())
    	{
    		EventVersion eventVersionCandidate = (EventVersion)versionsIterator.next();
    		if(eventVersionCandidate.getLanguage().getId().equals(language.getId()))
    		{
    			eventVersion = eventVersionCandidate;
    			break;
    		}
    	}
    	
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
		
		if(eventVersion != null)
			vevent.setDescription(eventVersion.getDescription());
		else
			vevent.setDescription("No description set");
		
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