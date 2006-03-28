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

package org.infoglue.calendar.actions;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.infoglue.calendar.controllers.CalendarController;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.ICalendarController;
import org.infoglue.calendar.controllers.ParticipantController;
import org.infoglue.calendar.controllers.ResourceController;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.EventCategory;
import org.infoglue.calendar.entities.EventTypeCategoryAttribute;
import org.infoglue.calendar.entities.Participant;
import org.infoglue.cms.controllers.kernel.impl.simple.UserControllerProxy;
import org.infoglue.cms.security.InfoGluePrincipal;
import org.infoglue.common.util.ActionValidatorManager;
import org.infoglue.common.util.PropertyHelper;
import org.infoglue.common.util.ResourceBundleHelper;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.ActionSupport;
import com.opensymphony.xwork.validator.ValidationException;

/**
* @author Mattias Bogeblad
*
* This is an abstract action used for all calendar actions.
*  Just to not have to put to much in the WebworkAbstractAction.
*/

public class CalendarAbstractAction extends ActionSupport
{
	private static Log log = LogFactory.getLog(CalendarAbstractAction.class);

	/**
	 * This method lets the velocity template get hold of all actions inheriting.
	 * 
	 * @return The action object currently invoked 
	 */
	
	public CalendarAbstractAction getThis()
	{
		return this;
	}

    public Map getInternalEventMap()
    {
        Map yesOrNo = new HashMap();
        yesOrNo.put("true", "labels.internal.event.isInternal.true");
        yesOrNo.put("false", "labels.internal.event.isInternal.false");
        
        return yesOrNo;
    }

    public Map getIsOrganizedByGUMap()
    {
        Map yesOrNo = new HashMap();
        yesOrNo.put("true", "labels.internal.event.isOrganizedByGU");
        
        return yesOrNo;
    }

    public Integer getSiteNodeId()
    {
        return (Integer)ServletActionContext.getRequest().getAttribute("siteNodeId");
    }

    public Integer getComponentId()
    {
        return (Integer)ServletActionContext.getRequest().getAttribute("componentId");
    }

    public String getLanguageCode()
    {
        return (String)ServletActionContext.getRequest().getAttribute("languageCode");
    }

    public String getLogoutUrl()
    {
        return (String)ServletActionContext.getRequest().getAttribute("logoutUrl");
    }

    public Integer getNumberOfItemsPerPage()
    {
        return (Integer)ServletActionContext.getRequest().getAttribute("numberOfItems");
    }

    public String getInfoGlueRemoteUser()
    {
    	return (String)ServletActionContext.getRequest().getAttribute("infoglueRemoteUser");
    }

    public List getInfoGlueRemoteUserRoles()
    {
        return (List)ServletActionContext.getRequest().getAttribute("infoglueRemoteUserRoles");
    }

    public List getInfoGlueRemoteUserGroups()
    {
        return (List)ServletActionContext.getRequest().getAttribute("infoglueRemoteUserGroups");
    }

    public InfoGluePrincipal getInfoGluePrincipal() throws Exception
    {
        return UserControllerProxy.getController().getUser(this.getInfoGlueRemoteUser());
    }
    
    public boolean getIsEventOwner(Long eventId) throws Exception
    {
        return getIsEventOwner(EventController.getController().getEvent(eventId, getSession()));
    }

    public List getAnonymousCalendars() throws Exception
    {
    	String anonymousCalendar = PropertyHelper.getProperty("anonymousCalendar");
    	System.out.println("anonymousCalendar:" + anonymousCalendar);
    	if(anonymousCalendar == null)
    		anonymousCalendar = "";
    	
    	return CalendarController.getController().getCalendar(anonymousCalendar, getSession());
    }
    
    public boolean getIsEventOwner(Event event)
    {
        boolean isEventOwner = false;
        
        try
        {
            org.infoglue.calendar.entities.Calendar owningCalendar = event.getOwningCalendar();
            if(owningCalendar != null)
            {
	            log.info("owningCalendar.getOwningRoles():" + owningCalendar.getOwningRoles());
	            log.info("this.getInfoGlueRemoteUserGroups():" + this.getInfoGlueRemoteUserGroups());
		        if(owningCalendar.getOwningRoles().size() > 0 && this.getInfoGlueRemoteUserGroups().size() == 0)
		        {
		            isEventOwner = false;
		        }
		        else
		        {
		            Set calendars = CalendarController.getController().getCalendarList(this.getInfoGlueRemoteUserRoles(), this.getInfoGlueRemoteUserGroups(), getSession());
			        
			        if(calendars.contains(owningCalendar))
			            isEventOwner = true;
		        }
            }
	    }
        catch(Exception e)
        {
            log.warn("Error occurred:" + e.getMessage(), e);
        }
        
        return isEventOwner;
    }

    
    public boolean getIsCalendarAdministrator(org.infoglue.calendar.entities.Calendar calendar)
    {
        boolean isCalendarOwner = false;
        
        try
        {
            log.info("calendar.getOwningRoles():" + calendar.getOwningRoles());
            log.info("this.getInfoGlueRemoteUserGroups():" + this.getInfoGlueRemoteUserGroups());
	        if(calendar.getOwningRoles().size() > 0 && this.getInfoGlueRemoteUserGroups().size() == 0)
	        {
	        	isCalendarOwner = false;
	        }
	        else
	        {
	            Set calendars = CalendarController.getController().getCalendarList(this.getInfoGlueRemoteUserRoles(), this.getInfoGlueRemoteUserGroups(), getSession());
		        
		        if(calendars.contains(calendar))
		        	isCalendarOwner = true;
	        }
	    }
        catch(Exception e)
        {
            log.warn("Error occurred:" + e.getMessage(), e);
        }
        
        return isCalendarOwner;
    }

    public boolean getIsEventCreator(Event event)
    {
        boolean isEventCreator = false;
        
        try
        {
        	if(this.getInfoGlueRemoteUser() == null)
        		log.warn("InfoGlue remote user is null - should not happen..");
        	else
        	{
        		if(event.getCreator().equalsIgnoreCase(this.getInfoGlueRemoteUser()))
        			isEventCreator = true;           
        	}
	    }
        catch(Exception e)
        {
            log.warn("Error occurred:" + e.getMessage(), e);
        }
        
        return isEventCreator;
    }

    public List getEventCategories(String eventString, EventTypeCategoryAttribute categoryAttribute)
    {        
        Object object = findOnValueStack(eventString);
        Event event = (Event)object;
        
        List categories = new ArrayList();
        
        Iterator i = event.getEventCategories().iterator();
        while(i.hasNext())
        {
            EventCategory eventCategory = (EventCategory)i.next();
            if(eventCategory.getEventTypeCategoryAttribute().getId().equals(categoryAttribute.getId()))
                categories.add(eventCategory.getCategory());
        }

        return categories;
    }
    
    public String getState(Integer stateId)
    {
        if(stateId == null)
            return "None";
        
        if(stateId.intValue() == 0)
            return getLabel("labels.state.working");
        if(stateId.intValue() == 2)
            return getLabel("labels.state.publish");
        if(stateId.intValue() == 3)
            return getLabel("labels.state.published");
        
        return "";
    }
    
    public String formatDate(Date date, String pattern, Locale locale)
    {	
    	if(date == null)
            return "";
     
        // Format the current time.
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
        String dateString = formatter.format(date);

        return dateString;
    }
    
    public Date parseDate(String dateString, String pattern, Locale locale)
    {	
        if(dateString == null)
            return new Date();
        
        Date date = new Date();    
        
        try
        {
	        // Format the current time.
	        SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
	        date = formatter.parse(dateString);
        }
        catch(Exception e)
        {
            log.info("Could not parse date:" + e.getMessage() + " - defaulting to now...");
        }
        
        return date;
    }

    public String formatDate(Date date, String pattern)
    {	
    	if(date == null)
            return "";
     
        // Format the current time.
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, new Locale(getLanguageCode()));
        String dateString = formatter.format(date);

        return dateString;
    }
    
    public Date parseDate(String dateString, String pattern)
    {	
        if(dateString == null)
            return new Date();
        
        Date date = new Date();    
        
        try
        {
	        // Format the current time.
	        SimpleDateFormat formatter = new SimpleDateFormat(pattern, new Locale(getLanguageCode()));
	        date = formatter.parse(dateString);
        }
        catch(Exception e)
        {
            log.info("Could not parse date:" + e.getMessage() + " - defaulting to now...");
        }
        
        return date;
    }

    /**
     * Gets a calendar object with date and hour
     * 
     * @param dateString
     * @param pattern
     * @param hour
     * @return
     */
    
    public Calendar getCalendar(String dateString, String pattern, boolean fallback)
    {	
        Calendar calendar = Calendar.getInstance();
        if(dateString == null)
        {
            //calendar.set(Calendar.HOUR_OF_DAY, hour.intValue());
            return calendar;
        }
        
        Date date = new Date();    
        
        try
        {
	        // Format the current time.
	        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
	        date = formatter.parse(dateString);
	        calendar.setTime(date);
	        //calendar.set(Calendar.HOUR_OF_DAY, hour.intValue());
        }
        catch(Exception e)
        {
            log.info("Could not parse date:" + e.getMessage() + " - defaulting to now...");
            if(!fallback)
                return null;
        }
        
        return calendar;
    }

    /**
     * Gets a calendar object which is now
     * 
     * @return
     */
    
    public Calendar getNow()
    {	
        Calendar calendar = Calendar.getInstance();
        
        return calendar;
    }

    
    public String getVCalendar(Long eventId) throws Exception
    {
        return ICalendarController.getICalendarController().getICalendarUrl(eventId, getSession());
    }
    
    public String getResourceUrl(Long resourceId) throws Exception
    {
        return ResourceController.getController().getResourceUrl(resourceId, getSession());
    }

    public String getResourceUrl(Event event, String assetKey) throws Exception
    {
        return ResourceController.getController().getResourceUrl(event, assetKey, getSession());
    }

    public Participant getParticipant(Long participantId) throws Exception
    {
        return ParticipantController.getController().getParticipant(participantId, getSession());
    }
    
    public void validateInput(CalendarAbstractAction action) throws ValidationException
    {
        String context = ActionContext.getContext().getName();
        ActionValidatorManager.validate(this, context);
        if(this.getFieldErrors() != null && this.getFieldErrors().size() > 0)
        {
            ActionContext.getContext().getValueStack().getContext().put("actionErrors", this.getActionErrors());
            ActionContext.getContext().getValueStack().getContext().put("fieldErrors", this.getFieldErrors());
            ActionContext.getContext().getValueStack().getContext().put("errorAction", this);
            
            log.info("actionErrors:" + this.getActionErrors());
            log.info("fieldErrors:" + this.getFieldErrors());
            log.info("errorAction:" + this);
            throw new ValidationException("An validation error occurred - more information is in the valuestack...");
        }
    }

    public void setError(String message, Exception e)
    {
        String context = ActionContext.getContext().getName();
        ActionContext.getContext().getValueStack().getContext().put("message", message);
        ActionContext.getContext().getValueStack().getContext().put("error", e);
    }

    public ActionContext getActionContext() throws ValidationException
    {
        return ActionContext.getContext();
    }

    public boolean useEventPublishing()
    {
        String useEventPublishing = PropertyHelper.getProperty("useEventPublishing");
        
        return (useEventPublishing.equalsIgnoreCase("true") ? true : false);
    }

    public String getTempFilePath()
    {
        String digitalAssetPath = PropertyHelper.getProperty("digitalAssetPath");
        
        return digitalAssetPath;
    }

    public boolean useEntryLimitation()
    {
        String useEntryLimitation = PropertyHelper.getProperty("useEntryLimitation");
        
        return (useEntryLimitation.equalsIgnoreCase("true") ? true : false);
    }
    
    public String getLabel(String key)
    {
        String label = key;
	    
	    try
	    {
	        String derivedValue = (String)findOnValueStack(key);
	        
	        Locale locale = new Locale(this.getLanguageCode());
	    	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
	        
	    	if(derivedValue != null)
	    	    label = resourceBundle.getString(derivedValue);
	        else
	            label = resourceBundle.getString(key);

	        if(label == null || label.equals(""))
	            label = key;
	    }
	    catch(Exception e)
	    {
	        log.warn("An label was not found:" + e.getMessage(), e);
	    }
	    
	    return label;
    }
    
    	
	public Session getSession() throws HibernateException {
	    return (Session)ServletActionContext.getRequest().getAttribute("HIBERNATE_SESSION");
	}

	public Transaction getTransaction() throws HibernateException {
	    return (Transaction)ServletActionContext.getRequest().getAttribute("HIBERNATE_TRANSACTION");
	}

	public void emptySession() throws HibernateException {
	    ServletActionContext.getRequest().removeAttribute("HIBERNATE_SESSION");
	}

	public void emptyTransaction() throws HibernateException {
	    ServletActionContext.getRequest().removeAttribute("HIBERNATE_TRANSACTION");
	}

	boolean rollBackOnly = false;
	
	public void disposeSession() throws HibernateException {
		
		log.debug("disposing");

		if (getSession()==null) return;

		if (rollBackOnly) {
			try {
				log.debug("rolling back");
				if (getTransaction()!=null) getTransaction().rollback();
			}
			catch (HibernateException e) {
			    log.error("error during rollback", e);
				throw e;
			}
			finally {
			    getSession().close();
				emptySession();
				emptyTransaction();
			}
		}
		else {
			try {
			    log.debug("committing");
				if (getTransaction()!=null) 
				{
				    getTransaction().commit();
				}
			}
			catch (HibernateException e) {
			    log.error("error during commit", e);
				getTransaction().rollback();
				throw e;
			}
			finally {
				getSession().close();
				emptySession();
				emptyTransaction();
			}
		}
	}
	/*
	protected void setRollbackOnly() {
		session.setRollBackOnly(true);
	}
	*/
	
	protected Object get(String name) {
		return ActionContext.getContext().getSession().get(name);
	}

	protected void set(String name, Object value) {
		ActionContext.getContext().getSession().put(name, value);
	} 
	
    public boolean isRollBackOnly()
    {
        return rollBackOnly;
    }
    public void setRollBackOnly(boolean rollBackOnly)
    {
        this.rollBackOnly = rollBackOnly;
    }
    
    public static Object findOnValueStack(String expr) 
    {
		ActionContext a = ActionContext.getContext();
		Object value = a.getValueStack().findValue(expr);
		return value;
	}

}

