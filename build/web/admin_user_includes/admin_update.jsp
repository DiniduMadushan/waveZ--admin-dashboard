<%@page import="java.sql.*" %>
<%@page import="Classes.DBconnector" %>




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
                            <a id="anchor1" class="nav-link" href="admin_dashboard.php">
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
                    <a class="btn btn-primary btn-md" role="button" data-bss-hover-animate="pulse" href="includes/logout.inc.php">Log Out</a>
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

                        <h3 class="text-dark mb-4">Update Admin account</h3>

                        <div class="container-fluid mt-3">

                            <%
                                String alert = "";
                                if (request.getParameter("status") != null) {
                                    int status = Integer.parseInt(request.getParameter("status"));
                                    if (status == 0) {
                                        alert = "<p style='color:red'>You entered email is already registered.Try again</p>";
                                    } else if (status == 1) {
                                        alert = "<p style='color:red'>please confirm the password correctly!</p>";
                                    } else if (status == 2) {
                                        alert = "<p style='color:red'>Update failed!</p>";
                                    }
                                }

                            %>

                            <%=alert%>

                            <div class="row">
                                <div class="col p-3" style="border: 2px solid #000">
                                    <%
                                        if (request.getParameter("admin_ID") != null) {
                                            String admin_ID = request.getParameter("admin_ID");
                                            try {
                                                Connection con = DBconnector.getCon();
                                                String query = "SELECT *FROM admin WHERE admin_ID=?";
                                                PreparedStatement pstmt = con.prepareStatement(query);
                                                pstmt.setString(1, admin_ID);
                                                ResultSet rs = pstmt.executeQuery();
                                                if (rs.next()) {

                                    %>
                                    <form action='update_admin_process.jsp' method="POST">
                                        <div class="form-group">
                                            <label for="username">Username:</label>
                                            <input type="text" class="form-control" id="username" value='<%=rs.getString("name")%>' name="name" placeholder="Enter username" required>
                                            <input type='hidden' value='<%=admin_ID%>' name="admin_ID" >
                                        </div>
                                        <br>
                                        <div class="form-group">
                                            <label for="email">Email:</label>
                                            <input type="email" class="form-control" id="email" value='<%=rs.getString("email")%>' name="email"  placeholder="Enter email" required>
                                        </div>
                                        <br>
                                        <div class="form-group">
                                            <label for="password">Password:</label>
                                            <input type="password" class="form-control" id="password" name="password"  placeholder="Enter new password" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="confirm password">Password:</label>
                                            <input type="password" class="form-control" id="confirm password" name="confirm_password"  placeholder="Confirm new password" required>
                                        </div>
                                        <br>
                                        <br>
                                        <button type="submit" class="btn btn-primary">Update</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="admin_user_page.jsp" class="btn btn-danger">Cancel</a>
                                            
                                        

                                    </form>

                                    <%                                                 }

                                            } catch (Exception e) {
                                                out.println(e);
                                            }
                                        }

                                    %>





                                </div>

                                <div class="col p-3 "></div>

                                <div class="col p-3 "></div>
                            </div>
                        </div>







                    </div>
                </div>


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