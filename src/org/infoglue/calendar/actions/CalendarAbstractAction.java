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

import com.opensymphony.xwork.ActionSupport;

/**
* @author Mattias Bogeblad
*
* This is an abstract action used for all calendar actions.
*  Just to not have to put to much in the WebworkAbstractAction.
*/

public abstract class CalendarAbstractAction extends ActionSupport
{
   
	/**
	 * This method lets the velocity template get hold of all actions inheriting.
	 * 
	 * @return The action object currently invoked 
	 */
	
	public CalendarAbstractAction getThis()
	{
		return this;
	}

}

