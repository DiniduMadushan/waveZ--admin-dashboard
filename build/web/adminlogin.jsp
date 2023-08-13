<%-- 
    Document   : adminlogin
    Created on : Aug 8, 2023, 7:03:46?PM
    Author     : pradisharoon
--%>

<%@page import="Classes.DBconnector"%>
<%@page import="Classes.MD5"%>
<%@page import="Classes.Admin"%>
<%@ page import="jakarta.servlet.http.Part" %>

<%
   String email=request.getParameter("email");
   String password=MD5.getMd5(request.getParameter("password"));
   String role="admin";
    Admin admin=new Admin(email, password);
    if( admin.Authenticate(DBconnector.getCon())){
        session.setAttribute("email",admin.getEmail());
        session.setAttribute("type", role);
        response.sendRedirect("User_dashboard.jsp");
    }else{
        response.sendRedirect("Admin.jsp?status=0");
    }
%>
