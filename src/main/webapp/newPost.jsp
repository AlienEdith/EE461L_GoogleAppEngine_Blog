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
  	<title>Create A New Post</title>
  </head>
  
  <body>
  	<div class="ui container">
  	<div class="main-area">
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
	
	<h2 class="ui grey header center aligned">Create a New Post</h2>

	<div class="ui form" >
		<form action="/posts" method="post">
			<div class="field">
				<label>Title</label>
				<input type="text" name="title" required/>
			</div>
	   		<div class="field">
	   			<label>Content</label>
	   			<textarea name="content" rows="10" cols="60" required></textarea>
	   		</div>
	   		<input type="hidden" name="blogCollection" value="blogCollection"/>
	   		<div>
	   			<input type="submit" value="Post" class="ui green basic button">
	   			<a href="/" class="ui red basic button">Cancel</a>	
	   		</div>
	 	</form>
 	</div>
	
	<%
	 }
	%>
	

	   	
		</div>
	</div>

  </body>

</html>