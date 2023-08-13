package Classes;

import java.sql.*;
import Classes.DBconnector;

public class User {

    private int user_ID;
    private String name;
    private String email;
    private String password;
    
    

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public User(int user_ID, String name, String email) {
        this.user_ID = user_ID;
        this.name = name;
        this.email = email;
    }
    

    public User(String name,String email, String password) {
        
        this.name = name;
        this.email = email;
        this.password = password;
       
       
    }

    public void setUser_ID(int user_ID) {
        this.user_ID= user_ID;
    }

    public int getUser_ID() {
        return this.user_ID;
    }
    
    public void setName(String name) {
        this.name=name;
    }

    public String getName() {
        return this.name;
    }

     public void setEmail(String email) {
        this.email=email;
    }
    public String getEmail() {
        return this.email;
    }
   

   public boolean notValid(Connection con) throws SQLException{
       String query="SELECT *FROM user WHERE email=?";
       PreparedStatement pstmt=con.prepareStatement(query);
       pstmt.setString(1,email);
       ResultSet rs=pstmt.executeQuery();
       if(rs.next()){
           return true;
       }else{
           return false;
       }
   }

    public boolean Register(Connection con) throws SQLException {
        String query = "INSERT INTO user (name,email,password) VALUES(?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        
        int a = pstmt.executeUpdate();
        return (a > 0);
    }
        

    public boolean Authenticate(Connection con) throws SQLException {
        String query = "SELECT *FROM user WHERE email=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            String db_password = rs.getString("password");
            if (db_password.equals(password)) {
                user_ID=Integer.parseInt(rs.getString("user_ID"));
                name=rs.getString("name"); 
                
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
     public static User getUser(String email_1, Connection con) throws SQLException {
        String query = "SELECT * FROM user WHERE email = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1,email_1);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int user_ID = rs.getInt("user_ID");
                    String name = rs.getString("name");
                    String email = rs.getString("email");

                    return new User(user_ID, name, email);
                }
            }
        }
        return null;
    }
 
}
