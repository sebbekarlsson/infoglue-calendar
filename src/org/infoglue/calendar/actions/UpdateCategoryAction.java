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
import org.infoglue.common.util.ActionValidatorManager;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.util.OgnlValueStack;
//import com.opensymphony.xwork.validator.ActionValidatorManager;
import com.opensymphony.xwork.validator.ValidationException;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class UpdateCategoryAction extends ViewCategoryAction
{
    private Category category = new Category();
    private String validationAction = "/WebworkDispatcherPortlet/UpdateCategory";
    
    private Long categoryId;
    private String name;
    private String description;
    
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        System.out.println();
        System.out.println();
        System.out.println("UpdateCategoryAction....");
        System.out.println("name:" + name);
        String context = ActionContext.getContext().getName();
        
        ActionValidatorManager.validate(this, context); 
        //System.out.println("ActionErrors:" + this.getActionErrors().size());
        //System.out.println("FieldErrors:" + this.getFieldErrors().size());
        if(this.getFieldErrors().size() > 0)
        {
            ActionContext.getContext().getValueStack().getContext().put("actionErrors", this.getActionErrors());
            ActionContext.getContext().getValueStack().getContext().put("fieldErrors", this.getFieldErrors());
            System.out.println("INPUT....");
            System.out.println();
            System.out.println();
            return Action.INPUT;
        }
        else
        {
            CategoryController.getController().updateCategory(categoryId, name, description);
            System.out.println("SUCCESS....");
            System.out.println();
            System.out.println();
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

    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public Category getBean() 
    {
        return category;
    }

    public String getValidationAction() 
    {
        return validationAction;
    }

}
