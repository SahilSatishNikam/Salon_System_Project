<%@ page import="jakarta.servlet.http.*" %>
<%
    // Get the current session, if exists
   
    if(session != null){
        // Invalidate the session to log out the user
        session.invalidate();
    }

    // Redirect the admin to the login page
    response.sendRedirect("login.jsp");
%>
