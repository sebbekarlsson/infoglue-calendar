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

import net.sf.hibernate.Session;
import net.sf.hibernate.SessionFactory;
import net.sf.hibernate.cfg.Configuration;

/**
 * This class represents the basic controller which all other controllers inherits from.
 * 
 * @author Mattias Bogeblad
 */

public class BasicController
{
    private static SessionFactory sessionFactory = null;
    
    
    /**
     * This method returns a sessionFactory
     * @author Mattias Bogeblad
     */
    
    public static Session getSession() throws Exception 
    {
        if(sessionFactory == null)
        {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        }
        
        return sessionFactory.openSession();
    }
    
}
