/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author pradisharoon
 */
public class Track {
   private int track_ID;
   private int album_ID;
   private int artist_ID;
   private String title;
   private String genre;
   private String year;
   private String photo;
   private String file;

    public Track(int track_ID, int album_ID, int artist_ID, String title, String genre, String year, String photo, String file) {
        this.track_ID = track_ID;
        this.album_ID = album_ID;
        this.artist_ID = artist_ID;
        this.title = title;
        this.genre = genre;
        this.year = year;
        this.photo = photo;
        this.file = file;
    }

    public Track(int album_ID, int artist_ID, String title, String genre, String year, String photo, String file) {
        this.album_ID = album_ID;
        this.artist_ID = artist_ID;
        this.title = title;
        this.genre = genre;
        this.year = year;
        this.photo = photo;
        this.file = file;
    }

    public Track(int album_ID, int artist_ID, String title, String photo, String file) {
        this.album_ID = album_ID;
        this.artist_ID = artist_ID;
        this.title = title;
        this.photo = photo;
        this.file = file;
    }

    public int getTrack_ID() {
        return track_ID;
    }

    public int getAlbum_ID() {
        return album_ID;
    }

    public int getArtist_ID() {
        return artist_ID;
    }

    public String getTitle() {
        return title;
    }

    public String getGenre() {
        return genre;
    }

    public String getYear() {
        return year;
    }

    public String getPhoto() {
        return photo;
    }

    public String getFile() {
        return file;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public void setFile(String file) {
        this.file = file;
    }

   
        public boolean add(Connection con) throws SQLException {
        String query = "INSERT INTO track (title,artist_ID,album_ID,genre,year,photo,file) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, title);
        pstmt.setInt(2, artist_ID);
        pstmt.setInt(3, album_ID);
        pstmt.setString(4, genre);
        pstmt.setString(5, year);
        pstmt.setString(6, photo);
        pstmt.setString(7, file);
 
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }
       
    public  boolean update(int id,String title,int artist_ID, int album_ID,String genre,String year,String photo,String file, Connection con) throws SQLException {
        String query = "UPDATE  track SET title = ?,artist_ID = ?,album_ID = ?,genre = ?,year = ?,photo = ?,file = ? WHERE track_ID = ? ";
        PreparedStatement pstmt = con.prepareStatement(query);
      pstmt.setString(1, title);
        pstmt.setInt(2, artist_ID);
        pstmt.setInt(3, album_ID);
        pstmt.setString(4, genre);
        pstmt.setString(5, year);
        pstmt.setString(6, photo);
        pstmt.setString(7, file);
        pstmt.setInt(8, id);
 
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }
    
        public boolean remove(int id ,Connection con) throws SQLException {
        String query = "DELETE FROM track WHERE track_ID = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }
        
          public static List<Track> displayTracks(Connection con) throws SQLException {
        List<Track> track_list = new ArrayList<>();
        String query = "SELECT * FROM track";
        try (PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int track_ID = rs.getInt("track_ID");
                String tittle = rs.getString("title");
                int artist_ID  = rs.getInt("artist_ID");
                int album_ID = rs.getInt("album_ID");
                String genre = rs.getString("genre");
                String year = rs.getString("year");
                String photo = rs.getString("photo");
                String file = rs.getString("file");
               
                Track track = new Track(track_ID, album_ID, artist_ID, tittle, genre, year, photo, file);
                track_list.add(track);
            }
        }
        return track_list;
    }
          
              public static Track getTrack(int id, Connection con) throws SQLException {
        String query = "SELECT * FROM track WHERE track_ID = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                      int track_ID = rs.getInt("track_ID");
                String tittle = rs.getString("title");
                int artist_ID  = rs.getInt("artist_ID");
                int album_ID = rs.getInt("album_ID");
                String genre = rs.getString("genre");
                String year = rs.getString("year");
                String photo = rs.getString("photo");
                String file = rs.getString("file");

                    return new Track(track_ID, album_ID, artist_ID, tittle, genre, year, photo, file);
                }
            }
        }
        return null;
    }
}
