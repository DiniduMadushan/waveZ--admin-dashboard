<%-- 
    Document   : add_admin
    Created on : Aug 8, 2023, 3:12:10 PM
    Author     : dinid
--%>

<%@page import="Classes.Admin_user"%>
<%@page import="Classes.My_functions"%>
<%@page import="java.sql.*"%>
<%@page import="Classes.DBconnector" %>
<%@page import="Classes.MD5" %>

<%
    String name=request.getParameter("name");
    String email=request.getParameter("email");
    String password=MD5.getMd5(request.getParameter("password"));
    String con_password=MD5.getMd5(request.getParameter("confirm_password"));
    
    
    Admin_user admin=new Admin_user(name, email, password);
    
   if(My_functions.passwordCheck(password, con_password)){
      if(admin.notValid(DBconnector.getCon())){
          response.sendRedirect("admin_user_page.jsp?status=1");
      }else{
         if(admin.registerAdmin(DBconnector.getCon())){
            response.sendRedirect("admin_user_page.jsp?status=2"); 
         }else{
             response.sendRedirect("admin_user_page.jsp?status=3");
         }
      }
   }else{
       response.sendRedirect("admin_user_page.jsp?status=0");
   }
    
    
    
%>
