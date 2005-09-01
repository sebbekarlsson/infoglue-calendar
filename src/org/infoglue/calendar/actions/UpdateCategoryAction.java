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

import javax.portlet.ActionResponse;
import javax.servlet.RequestDispatcher;

import org.infoglue.calendar.controllers.CategoryController;
import org.infoglue.calendar.entities.Category;
import org.infoglue.common.exceptions.ConstraintException;
import org.infoglue.common.util.ActionValidatorManager;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.util.OgnlValueStack;
//import com.opensymphony.xwork.validator.ActionValidatorManager;
import com.opensymphony.xwork.validator.ValidationException;

/**
 * This action represents updating a category.
 * 
 * @author Mattias Bogeblad
 */

public class UpdateCategoryAction extends ViewCategoryAction
{
    private Category dataBean = new Category();
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        try
        {
            validateInput(this);
            CategoryController.getController().updateCategory(dataBean.getId(), dataBean.getName(), dataBean.getDescription(), getSession());
        }
        catch(ValidationException e)
        {
            return Action.ERROR;            
        }

        return Action.SUCCESS;
    } 
    
    public Long getCategoryId()
    {
        return dataBean.getId();
    }

    public void setCategoryId(Long categoryId)
    {
        this.dataBean.setId(categoryId);
    }

    public String getDescription()
    {
        return this.dataBean.getDescription();
    }
    
    public void setDescription(String description)
    {
        this.dataBean.setDescription(description);
    }
    
    public String getName()
    {
        return this.dataBean.getName();
    }
    
    public void setName(String name)
    {
        this.dataBean.setName(name);
    }
    
}
