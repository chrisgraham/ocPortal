import java.applet.*;
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.io.*;
import org.apache.commons.net.ftp.*;
import netscape.javascript.*;



/**
 * 
 */

/**
 * @author toweruser
 *
 */
public class Uploader extends JApplet implements Runnable
{
	// set some basic colours...
	private Color backgroundColor = new Color(255, 255, 255);
	private Color foregroundColor = new Color(0, 0, 0);
	
	// the file that we are going to be uploading
	private File theFile = null;
	
	// the file name and path that we are uploading to...
	private String uploadedFileName = "/home/rjohnson/test.doc";
	private String address = "ftp.blah.com";
	private String username = "anonymous";
	private String password = "temp@blah.com";
	
	// the field that the filename will be written to
	private String fileNameID = "hidFileName_file";
	
	// the field that the success status will be written to
	private String nameID = "file";
	
	// stuff relayed back if we cancel (params to ocPortal replace_file_input function)
	private String _btn_submit_id = "submit_button";
	private String page_type = "file";
	private String posting_field_name = "post";
	
	// Internationalisation
	private String fail_message="You chose to not grant the Java file uploader access to upload files from your computer. That's fine: we're loading an alternative uploader for you instead which doesn't need special access. If you need to upload a large file (more than 50 MB) we recommend you refresh and grant permission, as this uploader is able to be more robust that the alternatives.";
	private String uploaded_message="Uploaded";
	private String reverting_title = "Reverting to basic uploader";
	private String valid_types_label = "Valid file types";
	private String refused_connection = "FTP server refused connection.";
	private String output_complete = "Upload Complete";
	private String transfer_error = "Transfer error";
	private String file_name_label = "File Name:";
	private String browse_label = "Browse...";
	private String upload_label = "Upload";
	private String please_choose_file = "Please choose a file";
	private String wrong_path = "Output stream failed (wrong path?) for ";
	private String max_size_label = "maximum size";
	private String too_large = "File too large";
	
	// Valid file types and size
	private String types = "PNG";
	private int maxLength = 100000000;
	
	// we track to see if the uploading thread is running
	private boolean isUploading = false;
	
	// have we successfully uploaded?
	private boolean hasUploaded = false;
	
	// some interface stuff
	private JTextField txtFileName;
	private JButton btnBrowse;
	private JButton btnSubmit;

	/**
	 * setup this applet, get some params from the page...
	 */
	public void init()
	{
		// here we need to setup the basic user interface...
		// I will be moving to a picture-based system in the future but this will do for now...
		
		// parse any parameters that have been passed
		String temp = this.getParameter("backgroundColor");
		if (temp != null)
		{
			this.backgroundColor = Color.decode(temp);
		}
		temp = this.getParameter("foregroundColor");
		if (temp != null)
		{
			this.foregroundColor = Color.decode(temp);
		}
		temp = this.getParameter("uploadedFileName");
		if (temp != null) this.uploadedFileName = temp;
		temp = this.getParameter("address");
		if (temp != null) this.address = temp;
		temp = this.getParameter("username");
		if (temp != null) this.username = temp;
		temp = this.getParameter("password");
		if (temp != null) this.password = temp;
		temp = this.getParameter("fileNameID");
		if (temp != null) this.fileNameID = temp;
		temp = this.getParameter("nameID");
		if (temp != null) this.nameID = temp;
		temp = this.getParameter("types");
		if (temp != null) this.types = temp;
		temp = this.getParameter("maxLength");
		if (temp != null) this.maxLength = Integer.parseInt(temp);
		temp = this.getParameter("_btn_submit_id");
		if (temp != null) this._btn_submit_id = temp;
		temp = this.getParameter("page_type");
		if (temp != null) this.page_type = temp;
		temp = this.getParameter("posting_field_name");
		if (temp != null) this.posting_field_name = temp;
		
		// internationalisation parameters
		temp = this.getParameter("fail_message");
		if (temp != null) this.fail_message = temp.replace("\\n","\n");
		temp = this.getParameter("uploaded_message");
		if (temp != null) this.uploaded_message = temp;
		temp = this.getParameter("reverting_title");
		if (temp != null) this.reverting_title = temp;
		temp = this.getParameter("valid_types_label");
		if (temp != null) this.valid_types_label = temp;
		temp = this.getParameter("refused_connection");
		if (temp != null) this.refused_connection = temp;
		temp = this.getParameter("output_complete");
		if (temp != null) this.output_complete = temp;
		temp = this.getParameter("transfer_error");
		if (temp != null) this.transfer_error = temp;
		temp = this.getParameter("file_name_label");
		if (temp != null) this.file_name_label = temp;
		temp = this.getParameter("browse_label");
		if (temp != null) this.browse_label = temp;
		temp = this.getParameter("upload_label");
		if (temp != null) this.upload_label = temp;
		temp = this.getParameter("please_choose_file");
		if (temp != null) this.please_choose_file = temp;
		temp = this.getParameter("wrong_path");
		if (temp != null) this.wrong_path = temp;
		temp = this.getParameter("max_size_label");
		if (temp != null) this.max_size_label = temp;
		temp = this.getParameter("too_large");
		if (temp != null) this.too_large = temp;

		// set the look and feel for swing to the platform default....
		try 
		{
	        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
	    }
		catch (Exception e) { }
		
		// apply our colours...
		this.getContentPane().setBackground(this.backgroundColor);
		this.getContentPane().setForeground(this.foregroundColor);
		
		// no stuffing about with layout managers here!
		this.getContentPane().setLayout(null);
		
		// label
		JLabel fileLabel = new JLabel(this.file_name_label);
		fileLabel.setAlignmentX(JLabel.RIGHT_ALIGNMENT);
		fileLabel.setSize(70, 23);
		fileLabel.setLocation(0,2);
		fileLabel.setForeground(this.foregroundColor);
		this.getContentPane().add(fileLabel);
		
		// text field
		txtFileName = new JTextField();
		txtFileName.setEditable(false);
		txtFileName.setSize(190, 23);
		txtFileName.setLocation(65,2);
		this.getContentPane().add(txtFileName);
		
		// button 1
		btnBrowse = new JButton(this.browse_label);
		btnBrowse.setSize(80,23);
		btnBrowse.setLocation(260, 2);
		btnBrowse.setBackground(this.backgroundColor);
		btnBrowse.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				browseButtonClicked();
			}
		});
		this.getContentPane().add(btnBrowse);
		
		// button 2
		btnSubmit = new JButton(this.upload_label);
		btnSubmit.setSize(80,23);
		btnSubmit.setLocation(345, 2);
		btnSubmit.setBackground(this.backgroundColor);
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				uploadButtonClicked();
			}
		});
		this.getContentPane().add(btnSubmit);
		
		// set container stuff
		this.setSize(430, 29);
		
		// Test we were given security
		try
		{
			new JFileChooser();
		}
		catch (java.security.AccessControlException e)
		{
			JOptionPane.showMessageDialog(null, this.fail_message, this.reverting_title, JOptionPane.WARNING_MESSAGE);

			JSObject win = (JSObject) JSObject.getWindow(this);
			win.eval("restoreFormerInput(null,null,null,'"+this.nameID+"','"+page_type+"','"+this._btn_submit_id+"',true,'"+this.posting_field_name+"');");
		}
	}
	
	/**
	 * show the browse window and get a filename
	 */
	public void browseButtonClicked()
	{
		JFileChooser chooser = new JFileChooser();
		javax.swing.filechooser.FileFilter filter=new ExtensionFileFilter(this.valid_types_label,this.types.split(","));
		chooser.setFileFilter(filter);
		int value = chooser.showOpenDialog(this);
		if (value == JFileChooser.APPROVE_OPTION)
		{
			// we said "ok", get the file
			File tmpFile = chooser.getSelectedFile();
			// populate the text field with the filename
			if (tmpFile.length()>this.maxLength)
			{
				this.txtFileName.setText(this.too_large+" ("+this.max_size_label+" " + getHumanReadibleFileSize(this.maxLength) + ")");
				return;
			}
			String fileName = tmpFile.getName() + " (" + getHumanReadibleFileSize(tmpFile.length()) + ")";
			this.theFile = tmpFile;
			this.txtFileName.setText(fileName);
		}
	}
	
	/**
	 * upload the file
	 */
	public void uploadButtonClicked()
	{
		// if we are currently uploading, do nothing
		if (!this.isUploading)
		{
			this.isUploading = true;
			this.hasUploaded = false;
			Thread mythread = new Thread(this);
			mythread.start();
		}
	}
	
	/**
	 * get a human-readible file size
	 * @param long size is the size of the file
	 * @returns String the size in readable form 
	 */
	private String getHumanReadibleFileSize(long size)
	{
		double outSize = (double)size;
		// translated from the php filesize manual page
		String[] extensions = {"B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"};
		int index = 0;
		while ((outSize / 1024) > 1)
		{
			outSize = outSize / 1024;
			index++;
		}
		String output = outSize + "";
		int lastChar = (output.indexOf(".") + 2 > output.length()) ? output.length() : output.indexOf(".") + 2;
		output = output.substring(0, lastChar) + extensions[index];
		return output;
	}
	
	/*************
	 * Run stuff !
	 *************/
	
	/**
	 * the second thread is responsible for the uploading of the file
	 * This allows us to have the interface refreshed without the ftp
	 * transfer blocking gui updates.
	 */
	public void run()
	{
		System.out.println("here 1");
		// check that the file is valid...
		if (!(this.theFile != null && this.theFile.canRead() == true))
		{
			// we can't read the file! :(
			this.txtFileName.setText(this.please_choose_file);
			return;
		}
		
		// disable the upload and browse buttons...
		this.btnBrowse.setEnabled(false);
		this.btnSubmit.setEnabled(false);
		
		// okay, here we make a connection to the FTP server and then attempt to upload the 
		// requested file...
		FTPClient client = new FTPClient();
		try 
		{
			// attempt to connect
			client.connect(this.address);
			client.login(this.username, this.password);
			
			client.enterLocalActiveMode();
			client.enterLocalPassiveMode();
			
			// we want to be binary, better safe than sorry and all that.
			client.setFileType(FTP.BINARY_FILE_TYPE);
			
			// verify connection as per docs
			int reply = client.getReplyCode();
			if(!FTPReply.isPositiveCompletion(reply))
			{
				client.disconnect();
				System.err.println(this.refused_connection);
				this.txtFileName.setText(this.refused_connection);
				return;
			}
			
			// yay! we are connected...
			System.out.println("Connected");
			
			// let's try and upload that file
			// setup the input and output streams
			OutputStream os = client.storeFileStream(this.uploadedFileName);
			if (os == null)
			{
				client.disconnect();
				System.err.println(this.wrong_path+this.uploadedFileName+".");
				this.txtFileName.setText(this.wrong_path+this.uploadedFileName+".");
				return;
			}
			BufferedOutputStream ftpOut = new BufferedOutputStream(os);
			BufferedInputStream fileIn = new BufferedInputStream(new FileInputStream(this.theFile));
			
			// initalise some working vars
			byte[] buffer = new byte[1024];
			int bytesRead = fileIn.read(buffer);
			long runningTotal = 0;
			long total = this.theFile.length();
			int percentComplete = 0;
			
			// do the upload loop
			while (bytesRead > 0)
			{
				// write the buffer
				ftpOut.write(buffer, 0, bytesRead);
				
				// update the totals
				runningTotal += bytesRead;
				percentComplete = (int)((double)runningTotal / (double)total * 100);
				this.txtFileName.setText(
					this.uploaded_message+" " +
					getHumanReadibleFileSize(runningTotal) + 
					" (" + 
					percentComplete + 
					"%)"
				);
				
				// read some more from the input
				bytesRead = fileIn.read(buffer);
			}
			
			// should all be uploaded now, flush the buffers and close them
			ftpOut.flush();
			ftpOut.close();
			fileIn.close();
			
			client.sendSiteCommand("CHMOD 666 "+this.uploadedFileName);

			this.txtFileName.setText(this.output_complete);
			
			// okay, all done, log out...
			client.logout();
			client.disconnect();

			this.isUploading = false;
			this.hasUploaded = true;

			// Callbacks to Javascript
			JSObject win = (JSObject) JSObject.getWindow(this);
			win.eval("document.getElementById('"+this.fileNameID+"').value = '"+this.theFile.getName()+"';");
			win.eval("document.getElementById('"+this.nameID+"').value = '1';");
			win.eval("dispatch_for_page_type('"+this.page_type+"','"+this.nameID+"','"+this.theFile.getName()+"','"+this.posting_field_name+"');");
			win.eval("fireFakeChangeFor('"+this.nameID+"','1');");
		}
		catch (Exception err)
		{
			this.txtFileName.setText(this.transfer_error+": "+err.toString());
			err.printStackTrace();
		}

		// re-enable the upload and browse buttons...
		this.btnBrowse.setEnabled(true);
		this.btnSubmit.setEnabled(true);
	}
	
	/***************************************
	 * some methods accessible to javascript  
	 ***************************************/
	
	/**
	 * have we successfully uploaded the file?
	 */
	public boolean hasUploaded()
	{
		return this.hasUploaded;
	}
}

class ExtensionFileFilter extends javax.swing.filechooser.FileFilter {
	String description;

	String extensions[];

	public ExtensionFileFilter(String description, String extension) {
		this(description, new String[] { extension });
	}

	public ExtensionFileFilter(String description, String extensions[]) {
		if (description == null) {
			this.description = extensions[0];
		} else {
			this.description = description;
		}
		this.extensions = (String[]) extensions.clone();
		toLower(this.extensions);
	}

	private void toLower(String array[]) {
		for (int i = 0, n = array.length; i < n; i++) {
			array[i] = array[i].toLowerCase();
		}
	}

	public String getDescription() {
		return description;
	}

	public boolean accept(File file) {
		if (file.isDirectory()) {
			return true;
		} else {
			String path = file.getAbsolutePath().toLowerCase();
			for (int i = 0, n = extensions.length; i < n; i++) {
				String extension = extensions[i];
				if ((path.endsWith(extension) && (path.charAt(path.length() - extension.length() - 1)) == '.')) {
					return true;
				}
			}
		}
		return false;
	}
}


