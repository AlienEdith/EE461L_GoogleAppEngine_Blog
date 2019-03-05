<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="blog.Subscriber" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<html>
  <head>
  	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" />
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  
  <body>

	<%
		pageContext.setAttribute("message", request.getAttribute("message"));

	%>
    
    <div class="ui container">
    	<p style="font-size: 1.2rem"> ${message} </p>

		<div>
		<a href="/" class="ui green basic button">Go Back</a>
		</div>
	</div>
  </body>

</html>