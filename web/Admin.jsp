<%-- 
    Document   : adminlogin_page
    Created on : Aug 8, 2023, 2:00:09 PM
    Author     : pradisharoon
--%>

<%
    String alert = "";
    if (request.getParameter("status") != null) {
        int status = Integer.parseInt(request.getParameter("status"));
        if (status == 0) {
            alert = "<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" style = \"opacity:0.7;\">\n" +
                    "  <strong>Invalid!</strong> Username or password.\n" +
                    "  <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>\n" +
                    "</div>";
        }
    }
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- favicon -->
      <link rel="shortcut icon" href="Images/logoOnly.png" type="image/x-icon">
    <title>Wavez | Admin</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <style>
  body {
      background-color: #0e0e0e;
    }

    .navbar {
      background-color: #1d1d1d;
      padding: 10px;
    }

    .navbar-brand img {
      height: 40px;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .form-group {
      margin-bottom: 20px;
    }

    h2 {
      text-align: center;
      color: #b8b6b6;
    }

    p {
      text-align: center;
      font-size: 18px;
      color: #636363;
    }

    label {
      font-weight: bold;
      color: white;
    }

    input[type="email"],
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    .btn{
      padding: 10px;
      font-size: 18px;
      border-radius: 4px;
    }

    .btn-primary:hover {
      opacity: 0.7;
    }

    .btn-link {
      font-size: 16px;
      color: #007bff;
      text-decoration: none;
      padding: 0;
    }

    .btn-link:hover {
      color: #0056b3;
      text-decoration: none;
    }
    @media screen and (max-width: 576px) {
      .container {
        padding-top: 30px;
      }

      .navbar-brand img {
        height: 30px;
      }
    }
  </style>
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
          <a class="navbar-brand" href="#">
              <img src="Images/logoWhite.png" alt="Music Streaming App Logo">
          </a>
        </div>
  </nav>

  <div class="container">
    <div class="row justify-content-center align-items-center">
      
        <div class="col-md-4 p-3 mt-5" style=" background-color: #1b1b1b;">
              <%= alert %>
        <h2>Admin Sign in</h2>
        <p>Login to access the Dashboard.</p>
        <form action="adminlogin.jsp" method="POST">
          <div class="form-group ">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" placeholder="Enter your email" name="email" required>
          </div>
          <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" placeholder="Enter your password" name="password" required>
          </div>
          <button type="submit" class="btn btn-success w-100">Login</button>
        </form>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
</body>

</html>
