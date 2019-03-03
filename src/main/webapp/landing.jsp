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
  	<link type="text/css" rel="stylesheet" href="" />
  </head>
  
  <body>


	<h1>Landing Page</h1>
	
	<div>
		Image Header Goes Here
	</div>

	<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    boolean subscribed = false;
    ObjectifyService.register(Subscriber.class);
    List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   

    if (user != null) {
        for(Subscriber ss: subscribers) {
        	if(ss.getUserId().equals(user.getUserId())) {
        		subscribed = true;
        	}	
        }
      	pageContext.setAttribute("user", user);
	%>
	
		<p>
		    
			Welcome, ${fn:escapeXml(user.nickname)}!(<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)
			
			<div>
				<a href="/posts/new"> NEW POST</a>
				
				<%
					if(subscribed){
				%>
					<a href="/unsubscribe"> Unsubscribe </a>	
				<% 	
					} else {
				%>	
					<a href="/subscribe"> Subscribe </a>
				<%	
				}
				%>
				
			</div>
			
		</p>
		
	<%
	    } else {
	%>
	
		<p>
			Please <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>!
		</p>
	
	<%
	 }
	%>

	<div>
		Post Lists Goes Here
	</div>
	
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
        for (int i=0; i<Math.min(size,4); i++) {
        	BlogEntry blogentry = blogEntries.get(i);
            pageContext.setAttribute("content", blogentry.getContent());
            pageContext.setAttribute("title", blogentry.getTitle());
            pageContext.setAttribute("user", blogentry.getUser());
            pageContext.setAttribute("date", blogentry.getDate());
		%>
                <p>Title: ${fn:escapeXml(title)}</p>
                <p>Content: ${fn:escapeXml(content)}</p>
                <p>user: ${fn:escapeXml(user)}</p>
                <p>date: ${fn:escapeXml(date)}</p>

            <%
        }
    }
%>

	<div>
		<a href="/posts"> View All Posts</a>
	</div>
  </body>
</html>