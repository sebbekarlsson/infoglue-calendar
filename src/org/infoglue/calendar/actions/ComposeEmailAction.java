package org.infoglue.calendar.actions;

import java.io.File;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.portlet.PortletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.controllers.EntryController;

import com.opensymphony.webwork.ServletActionContext;
import com.opensymphony.xwork.Action;

public class ComposeEmailAction extends CalendarAbstractAction {

	private static Log log = LogFactory.getLog(ComposeEmailAction.class);

	private String emailAddresses;

	private String subject;

	private String message;

	private List attachments = new LinkedList();

	private String send;

	private String cancel;

	private String remove;

	public String execute() throws Exception {
		log.debug("execute()");
		if (PortletFileUpload.isMultipartContent(ServletActionContext
				.getRequest())) {
			log.debug("This is a multipart request.");

			DiskFileItemFactory dfif = new DiskFileItemFactory();
			PortletFileUpload pfu = new PortletFileUpload(dfif);
			List params = pfu.parseRequest(ServletActionContext.getRequest());
			for (Iterator it = params.iterator(); it.hasNext();) {
				DiskFileItem dfi = (DiskFileItem) it.next();
				if (dfi.isFormField()) {
					String paramName = dfi.getFieldName();
					String paramValue = dfi.getString();
					if (paramName.equals("emailAddresses")) {
						emailAddresses = paramValue;
					} else if (paramName.equals("subject")) {
						subject = paramValue;
					} else if (paramName.equals("message")) {
						message = paramValue;
					} else if (paramName.equals("attachments")) {
						log.error("Got param attachments: " + paramValue);
						StringTokenizer st = new StringTokenizer(paramValue,
								",[]", false);
						while (st.hasMoreTokens()) {
							String fileName = st.nextToken();
							log.error("Attachment: " + fileName);
							attachments.add(new File(fileName));
						}
					}
				} else {
					String fileName = dfi.getName();
					File f = new File(getTempFilePath() + File.separator
							+ fileName);
					log.debug("Attaching file: " + f.getPath());
					dfi.write(f);
					attachments.add(f);
				}
			}
		} else {
			if (cancel != null) {
				// cancel sending message
				return "finished";
			} else if (send != null) {
				// time to send
				log.info("Sending email to " + emailAddresses + " with "
						+ attachments.size() + " attachments.");
				EntryController.getController().mailEntries(emailAddresses,
						subject, message, attachments, this.getLocale(), this.getSession());
				return "finished";
			}
		}
		return Action.SUCCESS;
	}

	/**
	 * @return Returns the emailAddresses.
	 */
	public String getEmailAddresses() {
		return emailAddresses;
	}

	/**
	 * @param emailAddresses
	 *            The emailAddresses to set.
	 */
	public void setEmailAddresses(String emailAddresses) {
		// aaargh, ugly fix, but I didn't have time to dig deeper
		// the reason is I couldn't pass this parameter with ; since
		// that broke something on the way so I changed all ; to , and
		// now I have to change them back.
		if( emailAddresses.indexOf(",") > -1 ) {
			emailAddresses = emailAddresses.replaceAll( ",", ";" );
		}
		this.emailAddresses = emailAddresses;
	}

	/**
	 * @return Returns the message.
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message
	 *            The message to set.
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return Returns the subject.
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @param subject
	 *            The subject to set.
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * @return Returns the attachments.
	 */
	public List getAttachments() {
		return attachments;
	}

	public void setAttachments(List attachments) {
		log.debug("Got list param attachments: " + attachments);
		StringTokenizer st = new StringTokenizer(attachments.toString(), ",[]",
				false);
		while (st.hasMoreTokens()) {
			String fileName = st.nextToken();
			this.attachments.add(new File(fileName));
		}
	}

	/**
	 * @return Returns the cancel.
	 */
	public String getCancel() {
		return cancel;
	}

	/**
	 * @param cancel
	 *            The cancel to set.
	 */
	public void setCancel(String cancel) {
		log.error("Got parameter cancel: " + cancel);
		this.cancel = cancel;
	}

	/**
	 * @return Returns the send.
	 */
	public String getSend() {
		return send;
	}

	/**
	 * @param send
	 *            The send to set.
	 */
	public void setSend(String send) {
		log.debug("Got parameter send: " + send);
		this.send = send;
	}

	/**
	 * @return Returns the remove.
	 */
	public String getRemove() {
		return remove;
	}

	/**
	 * @param remove
	 *            The remove to set.
	 */
	public void setRemove(String remove) {
		this.remove = remove;
	}
}
