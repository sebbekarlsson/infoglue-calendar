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

import java.util.List;

import org.infoglue.calendar.controllers.EntryController;
import org.infoglue.calendar.entities.Entry;
import org.infoglue.calendar.entities.Event;

import com.opensymphony.xwork.Action;

/**
 * This action represents a Location Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewEntryAction extends CalendarAbstractAction
{
    private Long entryId;
    private Entry entry;
        
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        this.entry = EntryController.getController().getEntry(entryId);

        return Action.SUCCESS;
    } 

    public Entry getEntry()
    {
        return entry;
    }
    
    public void setEntry(Entry entry)
    {
        this.entry = entry;
    }
    
    public Long getEntryId()
    {
        return entryId;
    }
    
    public void setEntryId(Long entryId)
    {
        this.entryId = entryId;
    }
    
    public Object getErrorBean()
    {
        return null;
    }

}
