<%-- 
    Document   : update_admin_process
    Created on : Aug 8, 2023, 9:58:10 PM
    Author     : dinid
--%>

<%@page import="Classes.Admin_user"%>
<%@page import="java.sql.*"%>
<%@page import="Classes.DBconnector" %>
<%@page import="Classes.MD5" %>
<%@page import="Classes.My_functions" %>

<%
    String name=request.getParameter("name");
    String email=request.getParameter("email");
    String password=MD5.getMd5(request.getParameter("password"));
    String con_password=MD5.getMd5(request.getParameter("confirm_password"));
    int admin_ID=Integer.parseInt(request.getParameter("admin_ID"));
    
    Admin_user admin=new Admin_user(admin_ID,name, email, password);
    
    if(My_functions.passwordCheck(password, con_password)){
        if(admin.notValid(DBconnector.getCon())){
            response.sendRedirect("admin_update.jsp?status=0&&admin_ID="+admin_ID);
        }else{
            if(admin.updateAdmin(DBconnector.getCon())){
                response.sendRedirect("admin_user_page.jsp?status=4");
            }else{
                response.sendRedirect("admin_update.jsp?status=2&&admin_ID="+admin_ID);
            }
        }
    }else{
        response.sendRedirect("admin_update.jsp?status=1&&admin_ID="+admin_ID);
    }
    
   
%>

