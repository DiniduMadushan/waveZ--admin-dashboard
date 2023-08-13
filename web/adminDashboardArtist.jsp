<%-- 
    Document   : adminlogin_page
    Created on : Aug 8, 2023, 2:00:09 PM
    Author     : pradisharoon
--%>
 <%
        if (session != null && session.getAttribute("email") != null && session.getAttribute("type") != null) {
            
            String email = (String) session.getAttribute("email");
            String userType = (String) session.getAttribute("type");
            

            
 %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Classes.DBconnector" %>
<%@ page import="Classes.Artist" %>
<%@ page import=" java.util.ArrayList"%>
<%@ page import=" java.util.List"%>

<%
    String alert = "";
    if (request.getParameter("status") != null) {
        int status = Integer.parseInt(request.getParameter("status"));
        if (status == 0) {
            alert = "<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" style = \"opacity:0.7;\">\n" +
                    "  <strong>Error!</strong> Username or password.\n" +
                    "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\n" +
                    "</div>";
        }
        if (status == 2) {
            alert = "<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" style = \"opacity:0.7;\">\n" +
                    "  <strong>Invalid!</strong> file type jpg png and jpeg only allowed.\n" +
                    "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\n" +
                    "</div>";
        }
        if (status == 3) {
            alert = "<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" style = \"opacity:0.7;\">\n" +
                    "  <strong>pleace select a image for artist !</strong>\n" +
                    "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\n" +
                    "</div>";
        }
        if (status == 4) {
            alert = "<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" style = \"opacity:0.7;\">\n" +
                    "  <strong>artist already added !</strong>\n" +
                    "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\n" +
                    "</div>";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- favicon -->
        <link rel="shortcut icon" href="Images/logoOnly.png" type="image/x-icon">
        <title>Wavez | Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
   <!--fontawesom-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
       
        <style>
            body {
                background-color: #0e0e0e;
                color :#ccc;
                overflow-x: hidden;
            }
            .nav-item{
                
            }
            .nav-item:hover{
                background-color: #5e5e5e;
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top  w-100"  style="background-color: #1d1d1d ">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="Images/logoWhite.png" alt="Music Streaming App Logo" style="height: 38px; ">
                </a>
                <!--profile-->
                <div class="dropdown dropdown-menu-dark">
                    <dvi class="" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <a class="navbar-brand  dropdown-toggle" href="#" type="button"> <img
                                src="https://source.unsplash.com/random/5" alt="avatar" class="rounded-circle me-2 "
                                style="width: 38px; height: 38px; object-fit: cover" data-bs-toggle="tooltip"
                                data-bs-title=" See your profile" data-bs-placement="bottom"
                                data-bs-title="Tooltip on bottom" /></a>
                    </dvi>
                    <ul class="dropdown-menu dropdown-menu-dark">
                        <!--avatar-->
                        <li><a class="dropdown-item" href="#">
                                <div class="d-flex align-items-center">
                                    <img src="https://source.unsplash.com/random/5" alt="avatar"
                                         class="rounded-circle me-2 "
                                         style="width: 48px; height: 48px; object-fit: cover" />
                                    <div class="d-flex flex-column mt-3 p-0">
                                        <span class="fw-bold fs-6">Name</span>
                                    </div>
                                </div>
                            </a></li>
                        <hr>
                        <!--logout-->
                        <li><a class="dropdown-item" href="logout_admin.jsp">
                                <div class="d-flex align-items-center me-2">
                                    <i class="fa fa-sign-out justify-content-center fs-5"></i>
                                    <p class="m-0 ms-2">Log out</p>
                                </div>
                            </a></li>
                    </ul>
                </div>

            </div>
        </nav>

        <div class="row vh-100" style="padding-top: 65px;">
            <!--side nav bar-->
            <div class="col-2 sidebar position-fixed " >
                <div class="vh-100" style="background-color: #1d1d1d !important;overflow-y: auto">
                    <div class="d-flex flex-column flex-shrink-0 p-3 d-none d-lg-block  vh-100" style="max-width: 20rem">              
                        <ul class="nav nav-pills flex-column mb-auto">
                            <li class="nav-item">
                                <a href="" class="nav-link link-body-emphasis text-white active">                                   
                                    Artist
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="./adminDashboardAlbum.jsp" class="nav-link link-body-emphasis text-white">
                                    Album
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="./adminDashboardMusic.jsp" class="nav-link link-body-emphasis text-white " >                                   
                                    Music
                                </a>
                            </li>
                                        <li class="nav-item">
                                <a href="./User_dashboard.jsp" class="nav-link link-body-emphasis text-white " >                                   
                                    User Management
                                </a>
                            </li>
                        </ul>
                        <hr>

                    </div>
                </div>
            </div>
   
            <div class="main col-2 "></div>
            <div class="main col-10 ">
                <div class="p-3 mt-5 mb-3 me-4" style=" background-color: #1b1b1b;">
                    <%= alert %>
                    <h2>Add Artist </h2>
                    <form action="addArtist" method="POST" enctype="multipart/form-data">
                        <div class="d-flex justify-content-evenly align-items-center">
                            <div class="input-group flex-nowrap p-1 m-1">
                                <span class="input-group-text" id="addon-wrapping">Artist name</span>
                                <input type="text" class="form-control" placeholder="Artist name" aria-label="Artistname" aria-describedby="addon-wrapping" name="artistname">
                            </div>
                            <div class="input-group p-1 m-1">
                                <span class="input-group-text" id="addon-wrapping">Artist photo</span>
                                <input type="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload" name="artistphoto">
                            </div>
                            <button type="submit" class="btn btn-success m-1 w-25">Add</button>
                        </div>
                    </form>

                </div>

                <!-- Artist table -->
                <table class="table table-dark table-striped-columns me-4" style="background-color: #1b1b1b">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Artist> artists = Artist.displayArtist(DBconnector.getCon());
                            for(Artist artist : artists){
                        %>
                        <tr>
                            <th class=" " scope="row"><%= artist.getArtist_ID() %></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="<%= "upload/artist/"+artist.getPhoto() %>" alt="<%= artist.getName() %> Photo"
                                         class="rounded-circle me-2" style="width: 32px; height: 32px; object-fit: cover;" />
                                    <p class="ms-2 m-0"><%= artist.getName() %></p>
                                </div>
                            </td>
                            <td>
                                <form action="deleteArtist" method="POST">
                                    <input type="hidden" name="artist_ID" value="<%= artist.getArtist_ID()%>">
                                    <button type="submit" class="btn btn-danger p-1">Delete</button>
                              </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

            </div>
        </div>



        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!--bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

        <script>
                             const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
                             const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
        </script>
    </body>

</html>
<%
     } else {
           response.sendRedirect("Admin.jsp");
      }
 %>   