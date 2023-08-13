<%-- 
    Document   : delete_admin
    Created on : Aug 8, 2023, 4:08:31 PM
    Author     : dinid
--%>

<%@page import="Classes.Admin_user"%>
<%@page import="java.sql.*"%>
<%@page import="Classes.DBconnector" %>


<%
   if(request.getParameter("admin_ID")!=null){
     int admin_ID=Integer.parseInt(request.getParameter("admin_ID"));
     
     if(Admin_user.deleteAdmin(DBconnector.getCon(), admin_ID)){
        response.sendRedirect("admin_user_page.jsp?status=5");
     }  
   }
    
   
%>

