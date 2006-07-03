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

package org.infoglue.calendar.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.infoglue.calendar.entities.Event;
import org.infoglue.calendar.entities.CalendarProperty;
import org.infoglue.common.labels.controllers.LabelsController;
import org.infoglue.common.labels.controllers.LabelsPersister;
import org.infoglue.common.labels.entities.Property;
import org.infoglue.common.util.ResourceBundleHelper;
import org.infoglue.common.util.dom.DOMBuilder;

public class CalendarLabelsController implements LabelsPersister
{
	private DOMBuilder domBuilder = new DOMBuilder();
	private LabelsController labelsController = null;
	
	/**
	 * A simple factory method
	 */
	
	public static CalendarLabelsController getCalendarLabelsController()
	{
		return new CalendarLabelsController();
	}
	
	private CalendarLabelsController()
	{
		this.labelsController = LabelsController.getController(this);
	}

	/**
	 * This method returns a list (of strings) of all label-keys the system uses.
	 */
	
	public List getSystemLabels(String bundleName)
	{
		return labelsController.getSystemLabels(bundleName);
	}

	/**
	 * This method returns a list (of locales) of all defined label-languages.
	 */
	
	public List getLabelLocales(String nameSpace, Session session) throws Exception
	{
		return labelsController.getLabelLocales(nameSpace, session);
	}

	private Document getPropertyDocument(String nameSpace, Session session) throws Exception
	{
		return labelsController.getPropertyDocument(nameSpace, session);
	}
	
	public void addLabelLocale(String nameSpace, String languageCode, Session session) throws Exception
	{
		labelsController.addLabelLocale(nameSpace, languageCode, session);
	}

	public void updateLabels(String nameSpace, String languageCode, Map properties, Session session) throws Exception
	{
		labelsController.updateLabels(nameSpace, languageCode, properties, session);
	}

	public String getLabel(String nameSpace, String derivedValue, Locale locale, Session session) throws Exception
	{
		return labelsController.getLabel(nameSpace, derivedValue, locale, session);
	}

    /**
     * This method returns a Property based on it's primary key inside a transaction
     * @return Property
     * @throws Exception
     */

	public Property getProperty(Long id, Session session) throws Exception
    {
		Property property = (Property)session.load(CalendarProperty.class, id);
		
		return property;
    }
    
    
    /**
     * Gets a list of all events available for a particular day.
     * @return List of Event
     * @throws Exception
     */
    
    public Property getProperty(String nameSpace, String name, Session session) throws Exception 
    {
        Property property = null;
        
        List properties = session.createQuery("from CalendarProperty as property where property.nameSpace = ? AND property.name = ?").setString(0, nameSpace).setString(1, name).list();
        if(properties != null && properties.size() > 0)
        	property = (Property)properties.get(0);
        
        return property;
    }

    
    /**
     * This method is used to create a new Property object in the database inside a transaction.
     */
    
    public Property createProperty(String nameSpace, String name, String value, Session session) throws Exception 
    {
        Property property = new CalendarProperty();
        property.setNameSpace(nameSpace);
        property.setName(name);
        property.setValue(value);
        
        session.save(property);
        
        return property;
    }
    
    
    /**
     * Updates an property.
     * 
     * @throws Exception
     */
    
    public void updateProperty(String nameSpace, String name, String value, Session session) throws Exception 
    {
		Property property = getProperty(nameSpace, name, session);
		updateProperty(property, value, session);
    }
    
    /**
     * Updates an property inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateProperty(Property property, String value, Session session) throws Exception 
    {
        property.setValue(value);
	
		session.update(property);
	}


}
