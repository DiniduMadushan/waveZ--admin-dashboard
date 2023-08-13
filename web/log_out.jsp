<%-- 
    Document   : logout
    Created on : Aug 13, 2023, 4:34:43?PM
    Author     : dinid
--%>


<%


session.removeAttribute("email_1");
session.removeAttribute("type_1");
response.sendRedirect("login.jsp");

%>