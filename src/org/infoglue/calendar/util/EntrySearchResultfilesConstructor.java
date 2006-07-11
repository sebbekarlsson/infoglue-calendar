package org.infoglue.calendar.util;

import java.io.File;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infoglue.calendar.actions.CalendarAbstractAction;
import org.infoglue.common.util.JFreeReportHelper;
import org.infoglue.common.util.PropertyHelper;

import com.opensymphony.webwork.ServletActionContext;

public class EntrySearchResultfilesConstructor {

	private static Log log = LogFactory
			.getLog(EntrySearchResultfilesConstructor.class);

	private Set entries;
	private Map searchResultFiles;
	private String tempFilePath;
	private String scheme;
	private String serverName;
	private int port;
	private String fileFolderLocation;
	private List resultValues;
	private CalendarAbstractAction action;
	
	public EntrySearchResultfilesConstructor(Set entries, String tempFilePath,
			String scheme, String serverName, int port, List resultValues, CalendarAbstractAction action) {
		this.entries = entries;
		this.tempFilePath = tempFilePath;
		this.scheme = scheme;
		this.serverName = serverName;
		this.port = port;
		this.resultValues = resultValues;
		this.action = action;
		createResults();
	}

	private void createResults()
	{
		searchResultFiles = new LinkedHashMap();
		HttpServletRequest request = ServletActionContext.getRequest();
		String exportEntryResultsFolder = PropertyHelper.getProperty("exportEntryResultsFolder");
		fileFolderLocation = tempFilePath + File.separator + exportEntryResultsFolder + File.separator;
		String httpFolderLocation = scheme + "://" + serverName + ":" + port + "/infoglueCalendar/digitalAssets/" + exportEntryResultsFolder + "/";
		File f = new File(fileFolderLocation);
		if (!f.exists())
		{
			f.mkdir();
		}

		// start the thread cleaning the directory of old files
		new Thread(new ResultFilesCleaner()).start();

		String exportEntryResultsTypes = PropertyHelper.getProperty("exportEntryResultsTypes");
		if (exportEntryResultsTypes != null)
		{
			StringTokenizer st = new StringTokenizer(exportEntryResultsTypes, ",", false);
			while (st.hasMoreElements())
			{
				String resultType = st.nextToken().trim();
				if (resultType.equals("TXT"))
				{
					EntrySearchResultfilesConstructor_TXT txtConstructor = new EntrySearchResultfilesConstructor_TXT(entries, fileFolderLocation, httpFolderLocation, resultValues, action);
					if (txtConstructor.createFile())
					{
						searchResultFiles.put("Text", txtConstructor.getFileLocation());
					}
				}
				if (resultType.indexOf("CSV") > -1)
				{
					System.out.println("fileFolderLocation:" + fileFolderLocation);
					String fileName = fileFolderLocation + File.separator + "entries_" + System.currentTimeMillis() + ".csv";
					String fileURL = httpFolderLocation + "entries_" + System.currentTimeMillis() + ".csv";
					searchResultFiles.put("CSV", fileURL);
					new JFreeReportHelper().getEntriesReport(entries, fileName, "csv");
				}
				if (resultType.indexOf("XLS") > -1)
				{
					System.out.println("fileFolderLocation:" + fileFolderLocation);
					String fileName = fileFolderLocation + File.separator + "entries_" + System.currentTimeMillis() + ".xls";
					String fileURL = httpFolderLocation + "entries_" + System.currentTimeMillis() + ".xls";
					searchResultFiles.put("Excel", fileURL);
					new JFreeReportHelper().getEntriesReport(entries, fileName, "xls");
				}
				if (resultType.indexOf("PDF") > -1)
				{
					System.out.println("fileFolderLocation:" + fileFolderLocation);
					String fileName = fileFolderLocation + File.separator + "entries_" + System.currentTimeMillis() + ".pdf";
					String fileURL = httpFolderLocation + "entries_" + System.currentTimeMillis() + ".pdf";
					searchResultFiles.put("PDF", fileURL);
					new JFreeReportHelper().getEntriesReport(entries, fileName, "pdf");
				}
				if (resultType.indexOf("HTML") > -1)
				{ 
					System.out.println("fileFolderLocation:" + fileFolderLocation);
					String fileName = fileFolderLocation + File.separator + "entries_" + System.currentTimeMillis() + ".html";
					String fileURL = httpFolderLocation + "entries_" + System.currentTimeMillis() + ".html";
					searchResultFiles.put("HTML", fileURL);
					new JFreeReportHelper().getEntriesReport(entries, fileName, "html");
				}
			}
		}
	}

	public Map getResults() {
		return searchResultFiles;
	}

	class ResultFilesCleaner implements Runnable {

		long waitForTurn;

		long maxAge;

		public ResultFilesCleaner() {
			waitForTurn = PropertyHelper.getLongProperty(
					"exportEntryResultsTypesCleanerFrequency", 3600000);
			maxAge = PropertyHelper.getLongProperty(
					"exportEntryResultsTypesFileMaxage", 86400000);

			log.debug( "frequency: " + waitForTurn + ", maxAge: " + maxAge );
		}

		public void run() {
			while( true ) {
				try {
					log.debug("Running cleanup for old result files.");
					long maxAgeTime = System.currentTimeMillis() - maxAge;
					Date d = new Date( maxAgeTime );
					log.debug( "Delete older than: " + d.toString() );
					File folder = new File(fileFolderLocation);
					File[] fileNames = folder.listFiles();
					log.debug( "Found: " + fileNames.length + " files." );
					for (int i = 0; i < fileNames.length; i++) {
						File file = fileNames[i];
						log.debug( "File: " + file.getName() + ": " + file.isFile() + ", " + file.canRead() + ", " + file.canWrite() );
						if( !file.isDirectory() ) {
							log.debug( "LM: " + file.lastModified() + ", maxAge: " + maxAgeTime );
							if (file.lastModified() < maxAgeTime ) {
								log.info("Deleting file: " + file.getName());
								file.delete();
							}
						}
					}
				} catch (Exception e) {
					log.warn("Failed deleting old result files.", e);
				}
				try {
					Thread.currentThread().sleep(waitForTurn);
				} catch (Exception e) {
					log.warn("Sleep failed.", e);
				}

			}
		}
	}

}
