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

/**
 * This just represents a simple category for events. Such as meeting, horse show or anything else that are common.
 * 
 * @author mattias
 * 
 * @hibernate.class table="Category"
 */

public class Category
{
    private Long id;
    private String name;
    private String description;
    
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
}
