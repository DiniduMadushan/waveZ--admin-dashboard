 <%
        if (session != null && session.getAttribute("email") != null && session.getAttribute("type") != null) {
            
            String email = (String) session.getAttribute("email");
            String userType = (String) session.getAttribute("type");
            

            
 %>
   
       

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="Classes.DBconnector" %>
<%@page import="Classes.Admin_user" %>
<%@page import="Classes.Admin" %>


<%
   Admin admin=Admin.getAdmin(email,DBconnector.getCon()); 
 %>

<%
    int guest_users = Admin_user.getUserCount(DBconnector.getCon());
    int admin_users = Admin_user.getAdminCount(DBconnector.getCon());
    int total_users = guest_users + admin_users;
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
        <title>Admin</title>
        <link rel="icon" href="Images/logoOnly.png" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i&amp;display=swap" />
        <script src="https://kit.fontawesome.com/79271f9696.js" crossorigin="anonymous"></script>
        <style>
            /* Hide scrollbar for Chrome, Safari and Opera */
            .modal-body::-webkit-scrollbar,
            body::-webkit-scrollbar {
                display: none;
            }

            /* Hide scrollbar for IE, Edge and Firefox */
            .modal-body,
            body {
                -ms-overflow-style: none;
                /* IE and Edge */
                scrollbar-width: none;
                /* Firefox */
            }
        </style>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <nav id="main-nav" class="navbar bg-dark align-items-start sidebar sidebar-dark accordion p-0" style="padding-bottom: 0px;">
                <div class="container-fluid d-flex flex-column p-0">
                    <a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="#">
                        <div class="sidebar-brand-text mx-3">
                            <span>Administrator</span>
                        </div>
                    </a>
                    <hr class="sidebar-divider my-0" />
                    <ul class="navbar-nav text-light" id="accordionSidebar">
                        <li class="nav-item">
                            <a id="anchor1" class="nav-link" href="User_dashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a id="anchor2" class="nav-link active" href="User_dashboard.jsp">
                                <i class="fas fa-user"></i>
                                <span>User Management</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a id="anchor2" class="nav-link active" href="adminDashboardArtist.jsp">
                                <i class="fa-solid fa-music fa-xl"></i>
                                <span>Music Management</span>
                            </a>
                        </li>
                       
                      
                    </ul>
                    <a class="btn btn-primary btn-md" role="button" data-bss-hover-animate="pulse" href="logout_admin.jsp">Log Out</a>
                    <hr class="sidebar-divider my-2" />
                    <div class="text-center d-none d-md-inline">
                        <button class="btn rounded-circle border-0" id="sidebarToggle" type="button"></button>
                    </div>
                </div>
            </nav>
            <div class="d-flex flex-column" id="content-wrapper">
                <div id="content">
                    <nav class="navbar navbar-light navbar-expand-md bg-info shadow mb-4 py-3 static-top">
                        <div class="container-fluid">
                            <button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button">
                                <i class="fas fa-bars"></i>
                            </button>
                            <h4 class="d-none d-md-block" style="color:white">WAVEZ- USER MANAGEMENT</h4>
                            <h4 class="align-self-right text-white">Hello <%=admin.getName()%>&nbsp;&nbsp;<i class="fa-solid fa-user-tie fa-xl"></i></h4>
                        </div>
                    </nav>

                  <div class="card shadow">
                   <div class="card-body">
                    <div class="container mt-5">
                        <div class="row justify-content-center">
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card shadow border-start-primary py-1 px-1 ">
                                        <div class="card-body">
                                            <div class="row align-items-center no-gutters">
                                                <div class="col me-2">
                                                    <div class="text-uppercase text-primary fw-bold text-xs mb-1">
                                                        <span>Total users</span>
                                                    </div>
                                                    <div class="text-dark fw-bold h5 mb-0">
                                                        <span>
                                                            <h4><%=total_users%></h4>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fa-solid fa-users fa-2xl"></i></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <a href="admin_user_includes/guest_user_page.jsp"  style="text-decoration:none">
                                    <div class="card">
                                        <div class="card shadow border-start-primary py-1 ">
                                            <div class="card-body">
                                                <div class="row align-items-center no-gutters">
                                                    <div class="col me-2">
                                                        <div class="text-uppercase text-primary fw-bold text-xs mb-1">
                                                            <span>Guest Users</span>
                                                        </div>
                                                        <div class="text-dark fw-bold h5 mb-0">
                                                            <span>
                                                                <h4><%=guest_users%></h4>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fa-solid fa-user fa-2xl"></i></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>                        
                            </div>
                            <div class="col-md-4">
                                <a href="admin_user_includes/admin_user_page.jsp"  style="text-decoration:none">
                                    <div class="card">
                                        <div class="card shadow border-start-primary py-1 ">
                                            <div class="card-body">
                                                <div class="row align-items-center no-gutters">
                                                    <div class="col me-2">
                                                        <div class="text-uppercase text-primary fw-bold text-xs mb-1">
                                                            <span>Admin Users</span>
                                                        </div>
                                                        <div class="text-dark fw-bold h5 mb-0">
                                                            <span>
                                                                <h4><%=admin_users%></h4>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fa-solid fa-user-tie fa-2xl"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>                      
                            </div>
                        </div>
                    </div>
                                                             

                    <div class="row">

                        <div class="col-6"></div>
                        <div class="col-6">
                            <img style="float: left" src="Images/back2.png" alt="background" height="400px"/>
                        </div>

                    </div> 
                    </div>
                  </div>

                </div>
                                                            <hr>
                <footer class="bg-info sticky-footer">

                    <div class="container my-auto">
                        <div class="text-center my-auto copyright">
                            <span style="color:white">Copyright © 2023 Wavez</span>
                        </div>
                    </div>
                </footer>
                <a class="border rounded d-inline scroll-to-top" href="#page-top">
                    <i class="fas fa-angle-up"></i>
                </a>
                <script src="assets/bootstrap/js/bootstrap.min.js"></script>
                <script src="assets/js/theme.js"></script>
            </div>
        </div>
    </body>
</html>
<%
     } else {
           response.sendRedirect("Admin.jsp");
      }
 %>   