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
  	<title>Web Blog</title>
  </head>
  
  <body>
	<div class="ui container">

	<div class="ui segment">
	  <!-- https://source.unsplash.com/_ea1a8mZTcE/800x420 -->
	  <img class="ui left floated medium image" src="https://source.unsplash.com/_ea1a8mZTcE/800x420">
	  <h2 class="ui header">
		  <div class="content">
		    WEB BLOG
		  </div>
	  </h2>
	  <h4 class="ui grey header">
	  <div>Welcome to Web Blog Website! </div>
	  <div>You could easily log in with your google account and then start post your own article.
	  You could will all the blogs posted by other people even without login. We also recommend you subscribe to get a daily digest email of new posts everyday at 17:00!</div>
	  </h4>
	 </div>

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
				
				
					<a href="/posts/new" class="ui pink basic button right floated"> NEW POST</a>
					
					<%
						if(subscribed){
					%>
						<a href="/unsubscribe" class="ui violet basic button" data-tooltip="Are you sure you want to unsubsribe T.T?" data-position="right center"> UNSUBSCRIBE </a>	
					<% 	
						} else {
					%>	
						<a href="/subscribe" class="ui violet basic button" data-tooltip="Good Choice!" data-position="right center"> SUBSCRIBE </a>
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
			
			
			<a href="/posts" class="ui red basic button right floated"> View All Posts</a>
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
	        for (int i=0; i<Math.min(size,3); i++) {
	        	BlogEntry blogentry = blogEntries.get(i);
	        	pageContext.setAttribute("id", blogentry.getId());
	            pageContext.setAttribute("content", blogentry.getContent().substring(0, Math.min(300, blogentry.getContent().length())));
	            pageContext.setAttribute("title", blogentry.getTitle());
	            pageContext.setAttribute("user", blogentry.getUser());
	            pageContext.setAttribute("date", blogentry.getDate());
			%>
				<div class="ui card sixteen wide column">
				    <div class="content">
				      <div class="ui blue header">
				        ${fn:escapeXml(title)}
				      </div>
				      <div class="meta">
				        ${fn:escapeXml(user)}
				      </div>
				      <div class="description">
				        ${fn:escapeXml(content)}...
				      </div>
				    </div>
				    <div class="extra content">
				      ${fn:escapeXml(date)}
					  <a href="/posts/${id}" class="ui basic green button right floated" data-tooltip="View Full Content!" data-position="left center">View More</a>
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