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
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  
  <body>
	<div class="ui container">
	

		<h1 class="ui header center aligned">
		  <div class="content">
			List All Posts
		  </div>
		</h1>

	<%
	
	//ObjectifyService.register(BlogEntry.class);
	//List<BlogEntry> blogEntries = ObjectifyService.ofy().load().type(BlogEntry.class).list();   
	//Collections.sort(blogEntries, Collections.reverseOrder()); 

	List<BlogEntry> blogEntries = (List<BlogEntry>) request.getAttribute("blogEntries");  
	
    if (blogEntries.isEmpty()) {
        %>
        <p>No Blog yet.</p>
        <%
    } else {
    	%>
    	<p>
    		<div class="ui segment">

    	<% 
        for (BlogEntry blogentry : blogEntries) {
        	pageContext.setAttribute("id", blogentry.getId());
            pageContext.setAttribute("content", blogentry.getContent().substring(0, Math.min(100, blogentry.getContent().length())));
            pageContext.setAttribute("title", blogentry.getTitle());
            pageContext.setAttribute("user", blogentry.getUser());
            pageContext.setAttribute("date", blogentry.getDate());
		%>
				
<div class="ui items">
  <div class="item">
    <div class="content">
      <a class="ui header blue">${fn:escapeXml(title)}</a>
      <div class="meta">
        <span> ${fn:escapeXml(user)}</span>
      </div>
      <div class="description">
        <p>${fn:escapeXml(content)}</p>
      </div>
      <div class="extra">
        ${fn:escapeXml(date)}
      </div>
      <br>
       <div class="ui basic green button"><a href="/posts/${id}">View More</a></div>
	   <div class="ui divider"></div>	
    </div>
  </div>
  </div>

         <%
        }
    }
%>
	<a href="/" class="ui violet basic button"> Back to Homepage</a>
	</div>
	</p>

  </body>
</html>