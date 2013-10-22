/*
 * Copyright (c) 2002-2003 by OpenSymphony
 * All rights reserved.
 */
package org.infoglue.common.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.EventController;
import org.infoglue.calendar.taglib.GapchaTag;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.validator.ValidationException;
import com.opensymphony.xwork.validator.validators.FieldValidatorSupport;


/**
 * CaptchaValidator checks that the captcha text is the same as the stored captcha text.
 */
public class CaptchaValidator extends FieldValidatorSupport {
	private static Log log = LogFactory.getLog(EventController.class);
	//~ Instance fields ////////////////////////////////////////////////////////

	//~ Methods ////////////////////////////////////////////////////////////////

	public void validate(Object object) throws ValidationException
	{
		String gapchaTicket = ServletActionContext.getRequest().getParameter("gapchaTicket");
		if (gapchaTicket != null && !gapchaTicket.equals(""))
		{
			String fieldName = getFieldName();
			try
			{
				Object value = this.getFieldValue(fieldName, object);
				String verificationValue = GapchaTag.decodeTicket(gapchaTicket, null);
				if (!value.equals(verificationValue))
				{
					addFieldError(fieldName, object);
				}
			}
			catch (Exception ex)
			{
				log.error("Exception when validating gapcha. Message: " + ex.getMessage());
				addFieldError(fieldName, object);
			}
		}
		else
		{
			String useCaptchaForEntry = (String)ServletActionContext.getRequest().getSession().getAttribute("useCaptchaForEntry");
			if(useCaptchaForEntry != null && useCaptchaForEntry.equals("true"))
			{
				String fieldName = getFieldName();
				Object value = this.getFieldValue(fieldName, object);
				String captchaTextVariableName = ServletActionContext.getRequest().getParameter("captchaTextVariableName");

				String correctCaptcha = (String)ServletActionContext.getRequest().getSession().getAttribute(captchaTextVariableName);
				if(captchaTextVariableName == null || !correctCaptcha.equals(value))
				{
					addFieldError(fieldName, object);
				}
			}
		}
	}
}
