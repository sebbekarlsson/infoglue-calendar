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

import java.io.File;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.portlet.ActionRequest;
import javax.servlet.ServletInputStream;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.portlet.PortletFileUpload;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.controllers.LocationController;
import org.infoglue.calendar.controllers.ResourceController;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.webwork.util.AttributeMap;
import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.util.OgnlValueStack;

/**
 * This action represents a Calendar Administration screen.
 * 
 * @author Mattias Bogeblad
 */

public class CreateResourceAction extends CalendarUploadAbstractAction
{
    private Long eventId;

    private Long calendarId;
    private String mode;
        
    /**
     * This is the entry point for the main listing.
     */
    
    public String execute() throws Exception 
    {
        System.out.println("-------------Uploading file.....");
        
        File uploadedFile = null;
        
        try
        {
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        // Configure the factory here, if desired.
	        PortletFileUpload upload = new PortletFileUpload(factory);
	        // Configure the uploader here, if desired.
	        List fileItems = upload.parseRequest(ServletActionContext.getRequest());
            System.out.println("fileItems:" + fileItems.size());
	        Iterator i = fileItems.iterator();
	        while(i.hasNext())
	        {
	            Object o = i.next();
	            DiskFileItem dfi = (DiskFileItem)o;
	            System.out.println("dfi:" + dfi.getFieldName());
	            System.out.println("dfi:" + dfi);
	            
	            if (dfi.isFormField()) {
	                String name = dfi.getFieldName();
	                String value = dfi.getString();
	                
	                System.out.println("name:" + name);
	                System.out.println("value:" + value);
	                if(name.equals("assetKey"))
	                {
	                    this.assetKey = value;
	                }
	                else if(name.equals("eventId"))
	                {
	                    this.eventId = new Long(value);
	                    ServletActionContext.getRequest().setAttribute("eventId", this.eventId);
	                }
	                else if(name.equals("calendarId"))
	                {
	                    this.calendarId = new Long(value);
	                	ServletActionContext.getRequest().setAttribute("calendarId", this.calendarId);
	            	}
	               	else if(name.equals("mode"))
	                    this.mode = value;
	            }
	            else
	            {
	                String fieldName = dfi.getFieldName();
	                String fileName = dfi.getName();
	                
	                this.fileName = fileName;
	                System.out.println("FileName:" + this.fileName);
	                uploadedFile = new File(getTempFilePath() + File.separator + fileName);
	                dfi.write(uploadedFile);
	            }

	        }
	        
	    }
        catch(Exception e)
        {
            e.printStackTrace();
        }
 
        System.out.println("Creating resources.....:" + this.eventId + ":" + ServletActionContext.getRequest().getParameter("eventId") + ":" + ServletActionContext.getRequest().getParameter("calendarId"));
        ResourceController.getController().createResource(this.eventId, this.getAssetKey(), this.getFileContentType(), this.getFileName(), uploadedFile, getSession());
        
        return Action.SUCCESS;
    } 
    
    public String getEventIdAsString()
    {
        return eventId.toString();
    }

    public String getCalendarIdAsString()
    {
        return calendarId.toString();
    }
    
    public Long getEventId()
    {
        return eventId;
    }
    
    public void setEventId(Long eventId)
    {
        this.eventId = eventId;
    }
    
    public Long getCalendarId()
    {
        return calendarId;
    }
    
    public void setCalendarId(Long calendarId)
    {
        this.calendarId = calendarId;
    }
    
    public String getMode()
    {
        return mode;
    }
    
    public void setMode(String mode)
    {
        this.mode = mode;
    }

}
