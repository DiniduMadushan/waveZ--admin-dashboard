<%@page import="java.sql.*" %>
<%@page import="Classes.DBconnector" %>
<%@page import="Classes.Admin_user" %>

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
        <link rel="icon" href="../Images/logoOnly.png" />
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
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
                            <a id="anchor1" class="nav-link" href="">
                                <i class="fas fa-tachometer-alt"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a id="anchor2" class="nav-link active" href="../User_dashboard.jsp">
                                <i class="fas fa-user"></i>
                                <span>User Management</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a id="anchor2" class="nav-link active" href="../adminDashboardArtist.jsp">
                                <i class="fa-solid fa-music fa-xl"></i>
                                <span>Music Management</span>
                            </a>
                        </li>
                    </ul>
                    <a class="btn btn-primary btn-md" role="button" data-bss-hover-animate="pulse" href="">Log Out</a>
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
                            <h4 class="align-self-right text-white">Hello Username&nbsp;&nbsp;<i class="fa-solid fa-user-tie fa-xl"></i></h4>
                        </div>
                    </nav>

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-4">
                                <h3 class="text-dark mb-4">Guest Accounts</h3>  
                            </div>
                            <div class="col-4">
                                <form action="<%= request.getRequestURI()%>" method="POST"> 
                                    <input type="text" name="search" class='form-control' placeholder="Search by username" value="" >  
                                    </div>
                                    <div class="col-4">
                                        <button type="submit" class="btn btn-primary">Search</button>
                                </form>
                            </div>

                        </div>

                        <%
                            String alert = "";
                            if (request.getParameter("status") != null) {
                                int status = Integer.parseInt(request.getParameter("status"));
                                if (status == 0) {
                                    alert = "<p class='text-danger'>Failed to delete the user!</P>";
                                }
                                if (status == 1) {
                                    alert = "<p class='text-success'>Successfully deleted.</P>";
                                }
                            }
                        %>

                        <%=alert%>

                        <hr>


                        <div class="card shadow">
                            <div class="card-body">
                                <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                                    <table class="table table-hover my-0" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <b>#</b>
                                                </th>
                                                <th>User_ID</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Password</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                int no_rows = 5;
                                                double number = (double) guest_users / no_rows;
                                                int pages = (int) Math.ceil(number);
                                                int current_page = 1;

                                                int start = 0;
                                                int y = 1;
                                                if (request.getParameter("page") != null) {
                                                    int page_no = Integer.parseInt(request.getParameter("page")) - 1;
                                                    start = page_no * no_rows;
                                                    y = start + 1;
                                                }

                                                try {
                                                    if (request.getParameter("search") != null) {
                                                        String name = request.getParameter("search");
                                                        Connection con = DBconnector.getCon();
                                                        String query = "SELECT * FROM user WHERE name=?";
                                                        PreparedStatement pstmt = con.prepareStatement(query);
                                                        pstmt.setString(1, name);
                                                        ResultSet rs = pstmt.executeQuery();
                                                        if (rs.next()) {
                                            %>
                                            <tr>
                                                <td> </td>
                                                <td> <%=rs.getString("user_ID")%> </td>
                                                <td> <%=rs.getString("name")%> </td>
                                                <td> <%=rs.getString("email")%> </td>
                                                <td> <%=rs.getString("password")%> </td>
                                                <td><a type="button" class="btn btn-danger" href='delete_guest_user.jsp?user_ID=<%=rs.getString("user_ID")%>' name="delete">Delete</a></td>
                                            </tr>    
                                            <%
                                                } else {
                                                    out.println("<p style='color:red'>no any result found!</p>");
                                                }
                                            } else {

                                                Connection con = DBconnector.getCon();
                                                String query = "SELECT *FROM user LIMIT ?,?";
                                                PreparedStatement pstmt = con.prepareStatement(query);
                                                pstmt.setInt(1, start);
                                                pstmt.setInt(2, no_rows);
                                                ResultSet rs = pstmt.executeQuery();

                                                while (rs.next()) {

                                            %>        
                                            <tr>
                                                <td> <%=y%> </td>
                                                <td> <%=rs.getString("user_ID")%> </td>
                                                <td> <%=rs.getString("name")%> </td>
                                                <td> <%=rs.getString("email")%> </td>
                                                <td> <%=rs.getString("password")%> </td>
                                                <td><a type="button" class="btn btn-danger" onclick="showAlert()" href='delete_guest_user.jsp?user_ID=<%=rs.getString("user_ID")%>' name="delete">Delete</a></td>
                                            </tr>    
                                            <%
                                                            y++;
                                                        }
                                                    }

                                                } catch (Exception e) {
                                                    out.println(e);
                                                }

                                            %>



                                        </tbody>
                                    </table>
                                </div>
                                <div class="row">
                                    <div class="col-11 container mt-5">
                                        <div>
                                            &nbsp;   Total pages: <%=pages%>
                                        </div>
                                        <ul class="pagination">
                                            <li class="page-item"><a class="page-link" href="?page=1">First</a></li>

                                            <%
                                                if ((request.getParameter("page") != null) && (Integer.parseInt(request.getParameter("page")) > 1)) {

                                            %>
                                            <li class="page-item"><a class="page-link" href='?page=<%=Integer.parseInt(request.getParameter("page")) - 1%>'>Previous</a></li>  
                                                <%
                                                } else {
                                                %>
                                            <li class="page-item"><a class="page-link">Previous</a></li> 
                                                <%
                                                    }
                                                %>


                                            <%
                                                for (int x = 1; x <= pages; x++) {
                                            %>
                                            <li class="page-item"><a class="page-link" href="?page=<%=x%>"><%=x%></a></li>
                                                <%
                                                    }
                                                %>



                                            <%
                                                if (request.getParameter("page") == null) {
                                            %>
                                            <li class="page-item"><a class="page-link" href="?page=2">Next</a></li>

                                            <%
                                            } else {
                                                if (Integer.parseInt(request.getParameter("page")) >= pages) {
                                            %>
                                            <li class="page-item"><a class="page-link">Next</a></li>

                                            <%
                                            } else {
                                            %>        
                                            <li class="page-item"><a class="page-link" href='?page=<%=Integer.parseInt(request.getParameter("page")) + 1%>'>Next</a></li>

                                            <%
                                                    }
                                                }
                                            %>



                                            <li class="page-item"><a class="page-link" href="?page=<%=pages%>">Last</a></li>
                                        </ul>
                                    </div>
                                    <div class=" col-1 container mt-5"><a href="admin_user_page.jsp"><i class="fa-solid fa-angles-right fa-2xl"></i></a></div>      

                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <script>
                    function showAlert() {
                        alert('Are you sure want to delete the user!');
                    }
                </script>                   
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
                <script src="../assets/bootstrap/js/bootstrap.min.js"></script>
                <script src="../assets/js/theme.js"></script>
            </div>
        </div>
    </body>
</html>