package duka;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class MySessionListener implements HttpSessionListener {
	private int count;
	Date t = new Date(); 
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public MySessionListener() {
		 count = 0;
	}

	public void sessionCreated(HttpSessionEvent hse) {
		count++;
		HttpSession session = hse.getSession();
		t.setTime(session.getCreationTime());
		
		try {
			String path = session.getServletContext().getRealPath("/");
			FileWriter file = new FileWriter(path + "/sessionLog.txt", true);
			file.write("세션" + count + " " + session.getId() + " " + sf.format(t) + "\r\n");
			file.flush();
			file.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("세션" + count + " " + session.getId() + " " + sf.format(t));
	}

	public void sessionDestroyed(HttpSessionEvent hse) {

	}

}

