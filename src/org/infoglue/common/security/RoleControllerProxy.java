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


package org.infoglue.common.security;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.common.exceptions.ConstraintException;
import org.infoglue.common.exceptions.SystemException;

/**
 * @author Mattias Bogeblad
 * 
 * This class acts as the proxy for getting the right roles.
 */

public class RoleControllerProxy 
{
    private static final Log log = LogFactory.getLog(RoleControllerProxy.class);

	private static AuthorizationModule authorizationModule = null;

	public static RoleControllerProxy getController()
	{
		return new RoleControllerProxy();
	}
	
	/**
	 * This method instantiates the AuthorizationModule.
	 */
	
	public AuthorizationModule getAuthorizationModule()
	{
		if(authorizationModule == null)
		{
			try
			{
				authorizationModule = (AuthorizationModule)Class.forName(SecurityConstants.authorizerClass).newInstance();
				authorizationModule.setExtraProperties(SecurityConstants.extraProperties);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	   
		return authorizationModule;
	}

	/**
	 * This method return whether the module in question supports updates to the values.
	 */
	
	public boolean getSupportUpdate() throws ConstraintException, SystemException, Exception
	{
		return getAuthorizationModule().getSupportUpdate();
	}

	/**
	 * This method return whether the module in question supports deletes of users.
	 */
	
	public boolean getSupportDelete() throws ConstraintException, SystemException, Exception
	{
		return getAuthorizationModule().getSupportDelete();
	}

	/**
	 * This method return whether the module in question supports creation of new users.
	 */
	
	public boolean getSupportCreate() throws ConstraintException, SystemException, Exception
	{
		return getAuthorizationModule().getSupportCreate();
	}

	/**
	 * This method returns a specific content-object
	 */
	
    public List getAllRoles() throws ConstraintException, SystemException, Exception
    {
    	List roles = new ArrayList();
    	
		roles = getAuthorizationModule().getRoles();
    	
    	return roles;
    }

	/**
	 * This method returns a certain role
	 */
	
	public InfoGlueRole getRole(String roleName) throws ConstraintException, SystemException, Exception
	{
		InfoGlueRole infoGlueRole = null;
    	
		infoGlueRole = getAuthorizationModule().getAuthorizedInfoGlueRole(roleName);
    	
		return infoGlueRole;
	}

	/**
	 * This method returns a list of InfoGlue Principals which are part of this role
	 */
	
	public List getInfoGluePrincipals(String roleName) throws ConstraintException, SystemException, Exception
	{
		List infoGluePrincipals = new ArrayList();
    	
		infoGluePrincipals = getAuthorizationModule().getUsers(roleName);
    	
		return infoGluePrincipals;
	}
    
    
	/**
	 * This method creates a new role
	 */
	
	public InfoGlueRole createRole(String roleName, String description) throws ConstraintException, SystemException, Exception
	{
		InfoGlueRole infoGlueRole = null;
    	
		getAuthorizationModule().createInfoGlueRole(roleName, description);
    	
		return getRole(roleName);
	}

	/**
	 * This method updates an existing role
	 */
	
	public void updateRole(String roleName, String description, String[] userNames) throws ConstraintException, SystemException, Exception
	{
		getAuthorizationModule().updateInfoGlueRole(roleName, description, userNames);
	}

	/**
	 * This method deletes an existing user
	 */
	
	public void deleteRole(String roleName) throws ConstraintException, SystemException, Exception
	{
		getAuthorizationModule().deleteInfoGlueRole(roleName);
	}
 
}
