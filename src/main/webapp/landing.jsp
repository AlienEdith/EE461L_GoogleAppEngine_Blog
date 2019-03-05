<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="blog.BlogEntry" %>
<%@ page import="blog.Subscriber" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
  <head>
  	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" />
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  
  <body>
	<div class="ui container">

	<div class="ui segment">
	<div class="ui medium images">
	  <img src="https://source.unsplash.com/waZEHLRP98s/700x300">
	  <img src="https://source.unsplash.com/Jztmx9yqjBw/700x300">
	  <img src="https://source.unsplash.com/6hxvm0NzYP8/700x300">
	</div>
		<h1 class="ui header center aligned">
		  <div class="content">
			WEB BLOG
		  </div>
		   <p style="font-size:18px;"> </br> Users can login to post a new blog, view all blogs and view details </br> 
		   of each blog. They can also subscribe and unsubscribe those blogs. </br> </br> </p>
		</h1>
	</div>
	
	<p>

	<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    boolean subscribed = false;
    ObjectifyService.register(Subscriber.class);
    List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   
	%>
	
	<% 
    if (user != null) {
        for(Subscriber ss: subscribers) {
        	if(ss.getUserId().equals(user.getUserId())) {
        		subscribed = true;
        	}	
        }
      	pageContext.setAttribute("user", user);
	%>
	
		
			
			    
				<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>" class="ui purple basic button">SIGN OUT</a>
				
				
					<a href="/posts/new" class="ui violet basic button"> NEW POST</a>
					
					<%
						if(subscribed){
					%>
						<a href="/unsubscribe" class="ui pink basic button"> UNSUBSCRIBE </a>	
					<% 	
						} else {
					%>	
						<a href="/subscribe" class="ui pink basic button"> SUBSCRIBE </a>
					<%	
					}
					%>
					
				
				
			
			
		<%
		    } else {
		%>
		
				
				<a href="<%= userService.createLoginURL(request.getRequestURI()) %>" class="ui purple basic button">SIGN IN</a>
			
		
		<%
		 }
		%>
			
			
			<a href="/posts" class="ui red basic button"> View All Posts</a>
			</p>
		<%
		ObjectifyService.register(BlogEntry.class);
		List<BlogEntry> blogEntries = ObjectifyService.ofy().load().type(BlogEntry.class).list();   
		Collections.sort(blogEntries, Collections.reverseOrder()); 
		
	    if (blogEntries.isEmpty()) {
	        %>
	        <p>No Blog yet.</p>
	        <%
	    } else {
	    	int size = blogEntries.size();
	    	%>
	    	<p>
	    	<div class="ui cards grid">
	    	<% 
	        for (int i=0; i<Math.min(size,4); i++) {
	        	BlogEntry blogentry = blogEntries.get(i);
	        	pageContext.setAttribute("id", blogentry.getId());
	            pageContext.setAttribute("content", blogentry.getContent().substring(0, Math.min(300, blogentry.getContent().length())));
	            pageContext.setAttribute("title", blogentry.getTitle());
	            pageContext.setAttribute("user", blogentry.getUser());
	            pageContext.setAttribute("date", blogentry.getDate());
			%>
				<div class="ui card sixteen wide column">
				    <div class="content">
				      <div class="header">
				        ${fn:escapeXml(title)}
				      </div>
				      <div class="meta">
				        ${fn:escapeXml(user)}
				      </div>
				      <div class="description">
				        ${fn:escapeXml(content)}
				      </div>
				    </div>
				    <div class="extra content">
				      ${fn:escapeXml(date)}
					  <a href="/posts/${id}" class="ui basic green button">View More</a>
				    </div>
				  </div>
	            <%
	        }
	    	%>
	    	</div>
	    	</p>
	    	<% 
	    }
	%>
		</div>


		
  </body>
</html>