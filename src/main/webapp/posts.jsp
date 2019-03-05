<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="blog.BlogEntry" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<html>
  <head>
  	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" />
  </head>
  
  <body>

	
	<div class="ui segment">
		<h1 class="ui header center aligned">
		  <div class="content">
			List All Posts
		  </div>
		</h1>
	</div>

	<%
	
	//ObjectifyService.register(BlogEntry.class);
	//List<BlogEntry> blogEntries = ObjectifyService.ofy().load().type(BlogEntry.class).list();   
	//Collections.sort(blogEntries, Collections.reverseOrder()); 
	%>
		<div class="ui container">
	<% 
	List<BlogEntry> blogEntries = (List<BlogEntry>) request.getAttribute("blogEntries");  
	
    if (blogEntries.isEmpty()) {
        %>
        <p>No Blog yet.</p>
        <%
    } else {
    	%>
    	<p>
    	<div class="ui cards grid">
    	<% 
        for (BlogEntry blogentry : blogEntries) {
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
	<a href="/" class="ui violet basic button"> Go Back</a>
	</div>


  </body>
</html>