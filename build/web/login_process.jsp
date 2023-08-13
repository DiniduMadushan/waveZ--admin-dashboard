<%-- 
    Document   : adminlogin
    Created on : Aug 8, 2023, 7:03:46?PM
    Author     : pradisharoon
--%>

<%@page import="Classes.DBconnector"%>
<%@page import="Classes.MD5"%>
<%@page import="Classes.User"%>
<%@ page import="jakarta.servlet.http.Part" %>

<%
   String email=request.getParameter("email");
   String password=MD5.getMd5(request.getParameter("password"));
   String role="user";
    User user=new User(email, password);
    if( user.Authenticate(DBconnector.getCon())){
        session.setAttribute("email_1",user.getEmail());
        session.setAttribute("type_1", role);
        response.sendRedirect("index.jsp");
    }else{
        response.sendRedirect("login.jsp?status=0");
    }
%>
