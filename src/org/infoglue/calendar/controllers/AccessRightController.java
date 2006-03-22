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
import org.infoglue.cms.entities.management.AccessRight;
import org.infoglue.cms.exception.Bug;
import org.infoglue.cms.exception.SystemException;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;

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
    
}