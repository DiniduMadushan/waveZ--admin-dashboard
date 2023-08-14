<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="Classes.DBconnector" %>
<%@page import="Classes.User" %>
<%@ page import="Classes.Artist" %>
<%@ page import="Classes.Album" %>
<%@ page import="Classes.Track" %>
<%@ page import=" java.util.ArrayList"%>
<%@ page import=" java.util.List"%>

<%  
        String name="";
        if (session != null && session.getAttribute("email_1") != null && session.getAttribute("type_1") != null) {
            
            String email = (String) session.getAttribute("email_1");
            String userType = (String) session.getAttribute("type_1");
            User user=User.getUser(email,DBconnector.getCon());
            name=user.getName();
            }
            
 %> 
 


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <!-- favicon -->
        <link rel="shortcut icon" href="Images/logoOnly.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">-->
   
    <link rel="stylesheet" href="CSS/main.css">
    <title>Music App</title>
</head>

<body>
<header>
    <div class="menu_side">
        <h1><img src="Images/logoWhite.png" alt="Music Streaming App Logo" style="height: 38px; "></h1>
        <div class="playlist">
            <h4 class="active"><span></span><i class="bi bi-music-note-beamed"></i> Playlist</h4>
            <h4 ><span></span><i class="bi bi-music-note-beamed"></i> Last Listening</h4>
            <h4 ><span></span><i class="bi bi-music-note-beamed"></i> Recommended</h4>
        </div>
        <div class="menu_song">
                                                      <% 
                            List<Track> tracks = Track.displayTracks(DBconnector.getCon());
                            for(Track track : tracks){
                        %>
            <li class="songItem">
                <span><%= track.getTrack_ID() %></span>
                <img src="<%= "upload/music/"+track.getPhoto() %>" alt="<%= track.getTitle() %>">
                <h5>
                    <%= track.getTitle() %>
                    <div class="subtitle">   <%  Artist artistT = Artist.getArtist(track.getArtist_ID(), DBconnector.getCon()); %>
                                <%=artistT.getName()%></div>
                    <div class="subtitle"><%  Album albumT = Album.getAlbum(track.getAlbum_ID(), DBconnector.getCon()); %>
                                <%=albumT.getAlbum_title()%></div>
                </h5>
                              <audio id="musicPlayer" controls style="width: 50%;">
                                            <source id="audio" src=" <%= "upload/audio/"+track.getFile() %>" type="">
                                        </audio>
            </li>
                          <%
                            }
                        %>
           
        </div>
    </div>


    <div class="song_side">
        <nav>
            <ul>
                <li>Discover <span></span></li>
                <li>MY LIBRARY</li>
                <li>RADIO</li>
            </ul>
            <div class="search">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search Music...">
            </div>
            <div class="user">
                <p class="me-4"><%=name%></p>
            </div>
        </nav>
        <div class="content">
            <h1><%=name%></h1>
            <p>
                You were the shadow to my light Did you feel us Another start You fade 
                <br>
                Away afraid our aim is out of sight Wanna see us Alive
            </p>
            <div class="buttons">
                <a href="login.jsp"><button>Login</button></a>
                <a href="signup.jsp"><button>Signup now</button></a>
            </div>
        </div>
        <div class="popular_song">
            <div class="h4">
                <h4>Popular Albums</h4>
                <div class="btn_s">
                    <i id="left_scroll" class="bi bi-arrow-left-short"></i>
                    <i id="right_scroll" class="bi bi-arrow-right-short"></i>
                </div>
            </div>
            <div class="pop_song">
                       <% 
                            List<Album> albums = Album.displayAlbums(DBconnector.getCon());
                            for(Album album : albums){
                        %>
                <li class="songItem">
                    <div class="img_play">
                        <img src="<%= "upload/album/"+album.getAlbumPhoto() %>" alt="<%= album.getAlbum_title() %>">
                        <i class="bi playListPlay bi-play-circle-fill" id="7"></i>
                    </div>
                    <h5><%= album.getAlbum_title() %>
                        <br>
                        <div class="subtitle"><%= album.getYear() %></div>
                    </h5>
                </li>
                <%
                    }
                    %>
            </div>
        </div>
            
        <div class="popular_artists">
            <div class="h4">
                <h4>Popular Artists</h4>
                <div class="btn_s">
                    <i id="left_scrolls" class="bi bi-arrow-left-short"></i>
                    <i id="right_scrolls" class="bi bi-arrow-right-short"></i>
                </div>
            </div>
            <div class="item">
                        <% 
                            List<Artist> artists = Artist.displayArtist(DBconnector.getCon());
                            for(Artist artist : artists){
                        %>
                <li>
                    <img src="<%= "upload/artist/"+artist.getPhoto() %>" alt="<%= artist.getName() %>" title="Arjit Singh">
                </li>
                <%
                    }
                    %>
                <!-- change all img  -->
            </div>
        </div>
    </div>


    <div class="master_play">
        <div class="wave">
            <div class="wave1"></div>
            <div class="wave1"></div>
            <div class="wave1"></div>
        </div>
        <img src="Images/logoOnly.png" alt="logo" id="poster_master_play">
        <h5 id="title">Music<br>
            <div class="subtitle">Wavez</div>
        </h5>
        <div class="icon">
            <i class="bi bi-skip-start-fill" id="back"></i>
            <i class="bi bi-play-fill" id="masterPlay"></i>
            <i class="bi bi-skip-end-fill" id="next"></i>
        </div>
        <span id="currentStart">0:00</span>
        <div class="bar">
            <input type="range" id="seek" min="0" value="0" max="100">
            <div class="bar2" id="bar2"></div>
            <div class="dot"></div>
        </div>
        <span id="currentEnd">0:00</span>

        <div class="vol">
            <i class="bi bi-volume-down-fill" id="vol_icon"></i>
            <input type="range" id="vol" min="0" value="30" max="100">
            <div class="vol_bar"></div>
            <div class="dot" id="vol_dot"></div>
        </div>
    </div>
</header>
                    <!--bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>

    <script src="assets/js/main1.js"></script>
</body>

</html>
