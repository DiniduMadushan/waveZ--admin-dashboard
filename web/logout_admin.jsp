<%-- 
    Document   : logout
    Created on : Aug 13, 2023, 4:34:43?PM
    Author     : dinid
--%>


<%


session.removeAttribute("email");
session.removeAttribute("type");
response.sendRedirect("Admin.jsp");

%>