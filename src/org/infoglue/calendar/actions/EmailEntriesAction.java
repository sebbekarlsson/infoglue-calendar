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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.EntryController;

import com.opensymphony.xwork.Action;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class EmailEntriesAction extends CalendarAbstractAction
{
    private static Log log = LogFactory.getLog(EmailEntriesAction.class);

    private String emailAddresses;
    private String subject;
    private String message;
    
    private Long[] searchEventId;
    private String searchFirstName;
    private String searchLastName;
    private String searchEmail;

    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        EntryController.getController().mailEntries(this.emailAddresses, subject, message, null, this.getLocale(), getSession());

        return Action.SUCCESS;
    } 
    
    
    public String getSearchEmail()
    {
        return searchEmail;
    }
    public void setSearchEmail(String searchEmail)
    {
        this.searchEmail = searchEmail;
    }
    public Long[] getSearchEventId()
    {
        return searchEventId;
    }
    public void setSearchEventId(Long[] searchEventId)
    {
        this.searchEventId = searchEventId;
    }
    public String getSearchFirstName()
    {
        return searchFirstName;
    }
    public void setSearchFirstName(String searchFirstName)
    {
        this.searchFirstName = searchFirstName;
    }
    public String getSearchLastName()
    {
        return searchLastName;
    }
    public void setSearchLastName(String searchLastName)
    {
        this.searchLastName = searchLastName;
    }
    
    public String getEmailAddresses()
    {
        return emailAddresses;
    }
    public void setEmailAddresses(String emailAddresses)
    {
        this.emailAddresses = emailAddresses;
    }
    public String getMessage()
    {
        return message;
    }
    public void setMessage(String message)
    {
        this.message = message;
    }
    public String getSubject()
    {
        return subject;
    }
    public void setSubject(String subject)
    {
        this.subject = subject;
    }
}
