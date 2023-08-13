<%-- 
    Document   : register
    Created on : Aug 7, 2023, 9:37:30 PM
    Author     : dinid
--%>

<%@page import="Classes.MD5"%>
<%@page import="Classes.DBconnector"%>
<%@page import="Classes.User"%>

<%
   String name=request.getParameter("name");
   String email=request.getParameter("email");
   String password=request.getParameter("password");
   String con_password=request.getParameter("con_password");
   
   if(password.equals(con_password)){
       password=MD5.getMd5(request.getParameter("password"));
       User user=new User(name,email,password);
       if(user.Register(DBconnector.getCon())){
            
            response.sendRedirect("../signup.jsp?status=1");
        }else{
                response.sendRedirect("../signup.jsp?status=2");
            }
       
    }else{
        response.sendRedirect("../signup.jsp?status=3");
    }
  
%>
