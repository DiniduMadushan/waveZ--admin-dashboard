package servlet;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Classes.DBconnector;
import Classes.Artist;

@WebServlet(name = "DeleteArtistServlet", urlPatterns = {"/deleteArtist"})
public class DeleteArtistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int artistid = Integer.parseInt(request.getParameter("artist_ID"));

            Artist artist = Artist.getArtist(artistid, DBconnector.getCon());

            if (artist != null && artist.remove(DBconnector.getCon())) {
                // Deleting image file
                String uniqueFileName = artist.getPhoto(); // Retrieve the unique file name from the database
                String uploadDirectory = "/upload/artist"; // the uploadDirectory 
                File imageFile = new File(getServletContext().getRealPath(uploadDirectory) + File.separator + uniqueFileName);

                if (imageFile.exists()) {
                    imageFile.delete();
                }

                response.sendRedirect("adminDashboardArtist.jsp?status=5"); // Deleted successfully
            } else {
                response.sendRedirect("adminDashboardArtist.jsp?status=6"); // Deletion failed
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboardArtist.jsp?status=7"); // Error occurred
        }
    }
}
