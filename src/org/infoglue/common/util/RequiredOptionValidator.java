/*
 * Copyright (c) 2002-2003 by OpenSymphony
 * All rights reserved.
 */
package org.infoglue.common.util;

import com.opensymphony.xwork.validator.ValidationException;
import com.opensymphony.xwork.validator.validators.FieldValidatorSupport;


/**
 * RequiredOptionValidator checks that a String[] field is non-null and has a length > 0
 * (i.e. it isn't "").
 */
public class RequiredOptionValidator extends FieldValidatorSupport 
{

    public void validate(Object object) throws ValidationException 
    {
        String fieldName = getFieldName();
        Object value = this.getFieldValue(fieldName, object);
        System.out.println("fieldName:" + fieldName);
        System.out.println("value:" + value);
        
        if (!(value instanceof String[])) 
        {
            addFieldError(fieldName, object);
        } 
        else 
        {
            String[] s = (String[]) value;

            if (s.length == 0) 
            {
                System.out.println("Adding error huh...");
                addFieldError(fieldName, object);
            } 
        }
        System.out.println("Done..." + this.getValidatorContext().getFieldErrors());

    }
} 