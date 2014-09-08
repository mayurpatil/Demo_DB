package db;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.*;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class RegisterServlet extends HttpServlet
{
   public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException
   {
      String usn = req.getParameter("USN");
      String name = req.getParameter("Name");

      String btn = req.getParameter("btn");

      DatastoreService dataStore = DatastoreServiceFactory.getDatastoreService();

    //  UserService userService = UserServiceFactory.getUserService();
   //   User user = userService.getCurrentUser();

      Key dbKey = KeyFactory.createKey("Student_DB", "Student-Database");

      if (btn.equals("Register"))
      {

         Entity row = new Entity("Student_DB", dbKey);

         row.setProperty("USN", usn);
         row.setProperty("Name", name);

         dataStore.put(row);

         res.getWriter().println("Added Successfully");
      }
      if (btn.equals("List"))
      {

         String usn1, name1;

         Query query = new Query("Student_DB", dbKey).addSort("USN", Query.SortDirection.ASCENDING);

         List<Entity> students = dataStore.prepare(query).asList(FetchOptions.Builder.withLimit(20));
         res.setContentType("text/html");

         {
            res.getWriter().println("The list of registered is as below");
            for (Entity student : students)
            {
               String sname = (String)student.getProperty("Name");
               String susn = (String)student.getProperty("USN");

               res.getWriter().println("<ul>");
               res.getWriter().println(sname);
               res.getWriter().println(susn);

               //res.getWriter().println(student.getProperty("Name"));
               res.getWriter().println("</ul>");
            }
         }
      }
   }
}
