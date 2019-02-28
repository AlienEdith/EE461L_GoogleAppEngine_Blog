package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class createNewPostServlet extends HttpServlet{
	
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        if(user == null) {
        	resp.sendRedirect("/landing.jsp");
        	return;
        }
    	
        String blogCollection = req.getParameter("blogCollection");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        System.out.println(blogCollection);
        BlogEntry be = new BlogEntry(title, content, user);
        // Save Object/Entity to datastore
        ofy().save().entity(be).now(); 
        
        resp.sendRedirect("/landing.jsp");
        
    }
}
