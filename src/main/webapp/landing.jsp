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
  </head>
  
  <body>


	<div class="ui segment">
	<div class="ui medium images">
	  <img src="https://source.unsplash.com/waZEHLRP98s/750x400">
	  <img src="https://source.unsplash.com/Jztmx9yqjBw/750x400">
	  <img src="https://source.unsplash.com/6hxvm0NzYP8/750x400">
	</div>
		<h2 class="ui header center aligned">
		  <div class="content">
			Web Blog
		    <p style="font-size:18px;"> Users can login to post a new blog, view all blogs and view details of each blog. They can also subscribe and unsubscribe those blogs.</p>
		  </div>
		</h2>
	</div>

	<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    boolean subscribed = false;
    ObjectifyService.register(Subscriber.class);
    List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   
	%>
		<div class="ui container">
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
	            pageContext.setAttribute("content", blogentry.getContent().substring(0, Math.min(100, blogentry.getContent().length())));
	            pageContext.setAttribute("title", blogentry.getTitle());
	            pageContext.setAttribute("user", blogentry.getUser());
	            pageContext.setAttribute("date", blogentry.getDate());
			%>
				<div class="ui card seven wide column">
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
						<div class="ui basic green button"><a href="/posts/${id}">View More</a></div>
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