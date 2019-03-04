<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="blog.Subscriber" %>
<%@ page import="blog.BlogEntry" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<html>
  <head>
  	<link type="text/css" rel="stylesheet" href="" />
  </head>
  
  <body>
	<% 
		boolean found = false;
		if(request.getRequestURI().split("/").length > 2){
			String currentId = request.getRequestURI().split("/")[2];
			System.out.println(currentId);
			ObjectifyService.register(BlogEntry.class);
			List<BlogEntry> blogEntries = ObjectifyService.ofy().load().type(BlogEntry.class).list();   
			for(BlogEntry be: blogEntries) {
				if(be.getId().toString().equals(currentId)) {
					found = true;
					pageContext.setAttribute("title", be.getTitle());
					pageContext.setAttribute("content", be.getContent());
					pageContext.setAttribute("user", be.getUser());
					pageContext.setAttribute("date", be.getDate());
	%>
					<p>Title: ${fn:escapeXml(title)}</p>
                	<p>Content: ${fn:escapeXml(content)}</p>
                	<p>user: ${fn:escapeXml(user)}</p>
                	<p>date: ${fn:escapeXml(date)}</p>
	<%
				}
			}
		}
		if(!found){
	%>
		<p>Can not found the Post</p>
	<% 		
		}
	 %>





	<div>
		<a href="/posts"> Go Back</a>
	</div>

  </body>

</html>