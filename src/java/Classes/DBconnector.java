
package Classes;
import java.sql.*;
public class DBconnector {
    private static final String DRIVER ="com.mysql.jdbc.Driver";
    private static final String URL ="jdbc:mysql://localhost:3306/wavez?";
    private static final String USER ="testuser";
    private static final String PASSWORD ="testuser";
    
    public static Connection getCon() throws ClassNotFoundException, SQLException{
        Class.forName(DRIVER);
        Connection con=DriverManager.getConnection(URL, USER, PASSWORD);
        return con;
    }
    
}
 