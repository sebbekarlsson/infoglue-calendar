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

import java.util.List;

/**
 * This class represents an event. An event is something that takes place between a startdate and an enddate
 * at one or several locations.
 * 
 * @author mattias
 * 
 * @hibernate.class table="Event"
 */

public class Event
{
    private Long id;
    private String name;
    private String description;
    private java.util.Calendar startDateTime;
    private java.util.Calendar endDateTime;
    
    private Calendar calendar;
    private List locations;
    private List participants;
    private List resources;
    private List categories;
    
    /**
     * @hibernate.id generator-class="native" type="long" column="id" unsaved-value="null"
     * 
     * @return long
     */    
    public Long getId()
    {
        return id;
    }
    
    public void setId(Long id)
    {
        this.id = id;
    }
     
    /**
     * @hibernate.property name="getName" column="name" type="string" not-null="false" unique="true"
     * 
     * @return String
     */
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    /**
     * @hibernate.property name="getDescription" column="description" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description;
    }
    
    /**
     * @hibernate.property name="getEndDateTime" column="endDateTime" type="calendar" not-null="false" unique="false"
     * 
     * @return Calendar
     */
    public java.util.Calendar getEndDateTime()
    {
        return endDateTime;
    }
    
    public void setEndDateTime(java.util.Calendar endDateTime)
    {
        this.endDateTime = endDateTime;
    }
    
    /**
     * @hibernate.property name="getStartDateTime" column="startDateTime" type="calendar" not-null="false" unique="false"
     * 
     * @return Calendar
     */
    public java.util.Calendar getStartDateTime()
    {
        return startDateTime;
    }
    
    public void setStartDateTime(java.util.Calendar startDateTime)
    {
        this.startDateTime = startDateTime;
    }
    
    /**
     * @hibernate.many-to-many column="event_id" class="org.infoglue.calendar.entities.Location"
     *
     * @return List
     */
    public List getLocations()
    {
        return locations;
    }
    
    public void setLocations(List locations)
    {
        this.locations = locations;
    }
    
    /**
     * @hibernate.many-to-many column="event_id" class="org.infoglue.calendar.entities.Participant"
     *
     * @return List
     */
    public List getParticipants()
    {
        return participants;
    }
    
    public void setParticipants(List participants)
    {
        this.participants = participants;
    }
    
    /**
     * @hibernate.many-to-many column="event_id" class="org.infoglue.calendar.entities.Resource"
     *
     * @return List
     */

    public List getResources()
    {
        return resources;
    }
    
    public void setResources(List resources)
    {
        this.resources = resources;
    }
    
    /**
     * @hibernate.many-to-many column="event_id" class="org.infoglue.calendar.entities.Category"
     *
     * @return List
     */

    public List getCategories()
    {
        return categories;
    }
    
    public void setCategories(List categories)
    {
        this.categories = categories;
    }
    
    /**
     * @hibernate.property column="calendar_id" type="org.infoglue.calendar.entities.Calendar" not-null="true" 
     *
     * @return Calendar
     */
    
    public Calendar getCalendar()
    {
        return calendar;
    }
    
    public void setCalendar(Calendar calendar)
    {
        this.calendar = calendar;
    }
}
