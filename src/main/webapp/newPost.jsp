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
	<%

	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    if (user == null) {
      pageContext.setAttribute("user", user);
	
	%>
		<p>
			Please <a href="<%= userService.createLoginURL("/") %>">Sign in</a> to post!
		</p>
	<%
	    } else {
	%>
	
		<h1>Create a New Post</h1>

	<form action="/posts" method="post">
		<div><input type="text" name="title"/></div>
   		<div><textarea name="content" rows="3" cols="60"></textarea></div>
   		<input type="hidden" name="blogCollection" value="blogCollection"/>
   		<div><input type="submit" value="Post Blog" ></div>
 	</form>
	<a href="/">Cancel</a>
	<%
	 }
	%>
	

	   



  </body>

</html>