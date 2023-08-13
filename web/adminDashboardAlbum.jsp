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
<%@ page import="Classes.Album" %>
<%@ page import=" java.util.ArrayList"%>
<%@ page import=" java.util.List"%>

<%
    String alert = "";
    if (request.getParameter("status") != null) {
        int status = Integer.parseInt(request.getParameter("status"));
        if (status == 1) {
            alert = "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\" style = \"opacity:0.7;\">\n" +
                    "  <strong>Successfully</strong> Updated.\n" +
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
                    "  <strong>Album already added !</strong>\n" +
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
                                <a href="./adminDashboardArtist.jsp" class="nav-link link-body-emphasis text-white ">                                   
                                    Artist
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="" class="nav-link link-body-emphasis text-white active">
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
                <div class="p-3 mt-5 mb-3 me-4 " style=" background-color: #1b1b1b;">
                    <%= alert %>
                    <div class="d-flex">
                        <h2>Add Album</h2>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary ms-5" data-bs-toggle="modal" data-bs-target="#addModal">
                           Add Album
                        </button>
                    </div>
                    <!-- add Modal -->
                    <div class="modal fade" id="addModal" tabindex="-1" data-bs-backdrop="static" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" >
                            <div class="modal-content mt-5" style=" background-color: #1b1b1b;">
                                <form action="addAlbum" method="POST" enctype="multipart/form-data">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Add Album</h1>
                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close">X</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="input-group flex-nowrap p-1 m-1">
                                            <span class="input-group-text" id="addon-wrapping">Album Title</span>
                                            <input type="text" class="form-control" placeholder="Album Title" aria-label="Album Title" aria-describedby="addon-wrapping" name="albumTitle">
                                        </div>
                                        <div class="input-group flex-nowrap p-1 m-1">
                                            <span class="input-group-text" id="addon-wrapping">Date</span>
                                            <input type="date" class="form-control" placeholder="Date" aria-label="Date" aria-describedby="addon-wrapping" name="albumdate">
                                        </div>
                                        <div class="input-group flex-nowrap p-1 m-1">
                                            <span class="input-group-text" id="addon-wrapping">Artist Photo</span>
                                            <input type="file" class="form-control" placeholder="Artist Photo" aria-label="Artist Photo" aria-describedby="addon-wrapping" name="albumPhoto">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Artist table -->
                <table class="table table-dark  me-4" style="background-color: #1b1b1b">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Title</th>
                            <th scope="col">Year</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Album> albums = Album.displayAlbums(DBconnector.getCon());
                            for(Album album : albums){
                        %>
                        <tr>
                            <th class=" " scope="row"><%= album.getAlbum_ID() %></th>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="<%= "upload/album/"+album.getAlbumPhoto() %>" alt="<%= album.getAlbum_title() %> Photo"
                                         class="rounded me-2" style="width: 32px; height: 32px; object-fit: cover;" />
                                    <p class="ms-2 m-0"><%= album.getAlbum_title() %></p>
                                </div>                        
                            <td>
                                <%= album.getYear() %>
                            </td>
                            </td>
                            <td>
                                <div class="d-flex">
                                <button type="button" class="btn btn-primary mx-2 p-1 " data-bs-toggle="modal" data-bs-target="#editModal<%= album.getAlbum_ID()%>">
                                    Edit Album
                                </button>
                                <form action="deleteAlbum" method="POST">
                                    <input type="hidden" name="album_ID" value="<%= album.getAlbum_ID()%>">
                                    <button type="submit" class="btn btn-danger p-1">Delete</button>
                                </form>
                                    </div>
                                <!-- Edit Modal -->
                                <div class="modal fade" id="editModal<%= album.getAlbum_ID()%>" tabindex="-1" data-bs-backdrop="static" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" >
                                        <div class="modal-content mt-5" style=" background-color: #1b1b1b;">
                                            <form action="editAlbum" method="POST" enctype="multipart/form-data">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Edit Album</h1>
                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close">X</button>
                                                </div>
                                                <div class="modal-body">
                                                    <input type="hidden" name="album_ID" value="<%= album.getAlbum_ID()%>">
                                                    <div class="d-flex align-items-center justify-content-center">
                                                   <img src="<%= "upload/album/" + album.getAlbumPhoto() %>" alt="<%= album.getAlbum_title() %> Photo"
                                                             class="rounded-circle me-2" id="previewImage" style="width: 150px; height: 150px; object-fit: cover;">
                                                    </div>
                                                    <div class="input-group flex-nowrap p-1 m-1">
                                                        <span class="input-group-text" id="addon-wrapping">Album Title</span>
                                                        <input type="text" class="form-control" placeholder="Album Title" aria-label="Album Title"
                                                               aria-describedby="addon-wrapping" name="albumTitle" value="<%= album.getAlbum_title() %>">
                                                    </div>              
                                                               <div class="input-group flex-nowrap p-1 m-1">
                                                                   <span class="input-group-text" id="addon-wrapping">Date</span>
                                                                   <input type="text" class="form-control" placeholder="Date" aria-label="Date"
                                                                          aria-describedby="addon-wrapping" name="albumdate" value=" <%= album.getYear() %>">
                                                               </div>
                                                    <div class="input-group flex-nowrap p-1 m-1">
                                                        <span class="input-group-text" id="addon-wrapping">Album Photo</span>
                                                        <input type="file" class="form-control" aria-label="Album Photo"
                                                               aria-describedby="addon-wrapping" id="image" accept="image/*" name="albumPhoto">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary">Save changes</button>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

            </div>
        </div>

<script>
                    // Calling the preview() function with correct input and previewImage IDs
                    preview( "image", "previewImage" );
                 
                    function preview ( input, previewImage )
                    {
                        document.getElementById( input ).addEventListener( "change", function ()
                        {
                            var fileInput = this;
                            if ( fileInput.files && fileInput.files[ 0 ] )
                            {
                                var reader = new FileReader();
                                reader.onload = function ( e )
                                {
                                    var previewImageElement = document.getElementById( previewImage );
                                    previewImageElement.src = e.target.result;
                                    previewImageElement.style.display = "block";
                                };

                                reader.readAsDataURL( fileInput.files[ 0 ] );
                            }
                        } );
                    }
                </script>

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
