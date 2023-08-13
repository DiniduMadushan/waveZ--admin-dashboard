<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Music Streaming App - Create Account</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
      <!--bootstrap-->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
  <style>
          body {
                background-color: #0e0e0e;
                color :#ccc;
                overflow-x: hidden;
            }

    .navbar {
      background-color:#1d1d1d;
      padding: 10px;
    }

    .navbar-brand img {
      height: 40px;
    }

    .left-column {
      background-image: url('Images/mu2.jpg');
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center;
      height: 100vh;
      padding: 0;
    }

    .right-column {
      padding: 100px;
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

    .btn-primary {
      background-color: #318530;
      border-color: #4de252;
      padding: 10px;
      font-size: 18px;
      border-radius: 4px;
    }

    .btn-primary:hover {
        background-color: #08f8cc;
      border-color: #27843d;
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

    <%
        String alert="";
        if(request.getParameter("status")!=null){
           int status=Integer.parseInt(request.getParameter("status")); 
           if(status==1){
                alert="<p class='text-success'>Successfully Registered!</p>";
            }if(status==2){
                alert="<p class='text-danger'>Registration Failed!</p>";
            }if(status==3){
                alert="<p class='text-danger'>Password mismatched!</p>";
            }
        }
    %>
    
  <div class="container">
    <div class="row">
      <div class="col-md-6 left-column"></div>
      <div class="col-md-6 right-column">
          <%=alert%>
        <h2>Create Your Account</h2>
        <p>Create an account to manage and listen to songs.</p>
        <form action="login_signup_includes/register.jsp" method="post">
          <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
          </div>
          <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" class="form-control" name="name" placeholder="Choose a username" required>
          </div>
          <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="Password" name="password" placeholder="Enter your password" required>
          </div> <div class="form-group">
            <label for="password">Password Confirm:</label>
            <input type="password" class="form-control" id=""confirmPassword"" name="con_password" placeholder="Retype password" required>
          </div>
<!--          <button type="submit" class="btn btn-primary btn-block">Create your Account</button>-->
          <input class="btn btn-primary btn-block" type="submit" value="Create your Account">
        </form>
        <p class="mt-3">Already have an account? <a href="login.jsp" class="btn btn-link">Sign In</a></p>
      </div>
    </div>
  </div>
    
                                

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
     <!--bootstrap-->
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
     integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
     crossorigin="anonymous"></script>
</body>

</html>
