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
  	<link type="text/css" rel="stylesheet" href="" />
  </head>
  
  <body>


	<h1>List All Posts</h1>


	<div>
		Post Lists Goes Here
	</div>
	<%
	
	ObjectifyService.register(Subscriber.class);
	List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   

	
    if (subscribers.isEmpty()) {
        %>
        <p>No Subscriber yet.</p>
        <%
    } else {
    	
        for (Subscriber subscriber : subscribers) {
            pageContext.setAttribute("email", subscriber.getEmail());
            pageContext.setAttribute("nickname", subscriber.getNickname());

		%>
                <p>Title: ${fn:escapeXml(email)}</p>
                <p>Content: ${fn:escapeXml(nickname)}</p>

            <%
        }
    }
%>

	<div>
		<a href="/"> Go Back</a>
	</div>
	


	   



  </body>

</html>