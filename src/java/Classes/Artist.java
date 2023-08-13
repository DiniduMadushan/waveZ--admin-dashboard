package Classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Artist {
    private int artist_ID;
    private String name;
    private String photo;

    public Artist(String name, String photo) {
        this.name = name;
        this.photo = photo;
    }

    public Artist(int artist_ID, String name, String photo) {
        this.artist_ID = artist_ID;
        this.name = name;
        this.photo = photo;
    }

    public int getArtist_ID() {
        return artist_ID;
    }

    public String getName() {
        return name;
    }

    public String getPhoto() {
        return photo;
    }

    public boolean add(Connection con) throws SQLException {
        String query = "INSERT INTO artist (name, photo) VALUES (?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, photo);
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }

    public boolean remove(Connection con) throws SQLException {
        String query = "DELETE FROM artist WHERE artist_ID = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, artist_ID);
        int affectedRows = pstmt.executeUpdate();
        return (affectedRows > 0);
    }

    public static List<Artist> displayArtist(Connection con) throws SQLException {
        List<Artist> artist_list = new ArrayList<>();
        String query = "SELECT * FROM artist";
        try (PreparedStatement pstmt = con.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int artist_ID = rs.getInt("artist_ID");
                String name = rs.getString("name");
                String photo = rs.getString("photo");
                
                Artist artist = new Artist(artist_ID, name, photo);
                artist_list.add(artist);
            }
        }
        return artist_list;
    }

    public static Artist getArtist(int id, Connection con) throws SQLException {
        String query = "SELECT * FROM artist WHERE artist_ID = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int artist_ID = rs.getInt("artist_ID");
                    String name = rs.getString("name");
                    String photo = rs.getString("photo");
                    
                    return new Artist(artist_ID, name, photo);
                }
            }
        }
        return null;
    }
}
