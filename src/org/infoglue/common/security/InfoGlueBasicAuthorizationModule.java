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
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.common.util.PropertyHelper;


/**
 * @author Mattias Bogeblad
 *
 * This authentication module authenticates an user against the ordinary infoglue database.
 */

public class InfoGlueBasicAuthorizationModule implements AuthorizationModule
{
    private static final Log log = LogFactory.getLog(InfoGlueBasicAuthorizationModule.class);
    
	private Properties extraProperties = null;

	/**
	 * Gets is the implementing class can update as well as read 
	 */
	
	public boolean getSupportUpdate() 
	{
		return true;
	}

	/**
	 * Gets is the implementing class can delete as well as read 
	 */
	
	public boolean getSupportDelete()
	{
		return true;
	}
	
	/**
	 * Gets is the implementing class can create as well as read 
	 */
	
	public boolean getSupportCreate()
	{
		return true;
	}

	/**
	 * Gets an authorized InfoGluePrincipal. If the user has logged in with the root-account
	 * we immediately return - otherwise we populate it.
	 */
	
	public InfoGluePrincipal getAuthorizedInfoGluePrincipal(String userName) throws Exception
	{
		InfoGluePrincipal infogluePrincipal = null;
		
		String administratorUserName = PropertyHelper.getProperty("administratorUserName");
		String administratorEmail 	 = PropertyHelper.getProperty("administratorEmail");
		
		final boolean isAdministrator = (userName != null && userName.equalsIgnoreCase(administratorUserName)) ? true : false;
		if(isAdministrator)
		{
			infogluePrincipal = new InfoGluePrincipal(userName, "System", "Administrator", administratorEmail, new ArrayList(), isAdministrator);
		}
		else
		{	
			List roles = new ArrayList();
			
			Database db = CastorDatabaseService.getDatabase();

			try 
			{
				beginTransaction(db);
				
				SystemUser systemUser = SystemUserController.getController().getSystemUserWithName(userName, db);
				Iterator roleListIterator = systemUser.getRoles().iterator();
				while(roleListIterator.hasNext())
				{
					Role role = (Role)roleListIterator.next();
					InfoGlueRole infoGlueRole = new InfoGlueRole(role.getRoleName(), role.getDescription());
					roles.add(infoGlueRole);
				}

				infogluePrincipal = new InfoGluePrincipal(userName, systemUser.getFirstName(), systemUser.getLastName(), systemUser.getEmail(), roles, isAdministrator);
				
				commitTransaction(db);
			} 
			catch (Exception e) 
			{
				log.debug("An error occurred so we should not complete the transaction:" + e);
				rollbackTransaction(db);
				throw new SystemException(e.getMessage());
			}
		}
		
		return infogluePrincipal;
	}

	/**
	 * Gets an authorized InfoGlueRole.
	 */
	
	public InfoGlueRole getAuthorizedInfoGlueRole(String roleName) throws Exception
	{
		InfoGlueRole infoglueRole = null;

		RoleVO roleVO = RoleController.getController().getRoleVOWithId(roleName);
		
		infoglueRole = new InfoGlueRole(roleVO.getRoleName(), roleVO.getDescription());
				
		return infoglueRole;
	}

	
	/**
	 * This method gets a users roles
	 */
	
	public List authorizeUser(String userName) throws Exception
	{
		List roles = new ArrayList();
		
		String administratorUserName = PropertyHelper.getProperty("administratorUserName");
		
		boolean isAdministrator = userName.equalsIgnoreCase(administratorUserName) ? true : false;
		if(isAdministrator)
			return roles;
		
		List roleVOList = RoleController.getController().getRoleVOList(userName);
		Iterator roleVOListIterator = roleVOList.iterator();
		while(roleVOListIterator.hasNext())
		{
			RoleVO roleVO = (RoleVO)roleVOListIterator.next();
			InfoGlueRole infoGlueRole = new InfoGlueRole(roleVO.getRoleName(), roleVO.getDescription());
			roles.add(infoGlueRole);
		}
		
		return roles;
	}

	/**
	 * This method gets a list of roles
	 */
	
	public List getRoles() throws Exception
	{
		List roles = new ArrayList();
		
		List roleVOList = RoleController.getController().getRoleVOList();
		Iterator roleVOListIterator = roleVOList.iterator();
		while(roleVOListIterator.hasNext())
		{
			RoleVO roleVO = (RoleVO)roleVOListIterator.next();
			InfoGlueRole infoGlueRole = new InfoGlueRole(roleVO.getRoleName(), roleVO.getDescription());
			roles.add(infoGlueRole);
		}
		
		return roles;
	}

	/**
	 * This method gets a list of users
	 */
	
	public List getUsers() throws Exception
	{
		List users = new ArrayList();
		
		List systemUserVOList = SystemUserController.getController().getSystemUserVOList();
		Iterator systemUserVOListIterator = systemUserVOList.iterator();
		while(systemUserVOListIterator.hasNext())
		{
			SystemUserVO systemUserVO = (SystemUserVO)systemUserVOListIterator.next();

			List roles = new ArrayList();
			Collection roleVOList = RoleController.getController().getRoleVOList(systemUserVO.getUserName());
			Iterator roleVOListIterator = roleVOList.iterator();
			while(roleVOListIterator.hasNext())
			{
				RoleVO roleVO = (RoleVO)roleVOListIterator.next();
				InfoGlueRole infoGlueRole = new InfoGlueRole(roleVO.getRoleName(), roleVO.getDescription());
				roles.add(infoGlueRole);
			}
			
			InfoGluePrincipal infoGluePrincipal = new InfoGluePrincipal(systemUserVO.getUserName(), systemUserVO.getFirstName(), systemUserVO.getLastName(), systemUserVO.getEmail(), roles, false);
			
			users.add(infoGluePrincipal);
		}
		
		return users;
	}

	public List getFilteredUsers(String firstName, String lastName, String userName, String email, String[] roleIds) throws SystemException, Bug
	{
		List users = new ArrayList();
		
		List systemUserVOList = SystemUserController.getController().getFilteredSystemUserVOList(firstName, lastName, userName, email, roleIds);
		Iterator systemUserVOListIterator = systemUserVOList.iterator();
		while(systemUserVOListIterator.hasNext())
		{
			SystemUserVO systemUserVO = (SystemUserVO)systemUserVOListIterator.next();
			
			List roles = new ArrayList();
			Collection roleVOList = RoleController.getController().getRoleVOList(systemUserVO.getUserName());
			Iterator roleVOListIterator = roleVOList.iterator();
			while(roleVOListIterator.hasNext())
			{
				RoleVO roleVO = (RoleVO)roleVOListIterator.next();
				InfoGlueRole infoGlueRole = new InfoGlueRole(roleVO.getRoleName(), roleVO.getDescription());
				roles.add(infoGlueRole);
			}
			
			InfoGluePrincipal infoGluePrincipal = new InfoGluePrincipal(systemUserVO.getUserName(), systemUserVO.getFirstName(), systemUserVO.getLastName(), systemUserVO.getEmail(), roles, false);
			users.add(infoGluePrincipal);
		}
		
		return users;
	}
	
	public List getUsers(String roleName) throws Exception
	{
		log.debug("roleName:" + roleName);
		List users = new ArrayList();
		
		List systemUserVOList = RoleController.getController().getRoleSystemUserVOList(roleName);
		Iterator systemUserVOListIterator = systemUserVOList.iterator();
		while(systemUserVOListIterator.hasNext())
		{
			SystemUserVO systemUserVO = (SystemUserVO)systemUserVOListIterator.next();
			InfoGluePrincipal infoGluePrincipal = new InfoGluePrincipal(systemUserVO.getUserName(), systemUserVO.getFirstName(), systemUserVO.getLastName(), systemUserVO.getEmail(), new ArrayList(), false);
			users.add(infoGluePrincipal);
		}
		
		return users;
	}

	public void createInfoGluePrincipal(String userName, String password, String firstName, String lastName, String email) throws Exception
	{
		SystemUserController.getController().create(userName, password, firstName, lastName, email);
	}

	public void updateInfoGluePrincipal(String userName, String password, String firstName, String lastName, String email, String[] roleNames) throws Exception
	{
		SystemUserController.getController().update(userName, password, firstName, lastName, email, roleNames);
	}

	/**
	 * This method is used to send out a newpassword to an existing users.  
	 */

	public void updateInfoGluePrincipalPassword(String userName) throws Exception
	{
		SystemUserController.getController().updatePassword(userName);
	}
	
	
	public void deleteInfoGluePrincipal(String userName) throws Exception
	{
		SystemUserController.getController().delete(userName);
	}

	public void createInfoGlueRole(String roleName, String description) throws Exception
	{
		RoleController.getController().create(roleName, description);
	}

	public void updateInfoGlueRole(String roleName, String description, String[] userNames) throws Exception
	{
		RoleController.getController().update(roleName, description, userNames);
	}

	public void deleteInfoGlueRole(String roleName) throws Exception
	{
		RoleController.getController().delete(roleName);
	}

	public Properties getExtraProperties()
	{
		return extraProperties;
	}

	public void setExtraProperties(Properties extraProperties)
	{
		this.extraProperties = extraProperties;
	}

}
