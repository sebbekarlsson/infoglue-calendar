package com.opensymphony.webwork.portlet.alternative.action;

import javax.portlet.ActionResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork.ActionInvocation;
import com.opensymphony.xwork.Result;

/**
 * Result type set from an {@link com.opensymphony.webwork.portlet.alternative.action.EventAction} indicating a
 * {@link com.opensymphony.webwork.portlet.alternative.action.RenderAction} to execute in the render phase.
 *
 * @author Nils-Helge Garli
 * @version: $LastChangedRevision: $ $LastChangedDate: $
 *
 */
public class ActionResult implements Result {
	
	/**
	 * Logger instance
	 */
	private static Log log = LogFactory.getLog(ActionResult.class);
	/**
	 * Name of view action to prepare
	 */
	private String viewAction = null;
	
	/**
	 * Execute the result. Simply sets the <code>action</code> render parameter with the 
	 * <code>viewAction</code> indicated.
	 * @see com.opensymphony.xwork.Result#execute(com.opensymphony.xwork.ActionInvocation)
	 */
	public void execute(ActionInvocation actionInvocation) throws Exception {
		log.debug("execute");
		log.debug("viewAction = " + viewAction);
		if(StringUtils.isNotEmpty(viewAction)) {
			ActionResponse response = (ActionResponse)actionInvocation.getInvocationContext().getContextMap().get(PortletActionConstants.RESPONSE);
			log.debug("Setting render viewAction parameter");
			response.setRenderParameter("action", viewAction);
		}
	}
	/**
	 * Get the view action to prepare.
	 * @return Returns the viewAction.
	 */
	public String getViewAction() {
		return viewAction;
	}
	/**
	 * Set the name of the view action to execute in the render phase
	 * @param viewAction The viewAction to set.
	 */
	public void setViewAction(String viewAction) {
		this.viewAction = viewAction;
	}
}
