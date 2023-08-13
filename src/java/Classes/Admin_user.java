package Classes;

import Classes.DBconnector;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Admin_user {

    private int admin_ID;
    private String name;
    private String email;
    private String password;

    public Admin_user(String name, String password) {
        this.name = name;
        this.password = password;
    }
    public Admin_user(String name,String email, String password) {
        this.name = name;
        this.email=email;
        this.password = password;
    }

    public Admin_user(int admin_ID,String name, String email, String password) {
        this.admin_ID=admin_ID;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public int getAdmin_ID() {
        return admin_ID;
    }

    public void setAdmin_ID(int admin_ID) {
        this.admin_ID = admin_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public boolean notValid(Connection con) throws SQLException {
        String query = "SELECT *FROM admin WHERE email=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean registerAdmin(Connection con) throws SQLException {
        String query = "INSERT INTO admin (name,email,password)VALUES(?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        int x = pstmt.executeUpdate();
        return (x > 0);
    }

    public boolean updateAdmin(Connection con) throws SQLException {
        String query = "UPDATE admin SET name=?,email=?,password=? WHERE admin_ID=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        pstmt.setInt(4, admin_ID);
        int x = pstmt.executeUpdate();
        return (x > 0);
    }

    public static boolean deleteAdmin(Connection con,int admin_ID) throws SQLException {
        String query = "DELETE FROM admin WHERE admin_ID=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, admin_ID);
        int x = pstmt.executeUpdate();
        return (x > 0);
    }

    public static boolean deleteUser(Connection con, int user_ID) throws SQLException {
        String query = "DELETE FROM user WHERE user_ID=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, user_ID);
        int x = pstmt.executeUpdate();
        return (x > 0);
    }

    public static int getUserCount(Connection con) throws SQLException {
        int user_count=0;
        String query = "SELECT COUNT(*) AS total_rows FROM user";
        PreparedStatement pstmt = con.prepareStatement(query);
        ResultSet rs=pstmt.executeQuery();
        if(rs.next()){
            user_count=rs.getInt("total_rows");
        }
        return user_count;
        
    }
     public static int getAdminCount(Connection con) throws SQLException {
        int admin_count=0;
        String query = "SELECT COUNT(*) AS total_rows FROM admin";
        PreparedStatement pstmt = con.prepareStatement(query);
        ResultSet rs=pstmt.executeQuery();
        if(rs.next()){
            admin_count=rs.getInt("total_rows");
        }
        return admin_count;
        
    }
     
   
}
