package org.infoglue.calendar.util;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Date;
import java.util.LinkedList;

import org.infoglue.calendar.entities.Event;

public class CalendarHelper
{
    private CalendarHelper(){}
    
    public static final CalendarHelper getCalendarHelper()
    {
        return new CalendarHelper();
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