package org.infoglue.calendar.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.databeans.CalendarBean;
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.webservices.RemoteCalendarServiceImpl;
import org.infoglue.common.util.HibernateUtil;

/**
 * Servlet implementation class CalendarServlet
 */

public class CalendarServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    private final static Logger logger = Logger.getLogger(CalendarServlet.class.getName());

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<properties>");

        try
        {
        	Session session = HibernateUtil.currentSession();
        	Transaction tx = null;
        	try 
        	{
        		tx = session.beginTransaction();

        		Set<Calendar> calendarSet = CalendarController.getController().getCalendarList(session);
        	    Iterator calendarSetIterator = calendarSet.iterator();
        		while(calendarSetIterator.hasNext())
        		{
        			Calendar calendar = (Calendar)calendarSetIterator.next();
        			
        			CalendarBean calendarBean = new CalendarBean();
        			calendarBean.setId(calendar.getId());
        			calendarBean.setName(calendar.getName());
        			calendarBean.setDescription(calendar.getDescription());
        			sb.append("    <property name=\"" + StringEscapeUtils.unescapeHtml(calendar.getName()) + "\" value=\"" + calendar.getId() + "\"/>");
        		}
        		
        		tx.commit();
        	}
        	catch (Exception e) 
        	{
        		if (tx!=null) tx.rollback();
        	    throw e;
        	}
        	finally 
        	{
        		HibernateUtil.closeSession();
        	}
        }
        catch(Exception e)
        {
        	logger.error("En error occurred when we tried to create a new contentVersion:" + e.getMessage(), e);
        }

        sb.append("</properties>");

		response.setContentType("text/xml");
		
		PrintWriter pw = response.getWriter();
		
		pw.println(sb.toString());
		pw.flush();
		pw.close();
	}


}
