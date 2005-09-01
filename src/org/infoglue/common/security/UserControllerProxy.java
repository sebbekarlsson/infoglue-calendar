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

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.common.exceptions.ConstraintException;
import org.infoglue.common.exceptions.SystemException;
import org.infoglue.common.util.PropertyHelper;


/**
 * @author Mattias Bogeblad
 * 
 * This class acts as the proxy for getting the all user information.
 */

public class UserControllerProxy
{
    private static final Log log = LogFactory.getLog(UserControllerProxy.class);
    
	private static AuthorizationModule authorizationModule 	= null;
	private static Properties cachedExtraProperties 		= null;
	
	private static String authConstraint;
	private static String driverClass;
	private static String connectionUrl;
	private static String connectionUserName;
	private static String connectionPassword;
	private static String authorizerClass;
	
	public static UserControllerProxy getController()
	{
		return new UserControllerProxy();
	}
	
	/**
	 * This method initializes the parameters used in this authentication framework.
	 */

	private static void initializeProperties()
	{
		try
		{
		    log.debug("*********************************************************");
		    log.debug("Initializing properties for Authentication framework.....");
		    log.debug("*********************************************************");
			
			cachedExtraProperties = new Properties();
			cachedExtraProperties.load(UserControllerProxy.class.getResourceAsStream("/infoglueSecurity.properties"));
		
			authConstraint 		= cachedExtraProperties.getProperty("org.infoglue.common.security.authConstraint");
			driverClass 		= cachedExtraProperties.getProperty("org.infoglue.common.security.jdbc.driverClass");
			connectionUrl 		= cachedExtraProperties.getProperty("org.infoglue.common.security.jdbc.connectionUrl");
			connectionUserName 	= cachedExtraProperties.getProperty("org.infoglue.common.security.jdbs.connectionUserName");
			connectionPassword 	= cachedExtraProperties.getProperty("org.infoglue.common.security.jdbs.connectionPassword");
			authorizerClass 	= cachedExtraProperties.getProperty("org.infoglue.common.security.authorizerClass");						    
			
			log.debug("authorizerClass:" + authorizerClass);
			
			cachedExtraProperties.list(System.out);
		}	
		catch(Exception e)
		{
		    cachedExtraProperties = null;
			e.printStackTrace();
		}
		
	}
	
	/**
	 * This method instantiates the AuthorizationModule.
	 */
	
	public AuthorizationModule getAuthorizationModule() throws SystemException
	{
		if(authorizationModule == null)
		{
			try
	    	{
				if(cachedExtraProperties == null)
				    initializeProperties();

				log.debug("authorizerClass:" + authorizerClass);
				authorizationModule = (AuthorizationModule)Class.forName(authorizerClass).newInstance();
				log.debug("authorizationModule:" + authorizationModule);
				
				authorizationModule.setExtraProperties(cachedExtraProperties);
	    	}
	    	catch(Exception e)
	    	{
	    		//e.printStackTrace();
	    		log.error("There was an error initializing the authorizerClass:" + e.getMessage(), e);
	    		throw new SystemException("There was an error initializing the authorizerClass:" + e.getMessage(), e);
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
	 * This method returns a complete list of available users
	 */
	
    public List getAllUsers() throws ConstraintException, SystemException, Exception
    {
    	List users = new ArrayList();
    	
		users = getAuthorizationModule().getUsers();
    	
    	return users;
    }

	/**
	 * This method returns a list of all sought for users
	 */
	
    public List getFilteredUsers(String firstName, String lastName, String userName, String email, String[] roleNames) throws ConstraintException, SystemException
    {
    	List users = new ArrayList();
    	
		users = getAuthorizationModule().getFilteredUsers(firstName, lastName, userName, email, roleNames);
    	
    	return users;
    }
    
	/**
	 * This method returns a certain user
	 */
	
    public InfoGluePrincipal getUser(String userName) throws ConstraintException, SystemException, Exception
    {
    	InfoGluePrincipal infoGluePrincipal = null;
    	
		infoGluePrincipal = getAuthorizationModule().getAuthorizedInfoGluePrincipal(userName);
    	
    	return infoGluePrincipal;
    }
    
    
	/**
	 * This method creates a new user
	 */
	
	public InfoGluePrincipal createUser(String userName, String password, String firstName, String lastName, String email) throws ConstraintException, SystemException, Exception
	{
		InfoGluePrincipal infoGluePrincipal = null;
    	
		getAuthorizationModule().createInfoGluePrincipal(userName, password, firstName, lastName, email);
    	
		return getUser(userName);
	}

	/**
	 * This method updates an existing user
	 */
	
	public void updateUser(String userName, String password, String firstName, String lastName, String email, String[] roleNames) throws ConstraintException, SystemException, Exception
	{
		getAuthorizationModule().updateInfoGluePrincipal(userName, password, firstName, lastName, email, roleNames);
	}

	/**
	 * This method makes a new password and sends it to the user
	 */
	
	public void updateUserPassword(String userName) throws ConstraintException, SystemException, Exception
	{
		getAuthorizationModule().updateInfoGluePrincipalPassword(userName);
	}

	/**
	 * This method deletes an existing user
	 */
	
	public void deleteUser(String userName) throws ConstraintException, SystemException, Exception
	{
		getAuthorizationModule().deleteInfoGluePrincipal(userName);
	}
	 
}
