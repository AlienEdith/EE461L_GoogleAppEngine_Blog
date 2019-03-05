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
  	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" />
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  
  <body>
  	<div class="ui container">
	<% 
		boolean found = false;
		if(request.getRequestURI().split("/").length == 3){
			String currentId = request.getRequestURI().split("/")[2];
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
					
					 <div class="ui clearing segment title-header">
						<h2 class="ui blue header">${fn:escapeXml(title)}<h2>
						<h4 style="display: inline;" class="ui left aligned grey header">Posted by ${fn:escapeXml(user)}</h4>
						<h4  style="display: inline;" class="ui right floated grey header">Posted at ${fn:escapeXml(date)}</h4>
					</div>

					<div class="ui segment">
                		<p style="font-size: 1.2rem">${content}</p>
                	</div>
                	<a href="/posts" class="ui red basic button">View All Posts</a>
                	
					
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
	 			






		
	</div>

  </body>

</html>