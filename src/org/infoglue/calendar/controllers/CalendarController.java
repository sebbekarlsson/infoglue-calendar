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
import org.infoglue.calendar.entities.Calendar;
import org.infoglue.calendar.entities.Event;

import java.util.Iterator;
import java.util.List;

import net.sf.hibernate.*;
import net.sf.hibernate.cfg.*;

public class CalendarController 
{    
    private static Log log = LogFactory.getLog(CalendarController.class);
    
    private static SessionFactory sessionFactory;
    
    static 
    {
        try 
        {
            // Create the SessionFactory
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } 
        catch (Throwable ex) 
        {
            log.error("Initial SessionFactory creation failed.", ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    
    /**
     * Factory method to get CalendarController
     * 
     * @return CalendarController
     */
    
    public static CalendarController getController()
    {
        return new CalendarController();
    }
    
    /*
    public void configure() throws HibernateException 
    {
        _sessions = new Configuration()
            .addClass(Blog.class)
            .addClass(BlogItem.class)
            .buildSessionFactory();
    }
    */
    
    
    public Calendar createCalendar(String name) throws HibernateException {
        
        Calendar calendar = new Calendar();
        calendar.setName(name);
        calendar.setEvents( new ArrayList() );
        calendar.setDescription("My first calendar...");
        
        Session session = sessionFactory.openSession();
        
        Transaction tx = null;
        
        try 
        {
            tx = session.beginTransaction();
            
            session.save(calendar);
            
            tx.commit();
        }
        catch (HibernateException he) 
        {
            if (tx!=null) 
                tx.rollback();
            throw he;
        }
        finally 
        {
            session.close();
        }
        
        return calendar;
    }
    
    /*
    public BlogItem createBlogItem(Blog blog, String title, String text)
                        throws HibernateException {
        
        BlogItem item = new BlogItem();
        item.setTitle(title);
        item.setText(text);
        item.setBlog(blog);
        item.setDatetime( Calendar.getInstance() );
        blog.getItems().add(item);
        
        Session session = _sessions.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(blog);
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
        return item;
    }
    
    public BlogItem createBlogItem(Long blogid, String title, String text)
                        throws HibernateException {
        
        BlogItem item = new BlogItem();
        item.setTitle(title);
        item.setText(text);
        item.setDatetime( Calendar.getInstance() );
        
        Session session = _sessions.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Blog blog = (Blog) session.load(Blog.class, blogid);
            item.setBlog(blog);
            blog.getItems().add(item);
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
        return item;
    }
    
    public void updateBlogItem(BlogItem item, String text)
                    throws HibernateException {
        
        item.setText(text);
        
        Session session = _sessions.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(item);
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
    }
    
    public void updateBlogItem(Long itemid, String text)
                    throws HibernateException {
    
        Session session = _sessions.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            BlogItem item = (BlogItem) session.load(BlogItem.class, itemid);
            item.setText(text);
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
    }
    
    public List listAllBlogNamesAndItemCounts(int max)
                    throws HibernateException {
        
        Session session = _sessions.openSession();
        Transaction tx = null;
        List result = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery(
                "select blog.id, blog.name, count(blogItem) " +
                "from Blog as blog " +
                "left outer join blog.items as blogItem " +
                "group by blog.name, blog.id " +
                "order by max(blogItem.datetime)"
            );
            q.setMaxResults(max);
            result = q.list();
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
        return result;
    }
    
    public Blog getBlogAndAllItems(Long blogid)
                    throws HibernateException {
        
        Session session = _sessions.openSession();
        Transaction tx = null;
        Blog blog = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery(
                "from Blog as blog " +
                "left outer join fetch blog.items " +
                "where blog.id = :blogid"
            );
            q.setParameter("blogid", blogid);
            blog  = (Blog) q.list().get(0);
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
        return blog;
    }
    
    public List listBlogsAndRecentItems() throws HibernateException {
        
        Session session = _sessions.openSession();
        Transaction tx = null;
        List result = null;
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery(
                "from Blog as blog " +
                "inner join blog.items as blogItem " +
                "where blogItem.datetime > :minDate"
            );

            Calendar cal = Calendar.getInstance();
            cal.roll(Calendar.MONTH, false);
            q.setCalendar("minDate", cal);
            
            result = q.list();
            tx.commit();
        }
        catch (HibernateException he) {
            if (tx!=null) tx.rollback();
            throw he;
        }
        finally {
            session.close();
        }
        return result;
    }
    */
}