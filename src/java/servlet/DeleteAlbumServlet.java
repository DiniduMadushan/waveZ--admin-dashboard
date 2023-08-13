package servlet;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Classes.DBconnector;
import Classes.Album;

@WebServlet(name = "DeleteAlbumServlet", urlPatterns = {"/deleteAlbum"})
public class DeleteAlbumServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int albumid = Integer.parseInt(request.getParameter("album_ID"));

            Album album = Album.getAlbum(albumid, DBconnector.getCon());

            if (album != null && album.remove(DBconnector.getCon())) {
                // Deleting image file
                String uniqueFileName = album.getAlbumPhoto(); // Retrieve the unique file name from the database
                String uploadDirectory = "/upload/album"; // the uploadDirectory 
                File imageFile = new File(getServletContext().getRealPath(uploadDirectory) + File.separator + uniqueFileName);

                if (imageFile.exists()) {
                    imageFile.delete();
                }

                response.sendRedirect("adminDashboardAlbum.jsp?status=5"); // Deleted successfully
            } else {
                response.sendRedirect("adminDashboardAlbum.jsp?status=6"); // Deletion failed
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboardAlbum.jsp?status=7"); // Error occurred
        }
    }
}
