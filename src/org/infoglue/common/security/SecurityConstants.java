package org.infoglue.common.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
* @author Mattias Bogeblad
*
* This class holds all general properties concerning security.
*/

public class SecurityConstants
{
    
    private static final Log log = LogFactory.getLog(SecurityConstants.class);
    
    public static Properties extraProperties = null;
	
	public static String authConstraint			= null;
	public static String driverClass			= null;
	public static String connectionUrl			= null;
	public static String connectionUserName		= null;
	public static String connectionPassword		= null;
	public static String authorizerClass		= null;
	
	public static String loginUrl 				= null;
	public static String invalidLoginUrl 		= null;
	public static String authenticatorClass 	= null;
	public static String serverName	 			= null;
	public static String casValidateUrl			= null;
	public static String casServiceUrl			= null;
	public static String casRenew				= null;
	
	static 
	{
		try
		{
			System.out.println("*********************************************************");
			System.out.println("Initializing properties for Authentication framework.....");
			System.out.println("*********************************************************");
			
			extraProperties = new Properties();
			extraProperties.load(SecurityConstants.class.getResourceAsStream("/infoglueSecurity.properties"));
		
			driverClass 		= extraProperties.getProperty("org.infoglue.common.security.jdbc.driverClass");
			connectionUrl 		= extraProperties.getProperty("org.infoglue.common.security.jdbc.connectionUrl");
			connectionUserName 	= extraProperties.getProperty("org.infoglue.common.security.jdbc.connectionUserName", "");
			connectionPassword 	= extraProperties.getProperty("org.infoglue.common.security.jdbc.connectionPassword", "");
			
			loginUrl 			= extraProperties.getProperty("org.infoglue.common.security.loginUrl");
			invalidLoginUrl 	= extraProperties.getProperty("org.infoglue.common.security.invalidLoginUrl");
			authConstraint 		= extraProperties.getProperty("org.infoglue.common.security.authConstraint");
			authorizerClass 	= extraProperties.getProperty("org.infoglue.common.security.authorizerClass");
			authenticatorClass 	= extraProperties.getProperty("org.infoglue.common.security.authenticatorClass");
			serverName 			= extraProperties.getProperty("org.infoglue.common.security.serverName");

			casValidateUrl 		= extraProperties.getProperty("org.infoglue.common.security.cas.validateUrl");
			casServiceUrl 		= extraProperties.getProperty("org.infoglue.common.security.cas.serviceUrl");
			casRenew 			= extraProperties.getProperty("org.infoglue.common.security.cas.renew");			
			
			log.debug("authorizerClass:" + authorizerClass);
			log.debug("connectionUserName:" + connectionUserName);
			log.debug("connectionPassword:" + connectionPassword);
			
			extraProperties.list(System.out);
		}	
		catch(Exception e)
		{
		    extraProperties = null;
			e.printStackTrace();
		}
		
	}
 
}