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

import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.entities.Category;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;

/**
 * This action represents a Category Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class ViewCategoryAction extends CalendarAbstractAction
{
    private Long categoryId;
    private Category category;
    private List categories;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        System.out.println("*********************************");
        System.out.println("*********************************");
        System.out.println("*********************************");
        Enumeration e = ServletActionContext.getRequest().getParameterNames();
        while(e.hasMoreElements())
        {
            String name = (String)e.nextElement();
            String value = ServletActionContext.getRequest().getParameter(name);
            System.out.println(name + "=" + value);
        }
        System.out.println("categoryId:" + categoryId);
        if(categoryId == null)
        {
            String categoryIdString = ServletActionContext.getRequest().getParameter("categoryId");
            if(categoryIdString != null && categoryIdString.length() > 0)
            	this.categoryId = new Long(categoryIdString);
        }
        
        if(categoryId != null)
        {
            this.category = CategoryController.getController().getCategory(categoryId, getSession());
            System.out.println("category:" + this.category);
            return "successDetail";
        }
        else
        {
            this.categories = CategoryController.getController().getRootCategoryList(getSession());
            System.out.println("categories:" + this.category);
            return Action.SUCCESS;
        }
        
    } 

    public Long getCategoryId()
    {
        return categoryId;
    }
    
    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public Category getCategory()
    {
        return category;
    }


    public List getCategories()
    {
        return categories;
    }
}
