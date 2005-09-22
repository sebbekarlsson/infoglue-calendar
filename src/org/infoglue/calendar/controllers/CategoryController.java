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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.entities.Category;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class CategoryController extends BasicController
{    
    //Logger for this class
    private static Log log = LogFactory.getLog(CategoryController.class);
        
    
    /**
     * Factory method to get CategoryController
     * 
     * @return CategoryController
     */
    
    public static CategoryController getController()
    {
        return new CategoryController();
    }
        
    
    /**
     * This method is used to create a new Category object in the database.
     */
    /*
    public Category createCategory(String name, String description) throws HibernateException, Exception 
    {
        Category category = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			category = createCategory(name, description, session);
			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
        return category;
    }
    */

    
    /**
     * This method is used to create a new Category object in the database inside a transaction.
     */
    
    public Category createCategory(String name, String description, Boolean active, Long parentCategoryId, Session session) throws HibernateException, Exception 
    {
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        category.setActive(active);
        
        if(parentCategoryId != null)
        {
	        Category parentCategory = this.getCategory(parentCategoryId, session);
	        parentCategory.getChildren().add(category);
	        category.setParent(parentCategory);
        }
        
        session.save(category);
        
        return category;
    }
    
    
    /**
     * Updates an category.
     * 
     * @throws Exception
     */

    public void updateCategory(Long id, String name, String description, Session session) throws Exception 
    {
		Category category = getCategory(id, session);
		updateCategory(category, name, description, session);
    }
    
    /**
     * Updates an category inside an transaction.
     * 
     * @throws Exception
     */
    
    public void updateCategory(Category category, String name, String description, Session session) throws Exception 
    {
        category.setName(name);
        category.setDescription(description);
	
		session.update(category);
	}
    
 
    /**
     * This method returns a Category based on it's primary key
     * @return Category
     * @throws Exception
     */
    /*
    public Category getCategory(Long id) throws Exception
    {
        Category category = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			category = getCategory(id, session);
			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
		return category;
    }
    */
    
    /**
     * This method returns a Category based on it's primary key inside a transaction
     * @return Category
     * @throws Exception
     */
    
    public Category getCategory(Long id, Session session) throws Exception
    {
        Category category = (Category)session.load(Category.class, id);
		
		return category;
    }
    
    
    /**
     * This method returns a list of Locations
     * @return List
     * @throws Exception
     */
    /*
    public List getCategoryList() throws Exception
    {
        List list = null;
        
        Session session = getSession();
        
		Transaction tx = null;
		try 
		{
			tx = session.beginTransaction();
			list = getCategoryList(session);
			tx.commit();
		}
		catch (Exception e) 
		{
		    if (tx!=null) 
		        tx.rollback();
		    throw e;
		}
		finally 
		{
		    session.close();
		}
		
		return list;
    }
    */
    
    /**
     * Gets a list of all categorys available sorted by primary key.
     * @return List of Category
     * @throws Exception
     */
    
    public List getRootCategoryList(Session session) throws Exception 
    {
        List result = null;
        
        Query q = session.createQuery("from Category category order by category.id where category.parent is null");
   
        result = q.list();
        
        return result;
    }
    
    /**
     * Gets a list of categorys fetched by name.
     * @return List of Category
     * @throws Exception
     */
    /*
    public List getCategory(String name) throws Exception 
    {
        List categorys = null;
        
        Session session = getSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            categorys = session.createQuery("from Category as category where category.name = ?").setString(0, name).list();
                
            tx.commit();
        }
        catch (Exception e) 
        {
            if (tx!=null) 
                tx.rollback();
            throw e;
        }
        finally 
        {
            session.close();
        }
        
        return categorys;
    }
    */
    
    /**
     * Deletes a category object in the database. Also cascades all events associated to it.
     * @throws Exception
     */
    
    public void deleteCategory(Long id, Session session) throws Exception 
    {
        Category category = this.getCategory(id, session);
        Category parentCategory = category.getParent();
        if(parentCategory != null)
            parentCategory.getChildren().remove(category);
        session.delete(category);            
    }
    
}