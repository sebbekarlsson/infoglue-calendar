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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.infoglue.calendar.actions.CalendarAbstractAction;
import org.infoglue.calendar.entities.AccessRight;
import org.infoglue.common.exceptions.Bug;
import org.infoglue.common.exceptions.SystemException;
import org.infoglue.common.security.beans.InfoGluePrincipalBean;
import org.infoglue.common.util.CacheController;
import org.infoglue.common.util.WebServiceHelper;

public class AccessRightController extends BasicController
{    
    private static Log log = LogFactory.getLog(AccessRightController.class);
        
    /**
     * Factory method to get InterceptionPointController
     * 
     * @return InterceptionPointController
     */
    private static final long timeoutLength = 3600000;
    
    public static AccessRightController getController()
    {
        return new AccessRightController();
    }
        
	
	public List getAccessRightList(Long interceptionPointId, String parameters, String roleName, Session session) throws SystemException, Bug
	{
		List result = null;
        
		if(parameters == null || parameters.length() == 0)
		{
			Criteria criteria = session.createCriteria(AccessRight.class);
			criteria.createCriteria("interceptionPointId").add(Expression.eq("interceptionPointId", interceptionPointId));
	        criteria.createCriteria("parameters").add(Expression.eq("parameters", parameters));

	        criteria.createCriteria("roles").add(Expression.eq("name", roleName));

	        criteria.addOrder(Order.asc("id"));
	   
	        result = criteria.list();
		}
		else
		{
			Criteria criteria = session.createCriteria(AccessRight.class);
			criteria.createCriteria("interceptionPointId").add(Expression.eq("interceptionPointId", interceptionPointId));
	        criteria.createCriteria("parameters").add(Expression.eq("parameters", parameters));

	        criteria.createCriteria("roles").add(Expression.eq("name", roleName));

	        criteria.addOrder(Order.asc("id"));
	   
	        result = criteria.list();
		}
				
		return result;		
	}
    
	
	public List getRoles()
	{
		List list = (List)CacheController.getCachedObject("rolesCache", "allRoles", timeoutLength);
		if(list != null)
		{
			log.info("cached roles...");
			return list;			
		}
		
		try
		{
			log.info("looking for roles...");
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getRoles")));
	        if(list != null)
	        	CacheController.cacheObject("rolesCache", "allRoles", list);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			list = (List)CacheController.getCachedObject("rolesCache", "allRoles");
		}
		
		return list;
	}
	
	public List getGroups()
	{
		List list = (List)CacheController.getCachedObject("groupsCache", "allGroups", timeoutLength);
		if(list != null)
		{
			log.info("cached groups...");
			return list;			
		}
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getGroups")));
	        if(list != null)
	        	CacheController.cacheObject("groupsCache", "allGroups", list);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			list = (List)CacheController.getCachedObject("groupsCache", "allGroups");
		}
		
		return list;
	}
	
	public List getPrincipals()
	{
		List list = (List)CacheController.getCachedObject("principalsCache", "allPrincipals", timeoutLength);
		if(list != null)
		{
			log.info("cached principals...");
			return list;			
		}
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getPrincipals")));
	        if(list != null)
	        	CacheController.cacheObject("principalsCache", "allPrincipals", list);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			list = (List)CacheController.getCachedObject("principalsCache", "allPrincipals");
		}
		
		return list;
	}

	public List getPrincipalsWithRole(String roleName)
	{
		List list = (List)CacheController.getCachedObject("principalsCache", "role_principals_" + roleName, timeoutLength);
		if(list != null)
		{
			log.info("cached role principals...");
			return list;			
		}
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getPrincipalsWithRole", roleName)));
	        if(list != null)
	        	CacheController.cacheObject("principalsCache", "role_principals_" + roleName, list);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			list = (List)CacheController.getCachedObject("principalsCache", "role_principals_" + roleName);
		}
		
		return list;
	}

	public List getPrincipalsWithGroup(String groupName)
	{
		List list = (List)CacheController.getCachedObject("principalsCache", "group_principals_" + groupName, timeoutLength);
		if(list != null)
		{
			log.info("cached group principals...");
			return list;			
		}
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getPrincipalsWithGroup", groupName)));
	        if(list != null)
	        	CacheController.cacheObject("principalsCache", "group_principals_" + groupName, list);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			list = (List)CacheController.getCachedObject("principalsCache", "group_principals_" + groupName);
		}
		
		return list;
	}

	public InfoGluePrincipalBean getPrincipal(String userName)
	{
		InfoGluePrincipalBean infoGluePrincipalBean = (InfoGluePrincipalBean)CacheController.getCachedObject("principalsCache", "principal_" + userName, timeoutLength);
		if(infoGluePrincipalBean != null)
		{
			log.info("cached principal...");
			return infoGluePrincipalBean;			
		}
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        infoGluePrincipalBean = (InfoGluePrincipalBean)wsh.getObject("getPrincipal", userName);
	        if(infoGluePrincipalBean != null)
	        	CacheController.cacheObject("principalsCache", "principal_" + userName, infoGluePrincipalBean);	        	
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			infoGluePrincipalBean = (InfoGluePrincipalBean)CacheController.getCachedObject("principalsCache", "principal_" + userName);
		}
		
		return infoGluePrincipalBean;
	}

	private String getServiceURL()
	{
		CalendarAbstractAction action = new CalendarAbstractAction();
		
		return action.getSetting("remoteUserServiceURL");
	}
}