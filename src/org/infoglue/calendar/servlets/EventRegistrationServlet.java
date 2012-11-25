package org.infoglue.calendar.servlets;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.infoglue.calendar.controllers.EntryController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.EventTypeController;
import org.infoglue.calendar.entities.Entry;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventType;
import org.infoglue.common.security.beans.InfoGluePrincipalBean;
import org.infoglue.common.util.ConstraintExceptionBuffer;
import org.infoglue.common.util.HibernateUtil;
import org.infoglue.common.util.RemoteCacheUpdater;
import org.infoglue.common.util.VelocityTemplateProcessor;
import org.infoglue.common.util.VisualFormatter;
import org.infoglue.common.util.dom.DOMBuilder;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.validator.ValidationException;

/**
 * Servlet implementation class CalendarServlet
 */

public class EventRegistrationServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    private final static Logger logger = Logger.getLogger(EventRegistrationServlet.class.getName());

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String sb = "Service OK although this service only accepts post actions";
		PrintWriter pw = response.getWriter();
		
		pw.println(sb.toString());
		pw.flush();
		pw.close();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		ServletOutputStream output = response.getOutputStream();
   		response.setBufferSize(256);
   		response.setContentType("text/plain");
   		
		StringBuffer sb = new StringBuffer();

		System.out.println("doPost i EventRegistrationServlet");
		
		String eventId	 		= request.getParameter("eventId");
		String firstName 		= request.getParameter("firstName");
		String lastName 		= request.getParameter("lastName");
		String email 			= request.getParameter("email");
		String organisation 	= request.getParameter("organisation");
		String address 			= request.getParameter("address");
		String zipcode 			= request.getParameter("zipcode");
		
		String city 			= request.getParameter("city");
		String phone			= request.getParameter("phone");
		String fax 				= request.getParameter("fax");
		String message 			= request.getParameter("message");
		
		//Extra attributes
		String xml 				= request.getParameter("xml");
        
		Entry newEntry = null;
		
	    try
        {
    		Session session = HibernateUtil.currentSession();
        	Transaction tx = null;
        	try 
        	{
        		tx = session.beginTransaction();
        		
        		newEntry = EntryController.getController().createEntry(firstName, 
						lastName, 
						email, 
						organisation,
						address,
						zipcode,
						city,
						phone,
						fax,
						message,
						xml,
						new Long(eventId),
						session);
        		
        		//Thread.sleep(10000);
        		//System.out.println("Sleeping........");
        		
            	sb.append("OK");

        		tx.commit();
        	}
        	catch (Exception e) 
        	{
        		e.printStackTrace();
        		if (tx!=null) tx.rollback();
        	    throw e;
        	}
        	finally 
        	{
        		HibernateUtil.closeSession();
        	}
        	
        	output.print(sb.toString());
        	for(int i=0; i<25600; i++)
        		output.print(" ");
    		//output.write(sb.toString().getBytes());
    		output.flush();
    		response.flushBuffer();
    		output.close();

    		System.out.println("Written to out........");
        }
        catch(Exception e)
        {
        	System.out.println("ERRRRRRRROOOOOOOOOORRRRR");
        	e.printStackTrace();
    		sb = new StringBuffer();
			
    		System.out.println("Entry added but client disconnected... let's delete again.");
    		if(newEntry != null && newEntry.getId() != null)
    		{
	    		Session session = HibernateUtil.currentSession();
	        	Transaction tx = null;
	        	try 
	        	{
	        		tx = session.beginTransaction();
	        		
	    			EntryController.getController().deleteEntry(newEntry.getId(), session);

	        		tx.commit();
	        	}
	        	catch (Exception e2) 
	        	{
	        		if (tx!=null) tx.rollback();
	        	    logger.error("Problem deleting entry");
	        	}
	        	finally 
	        	{
	        		HibernateUtil.closeSession();
	        	}
    		}
    		
        	sb.append("NOK: An error occurred when we tried to register a person for an event with the following data:\n");
        	sb.append("firstName:" + firstName + "\n");
        	sb.append("lastName:" + lastName + "\n");
        	sb.append("email:" + email + "\n");
        	sb.append("organisation:" + organisation + "\n");
        	sb.append("address:" + address + "\n");
        	sb.append("zipcode:" + zipcode + "\n");
        	sb.append("city:" + city + "\n");
        	sb.append("phone:" + phone + "\n");
        	sb.append("fax:" + fax + "\n");
        	sb.append("message:" + message + "\n");
        	sb.append("xml:" + xml + "\n");
        	sb.append("eventId:" + eventId + "\n");

    		response.setContentType("text/plain");

    		PrintWriter pw = response.getWriter();
    		
    		pw.println(sb.toString());
    		pw.flush();
    		pw.close();

        	logger.error("En error occurred when we tried to generate eventlist:" + e.getMessage(), e);
        	logger.error(sb);
        }
        
	}

 
}
