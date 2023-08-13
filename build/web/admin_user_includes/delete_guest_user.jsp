<%-- 
    Document   : delete_guest_user
    Created on : Aug 8, 2023, 2:28:12 PM
    Author     : dinid
--%>
<%@page import="Classes.Admin_user"%>
<%@page import="java.sql.*"%>
<%@page import="Classes.DBconnector" %>

<%
   int user_ID=Integer.parseInt(request.getParameter("user_ID"));
   
   if( Admin_user.deleteUser(DBconnector.getCon(), user_ID)){
       response.sendRedirect("guest_user_page.jsp?status=1");
   }else{
       response.sendRedirect("guest_user_page.jsp?status=0");
   }
  
%>
