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

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork.Action;

/**
 * This action represents the settings screen for the calendar system. Not implemented yet.
 * 
 * @author Mattias Bogeblad
 */

public class ViewSettingsAction extends CalendarAbstractAction
{
	private static Log log = LogFactory.getLog(ViewSettingsAction.class);

    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        return Action.SUCCESS;
    } 
/*
    public String getEmailAddresses()
    {
        return Prop
    }
   */
}
