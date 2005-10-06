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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.EventTypeController;
import org.infoglue.calendar.entities.EventType;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;

/**
 * This action represents a EventType Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEventTypeAction extends CalendarAbstractAction
{
    private static Log log = LogFactory.getLog(ViewEventTypeAction.class);

    private Long eventTypeId;
    private EventType eventType;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        log.info("eventTypeId in ViewEventType:" + eventTypeId);
        if(this.eventTypeId == null)
            this.eventTypeId = new Long(ServletActionContext.getRequest().getParameter("eventTypeId"));

        this.eventType = EventTypeController.getController().getEventType(eventTypeId, getSession());
        
        return Action.SUCCESS;
    } 

    public Long getEventTypeId()
    {
        return eventTypeId;
    }
    
    public void setEventTypeId(Long eventTypeId)
    {
        this.eventTypeId = eventTypeId;
    }

    public EventType getEventType()
    {
        return eventType;
    }

}
