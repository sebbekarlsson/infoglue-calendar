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
 * This class represents a single calendar object. A calendar is called upon with a key/name.
 * 
 * @author mattias
 * 
 * @hibernate.class table="Calendar"
 */

public class Calendar 
{
    private Long id;
    private String name;
    private String description;
    private List events;

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
     * @hibernate.property name="getName" column="name" type="string" not-null="false" unique="true"
     * 
     * @return String
     */
    public String getName() 
    {
        return this.name;
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
	 * @hibernate.set name="getEvents" table="Event" inverse="false" cascade="save-update"
	 *                             
     * @hibernate.collection-key column="calendar_id"
	 * @hibernate.collection-one-to-many class="org.infoglue.calendar.entities.Event"
	 *
	 * @return List
	 *
	 */
	public List getEvents() 
	{
		return events;
	}
	
	public void setEvents(List events) 
	{
		this.events = events;
	}
}