 <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page
  import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<form action="/register" method="post">
  Student Registration Form
  <div>Enter Your USN:</div>
  <input type="text" name="USN">

  <div>Enter Your Name:</div>
  <input type="text" name="Name"> <input type="submit"
    value="Regsiter">
</form>

The list of registered students is given below:
<%
  DatastoreService datastore = DatastoreServiceFactory
      .getDatastoreService();
  Key dbKey = KeyFactory.createKey( "Student_DB", "Student Database");

  Query query = new Query("Student_DB", dbKey).addSort("USN",
      Query.SortDirection.ASCENDING);
  List<Entity> students = datastore.prepare(query).asList(
      FetchOptions.Builder.withLimit(10));

  for (Entity student : students) {
    pageContext.setAttribute("usn", student.getProperty("USN"));
    pageContext.setAttribute("name", student.getProperty("Name"));
%>
<blockquote>'${fn:escapeXml(usn)}' and '${fn:escapeXml(name)}'</blockquote>
<%
  }
%>


</html>