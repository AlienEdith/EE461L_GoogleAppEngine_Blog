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
  	<link type="text/css" rel="stylesheet" href="" />
  </head>
  
  <body>


	<h1>List All Posts</h1>


	<div>
		Post Lists Goes Here
	</div>
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
    	
        for (BlogEntry blogentry : blogEntries) {
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
		<a href="/"> Go Back</a>
	</div>
	


	   



  </body>

</html>