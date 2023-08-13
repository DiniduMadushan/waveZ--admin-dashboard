/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Classes;

import java.sql.*;
import Classes.DBconnector;

/**
 *
 * @author pradisharoon
 */
public class Admin {

    private int admin_ID;
    private String name;
    private String email;
    private String password;

    public Admin(int admin_ID, String name, String email, String password) {
        this.admin_ID = admin_ID;
        this.name = name;
        this.email = email;
        this.password = password;
    }
    public Admin(int admin_ID, String name, String email) {
        this.admin_ID = admin_ID;
        this.name = name;
        this.email = email;
        
    }

    

    public Admin(String email, String password) {
        this.email = email;
        this.password = password;
    }
    
    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean Authenticate(Connection con) throws SQLException {
        String query = "SELECT * FROM admin WHERE email=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            String db_password = rs.getString("password");
            if (db_password.equals(password)) {
                admin_ID = Integer.parseInt(rs.getString("admin_ID"));
                name = rs.getString("name");
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public static Admin getAdmin(String email_1, Connection con) throws SQLException {
        String query = "SELECT * FROM admin WHERE email = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1,email_1);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int admin_ID = rs.getInt("admin_ID");
                    String name = rs.getString("name");
                    String email = rs.getString("email");

                    return new Admin(admin_ID, name, email);
                }
            }
        }
        return null;
    }

}
