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

package org.infoglue.calendar.entities;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * This class represents a persons entry to be present at the event.
 * It differs from participants in that it is volountary and that is is open for anyone to register while
 * participants are selected by the administrator of an event and only concerns internal users.
 * 
 * @author Mattias Bogeblad
 * 
 * @hibernate.class table="Entry"
 */

public class Entry 
{
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    
    private Event event;

    /**
     * @hibernate.id generator-class="native" type="long" column="id" unsaved-value="null"
     * 
     * @return long
     */    
    public Long getId() 
    {
        return this.id;
    }
    
    public void setId(Long id) 
    {
        this.id = id;
    }
    
    
    /**
     * @hibernate.property name="getFirstName" column="firstName" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getFirstName()
    {
        return firstName;
    }

    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }
    
    /**
     * @hibernate.property name="getLastName" column="lastName" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getLastName()
    {
        return lastName;
    }
    
    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }
    
	
    /**
     * @hibernate.property name="getEmail" column="email" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getEmail()
    {
        return email;
    }
    public void setEmail(String email)
    {
        this.email = email;
    }
    
    /** 
     * @hibernate.many-to-one class="org.infoglue.calendar.entities.Event" column="event_id"
     */  
    public Event getEvent()
    {
        return event;
    }
    
    public void setEvent(Event event)
    {
        this.event = event;
    }
}