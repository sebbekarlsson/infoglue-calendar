//$Id: PortletDispatchResult.java,v 1.3 2004/12/08 16:29:38 mattias Exp $
package com.opensymphony.webwork.portlet.alternative.action;

import java.util.Iterator;

import javax.portlet.PortletConfig;
import javax.portlet.PortletContext;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.webwork.portlet.dispatcher.PortletDispatcher;
import com.opensymphony.xwork.ActionContext;
import com.opensymphony.xwork.ActionInvocation;
import com.opensymphony.xwork.Result;

/**
 * Result type that includes a JSP to render.
 *
 * @author Nils-Helge Garli
 * @version: $LastChangedRevision: $ $LastChangedDate: $
 *
 */
public class PortletDispatchResult implements Result {

	/**
	 * Logger instance.
	 */
	private static Log log = LogFactory.getLog(PortletDispatchResult.class);
	/**
	 * The JSP to dispatch to.
	 */
	private String dispatchTo = null;
	
	/**
	 * Execute the result. Obtains the {@link javax.portlet.PortletRequestDispatcher} from the
	 * {@link PortletContext} and includes the JSP.
	 * @see com.opensymphony.xwork.Result#execute(com.opensymphony.xwork.ActionInvocation)
	 */
	
	public void execute(ActionInvocation actionInvocation) throws Exception 
	{
		log.debug("execute");
		ActionContext ctx = ActionContext.getContext();
		
		/*
		Iterator ctxIterator = ctx.getContextMap().keySet().iterator();
		while(ctxIterator.hasNext())
		{
		    System.out.println("Key:" + ctxIterator.next());
		}
		*/

		PortletDispatcher dispatcher = (PortletDispatcher)ctx.get("com.opensymphony.webwork.portlet.dispatcher.PortletDispatcher");
		//System.out.println("dispatcher:" + dispatcher);
		PortletContext context = dispatcher.getPortletContext();
		Object o = ctx.get("com.opensymphony.xwork.dispatcher.HttpServletRequest");
		System.out.println("o:" + o.getClass().getName());
		
        RenderRequest req = (RenderRequest)ctx.get("com.opensymphony.xwork.dispatcher.HttpServletRequest");
        RenderResponse res = (RenderResponse)ctx.get("com.opensymphony.xwork.dispatcher.HttpServletResponse");
		log.debug("Including jsp " + dispatchTo);
		try 
		{
		    //System.out.println("cfg:" + cfg);
		    //System.out.println("cfg.getPortletContext():" + cfg.getPortletContext());
		    System.out.println("context:" + context);
		    //System.out.println("rd:" + rd);
		    System.out.println("dispatchTo:" + dispatchTo);
		    System.out.println("req:" + req);
		    System.out.println("res:" + res);
		    context.getRequestDispatcher(dispatchTo).include(req, res);
			//cfg.getPortletContext().getRequestDispatcher(dispatchTo).include(req, res);
		}
		catch(Throwable t) {
			log.error("Error rendering JSP: " + t.getClass().getName());
			//TODO - to many causes... why
			/*
			Throwable cause = t;//.getCause();
			while(cause != null) {
				log.error("Nested: " + t.getClass().getName(), cause);
				//cause = cause.getCause();
				log.debug("Next exception: " + cause);
			}
			*/
		}
	}
	/**
	 * Get the name of the JSP to include
	 * @return Returns the dispatchTo.
	 */
	public String getDispatchTo() {
		return dispatchTo;
	}
	/**
	 * Set the name of the JSP to include
	 * @param dispatchTo The dispatchTo to set.
	 */
	public void setDispatchTo(String dispatchTo) {
		this.dispatchTo = dispatchTo;
	}
}
