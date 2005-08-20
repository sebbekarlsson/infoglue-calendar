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
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.portlet.PortletFileUpload;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.webwork.dispatcher.multipart.MultiPartRequestWrapper;
import com.opensymphony.xwork.ActionSupport;

/**
* @author Mattias Bogeblad
*
* This is an abstract action used for all calendar actions.
*  Just to not have to put to much in the WebworkAbstractAction.
*/

public abstract class CalendarUploadAbstractAction extends CalendarAbstractAction
{
    protected File file;
    protected String assetKey;
    protected String fileName;
    protected String fileContentType;
    protected String fileFileName;
    protected File[] files;
    protected String[] filesContentType;
    protected String[] filesFileName;

    public void setFile(File file) 
    {
        this.file = file;
    }

    public void setFileContentType(String fileContentType) 
    {
        this.fileContentType = fileContentType;
    }

    public void setFileFileName(String fileFileName) 
    {
        this.fileFileName = fileFileName;
    }

    public void setFiles(File[] files) 
    {
        this.files = files;
    }

    public void setFilesContentType(String[] filesContentType) 
    {
        this.filesContentType = filesContentType;
    }

    public void setFilesFileName(String[] filesFileName) 
    {
        this.filesFileName = filesFileName;
    }
    
    public File getFile()
    {
        /*
        MultiPartRequestWrapper multiWrapper = (MultiPartRequestWrapper) ServletActionContext.getRequest();
        if (multiWrapper.hasErrors()) {
            Collection errors = multiWrapper.getErrors();
            Iterator i = errors.iterator();
            while (i.hasNext()) {
                String error = (String) i.next();
              addActionError(error);
              System.out.println("Error:" + error);
            }
            return null;
          }
        
        Enumeration e = multiWrapper.getFileNames();

        while (e.hasMoreElements()) {
           String inputValue = (String) e.nextElement();
           String contentType = multiWrapper.getContentType(inputValue);
           String fileName = multiWrapper.getFilesystemName(inputValue);
           File file = multiWrapper.getFile(inputValue);

           // If it's null the upload failed
           if (file == null) {
              addActionError("Error uploading: " + multiWrapper.getFilesystemName(inputValue));
           }

           return file;
        }
        */
        
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
	            
	            if (!dfi.isFormField()) {
	                String fieldName = dfi.getFieldName();
	                String fileName = dfi.getName();
	                String contentType = dfi.getContentType();
	                boolean isInMemory = dfi.isInMemory();
	                long sizeInBytes = dfi.getSize();
	                
	                System.out.println("fieldName:" + fieldName);
	                System.out.println("fileName:" + fileName);
	                System.out.println("contentType:" + contentType);
	                System.out.println("isInMemory:" + isInMemory);
	                System.out.println("sizeInBytes:" + sizeInBytes);
	                File uploadedFile = new File(getTempFilePath() + File.separator + fileName);
	                dfi.write(uploadedFile);
	                return uploadedFile;
	            }

	        }
	        
	    }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        
        return file;
    }
    
    public String getFileContentType()
    {
        return fileContentType;
    }
    
    public String getFileFileName()
    {
        return fileFileName;
    }
    
    public File[] getFiles()
    {
        return files;
    }
    
    public String[] getFilesContentType()
    {
        return filesContentType;
    }
    
    public String[] getFilesFileName()
    {
        return filesFileName;
    }
    
    public String getAssetKey()
    {
        return assetKey;
    }
    
    public void setAssetKey(String assetKey)
    {
        this.assetKey = assetKey;
    }
    
    public String getFileName()
    {
        return fileName;
    }
    
    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }
}

