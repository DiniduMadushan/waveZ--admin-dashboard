package Classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Album {
    private int album_ID;
    private String album_title;
    private String year;
    private String albumPhoto;

    public Album(String album_title, String year, String albumPhoto) {
        this.album_title = album_title;
        this.year = year;
        this.albumPhoto = albumPhoto;
    }

    public Album(int album_ID, String album_title, String year, String albumPhoto) {
        this.album_ID = album_ID;
        this.album_title = album_title;
        this.year = year;
        this.albumPhoto = albumPhoto;
    }
    
    public int getAlbum_ID() {
        return album_ID;
    }

    public String getAlbum_title() {
        return album_title;
    }

    public String getYear() {
        return year;
    }

    public String getAlbumPhoto() {
        return albumPhoto;
    } 

    public void setAlbumPhoto(String albumPhoto) {
        this.albumPhoto = albumPhoto;
    }

    public boolean add(Connection con) throws SQLException {
        String query = "INSERT INTO album (album_title,year,albumPhoto) VALUES (?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, album_title);
        pstmt.setString(2, year);
        pstmt.setString(3, albumPhoto);
 
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }
    
    public  boolean update(int id,String album_title,String year,String albumPhoto, Connection con) throws SQLException {
        String query = "UPDATE  album SET album_title = ?,year = ?,albumPhoto = ? WHERE album_ID = ? ";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1,  album_title);
        pstmt.setString(2, year);
        pstmt.setString(3, albumPhoto); 
        pstmt.setInt(4, id);
 
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }

    public boolean remove(Connection con) throws SQLException {
        String query = "DELETE FROM album WHERE album_ID = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, album_ID);
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }

    public static List<Album> displayAlbums(Connection con) throws SQLException {
        List<Album> album_list = new ArrayList<>();
        String query = "SELECT * FROM album";
        try (PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int album_ID = rs.getInt("album_ID");
                String tittle = rs.getString("album_title");
                String year = rs.getString("year");
                String albumPhoto = rs.getString("albumPhoto");
                
                Album album = new Album(album_ID, tittle, year, albumPhoto);
                album_list.add(album);
            }
        }
        return album_list;
    }

    public static Album getAlbum(int id, Connection con) throws SQLException {
        String query = "SELECT * FROM album WHERE album_ID = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int album_ID = rs.getInt("album_ID");
                    String tittle = rs.getString("album_title");
                    String year = rs.getString("year");
                    String albumPhoto = rs.getString("albumPhoto");

                    return new Album(album_ID, tittle, year, albumPhoto);
                }
            }
        }
        return null;
    }
}
