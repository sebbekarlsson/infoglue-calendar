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
package org.infoglue.calendar.taglib;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;


/**
 * 
 */
public class SetToListTag extends AbstractTag 
{

	private static final long serialVersionUID = 3617579309963752240L;

	private Set set;
	
	/**
	 * 
	 */
	public SetToListTag() 
	{
		super();
	}
	
	public int doEndTag() throws JspException
    {
		List arrayList = new ArrayList();
		arrayList.addAll(set);
	    setResultAttribute(arrayList);
        return EVAL_PAGE;
    }

    public void setSet(final String set) throws JspException
    {
        this.set = evaluateSet("setToListTag", "set", set);
    }
}
