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
import java.util.Set;

/**
 * This class represents an event. An event is something that takes place between a startdate and an enddate
 * at one or several locations.
 * 
 * @author mattias
 * 
 * @hibernate.class table="Event"
 */

public class Event implements BaseEntity
{
    public static final Integer STATE_WORKING = new Integer(0);
    public static final Integer STATE_PUBLISH = new Integer(2);
    public static final Integer STATE_PUBLISHED = new Integer(3);
    
    private Long id;
    private String name;
    private String description;
    private java.util.Calendar startDateTime;
    private java.util.Calendar endDateTime;
    
    private Boolean isInternal;
    private Boolean isOrganizedByGU = new Boolean(false);
    private String organizerName;
    private String lecturer;
    private String customLocation;
    private String shortDescription;
    private String longDescription;
    private String eventUrl;
    private String contactName;
    private String contactEmail;
    private String contactPhone;
    private Float price;
    private java.util.Calendar lastRegistrationDateTime;
    private Integer maximumParticipants;
    private Integer stateId = STATE_WORKING; //Default if not otherwise set
    private String creator;
    
    private Calendar calendar;
    private Set locations;
    private Set participants;
    private Set resources;
    private Set eventCategories;
    
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
     * @return java.util.Calendar
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
     * @return java.util.Calendar
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
     * @hibernate.set table="Event_Location" cascade="none"
     * @hibernate.collection-key column="event_id"
     * @hibernate.collection-many-to-many class="org.infoglue.calendar.entities.Location" column="location_id"
     * 
     * @return java.util.Set
     */
    public Set getLocations()
    {
        return locations;
    }
    
    public void setLocations(Set locations)
    {
        this.locations = locations;
    }
    
	/**
     * @hibernate.set lazy="false"
     * @hibernate.collection-key column="event_id"
     * @hibernate.collection-one-to-many class="org.infoglue.calendar.entities.Participant"
   	 *
	 * @return Set
	 */ 
    public Set getParticipants()
    {
        return participants;
    }
    
    public void setParticipants(Set participants)
    {
        this.participants = participants;
    }
    
	/**
     * @hibernate.set lazy="false"
     * @hibernate.collection-key column="event_id"
     * @hibernate.collection-one-to-many class="org.infoglue.calendar.entities.Resource"
   	 *
	 * @return Set
	 */ 
    public Set getResources()
    {
        return resources;
    }
    
    public void setResources(Set resources)
    {
        this.resources = resources;
    }
    
    /** 
     * @hibernate.many-to-one class="org.infoglue.calendar.entities.Calendar" column="calendar_id"
     */  
    public Calendar getCalendar()
    {
        return calendar;
    }
    
    public void setCalendar(Calendar calendar)
    {
        this.calendar = calendar;
    }
    
    /**
     * @hibernate.property name="getContactEmail" column="contactEmail" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getContactEmail()
    {
        return contactEmail;
    }
    
    public void setContactEmail(String contactEmail)
    {
        this.contactEmail = contactEmail;
    }
    
    /**
     * @hibernate.property name="getContactName" column="contactName" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getContactName()
    {
        return contactName;
    }
    
    public void setContactName(String contactName)
    {
        this.contactName = contactName;
    }
    
    /**
     * @hibernate.property name="getContactPhone" column="contactPhone" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getContactPhone()
    {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone)
    {
        this.contactPhone = contactPhone;
    }
    
    /**
     * @hibernate.property name="getCustomLocation" column="customLocation" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getCustomLocation()
    {
        return customLocation;
    }
    
    public void setCustomLocation(String customLocation)
    {
        this.customLocation = customLocation;
    }
    
    /**
     * @hibernate.property name="getEventUrl" column="eventUrl" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getEventUrl()
    {
        return eventUrl;
    }
    
    public void setEventUrl(String eventUrl)
    {
        this.eventUrl = eventUrl;
    }
    
    /**
     * @hibernate.property name="getIsInternal" column="isInternal" type="boolean" not-null="false" unique="false"
     * 
     * @return Boolean
     */
    public Boolean getIsInternal()
    {
        return isInternal;
    }
    
    public void setIsInternal(Boolean isInternal)
    {
        this.isInternal = isInternal;
    }
    
    /**
     * @hibernate.property name="getIsOrganizedByGU" column="isOrganizedByGU" type="boolean" not-null="false" unique="false"
     * 
     * @return Boolean
     */
    public Boolean getIsOrganizedByGU()
    {
        return isOrganizedByGU;
    }
    
    public void setIsOrganizedByGU(Boolean isOrganizedByGU)
    {
        this.isOrganizedByGU = isOrganizedByGU;
    }

    /**
     * @hibernate.property name="getLastRegistrationDateTime" column="lastRegistrationDateTime" type="calendar" not-null="false" unique="false"
     * 
     * @return java.util.Calendar
     */

    public java.util.Calendar getLastRegistrationDateTime()
    {
        return lastRegistrationDateTime;
    }

    public void setLastRegistrationDateTime(java.util.Calendar lastRegistrationDateTime)
    {
        this.lastRegistrationDateTime = lastRegistrationDateTime;
    }

    /**
     * @hibernate.property name="getLecturer" column="lecturer" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getLecturer()
    {
        return lecturer;
    }
    
    public void setLecturer(String lecturer)
    {
        this.lecturer = lecturer;
    }
        
    /**
     * @hibernate.property name="getMaximumParticipants" column="maximumParticipants" type="string" not-null="false" unique="false"
     * 
     * @return Integer
     */
    public Integer getMaximumParticipants()
    {
        return maximumParticipants;
    }
    
    public void setMaximumParticipants(Integer maximumParticipants)
    {
        this.maximumParticipants = maximumParticipants;
    }
    
    /**
     * @hibernate.property name="getOrganizerName" column="organizerName" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getOrganizerName()
    {
        return organizerName;
    }
    
    public void setOrganizerName(String organizerName)
    {
        this.organizerName = organizerName;
    }
    
    /**
     * @hibernate.property name="getPrice" column="price" type="float" not-null="false" unique="false"
     * 
     * @return Float
     */
    public Float getPrice()
    {
        return price;
    }
    public void setPrice(Float price)
    {
        this.price = price;
    }
    
    /**
     * @hibernate.property name="getShortDescription" column="shortDescription" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getShortDescription()
    {
        return shortDescription;
    }
    
    public void setShortDescription(String shortDescription)
    {
        this.shortDescription = shortDescription;
    }
    
    /**
     * @hibernate.property name="getLongDescription" column="longDescription" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    public String getLongDescription()
    {
        return longDescription;
    }
    
    public void setLongDescription(String longDescription)
    {
        this.longDescription = longDescription;
    }

    public Set getEventCategories()
    {
        return eventCategories;
    }
    
    public void setEventCategories(Set eventCategories)
    {
        this.eventCategories = eventCategories;
    }
    
    /**
     * @hibernate.property name="getStateId" column="stateId" type="integer" not-null="false" unique="false"
     * 
     * @return Integer
     */
    public Integer getStateId()
    {
        return stateId;
    }
    
    public void setStateId(Integer stateId)
    {
        this.stateId = stateId;
    }
    
    /**
     * @hibernate.property name="getCreator" column="creator" type="string" not-null="false" unique="false"
     * 
     * @return String
     */
    
    public String getCreator()
    {
        return creator;
    }
    
    public void setCreator(String creator)
    {
        this.creator = creator;
    }
}
