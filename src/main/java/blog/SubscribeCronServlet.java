package blog;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;


public class SubscribeCronServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		// Get time: previous day 17:00		
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 17);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND,0);
		Date dateBefore = calendar.getTime();

		// Get latest Blog		
		ObjectifyService.register(BlogEntry.class);
		List<BlogEntry> blogEntries = ObjectifyService.ofy().load().type(BlogEntry.class).list();   
		Collections.sort(blogEntries, Collections.reverseOrder()); 
		List<BlogEntry> SelectedBlog = (List<BlogEntry>) new ArrayList<BlogEntry>();
		
		for(BlogEntry be: blogEntries){
			if(be.date.after(dateBefore)) {
				SelectedBlog.add(be);
			}
		}
		
		// Get subscribers		
		ObjectifyService.register(Subscriber.class);
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   
		
		
//		Properties props = new Properties();
//		Session session = Session.getDefaultInstance(props, null);
//
//		try {
//		  Message msg = new MimeMessage(session);
//		  msg.setFrom(new InternetAddress("edith.w0807@gmail.com", "Yixing Wang"));
//		  msg.addRecipient(Message.RecipientType.TO,
//		                   new InternetAddress(user.getEmail(), user.getNickname()));
//		  msg.setSubject("Your Example.com account has been activated");
//		  msg.setText("This is a test");
//		  Transport.send(msg);
//		} catch (AddressException e) {
//		  // ...
//		} catch (MessagingException e) {
//		  // ...
//		} catch (UnsupportedEncodingException e) {
//		  // ...
//		}
	}
}
