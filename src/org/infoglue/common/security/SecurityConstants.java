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
	
	public static String authConstraint;
	public static String driverClass;
	public static String connectionUrl;
	public static String connectionUserName;
	public static String connectionPassword;
	public static String authorizerClass;
	
	static 
	{
		try
		{
			System.out.println("*********************************************************");
			System.out.println("Initializing properties for Authentication framework.....");
			System.out.println("*********************************************************");
			
			extraProperties = new Properties();
			extraProperties.load(SecurityConstants.class.getResourceAsStream("/infoglueSecurity.properties"));
		
			authConstraint 		= extraProperties.getProperty("org.infoglue.common.security.authConstraint");
			driverClass 		= extraProperties.getProperty("org.infoglue.common.security.jdbc.driverClass");
			connectionUrl 		= extraProperties.getProperty("org.infoglue.common.security.jdbc.connectionUrl");
			connectionUserName 	= extraProperties.getProperty("org.infoglue.common.security.jdbc.connectionUserName", "");
			connectionPassword 	= extraProperties.getProperty("org.infoglue.common.security.jdbc.connectionPassword", "");
			authorizerClass 	= extraProperties.getProperty("org.infoglue.common.security.authorizerClass");
			
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