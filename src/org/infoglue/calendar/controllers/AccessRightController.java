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
		List list = null;
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getRoles")));
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List getGroups()
	{
		List list = null;
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getGroups")));
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List getPrincipals()
	{
		List list = null;
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getPrincipals")));
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}

	public List getPrincipalsWithRole(String roleName)
	{
		List list = null;
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getPrincipalsWithRole", roleName)));
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}

	public List getPrincipalsWithGroup(String groupName)
	{
		List list = null;
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        wsh.setServiceUrl(getServiceURL());
	        
	        list = new ArrayList(Arrays.asList((Object[])wsh.getArray("getPrincipalsWithGroup", groupName)));
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return list;
	}

	public InfoGluePrincipalBean getPrincipal(String userName)
	{
		InfoGluePrincipalBean infoGluePrincipalBean = null;
			
		try
		{
		    WebServiceHelper wsh = new WebServiceHelper();
	        //wsh.setServiceUrl("http://localhost:8080/infoglueCMS/services/RemoteUserService");
	        wsh.setServiceUrl(getServiceURL());
	        
	        infoGluePrincipalBean = (InfoGluePrincipalBean)wsh.getObject("getPrincipal", userName);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return infoGluePrincipalBean;
	}

	private String getServiceURL()
	{
		CalendarAbstractAction action = new CalendarAbstractAction();
		
		return action.getSetting("remoteUserServiceURL");
	}
}