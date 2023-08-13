package servlet;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Classes.DBconnector;
import Classes.Track;

@WebServlet(name = "DeleteMusicServlet", urlPatterns = {"/deleteMusic"})
public class DeleteMusicServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int track_ID = Integer.parseInt(request.getParameter("track_ID"));

            Track track = Track.getTrack(track_ID, DBconnector.getCon());

            if (track != null && track.remove(track_ID,DBconnector.getCon())) {
                // Deleting audio file
                String audioFileName = track.getFile();
                String audioUploadDirectory = "/upload/audio";
                File audioFile = new File(getServletContext().getRealPath(audioUploadDirectory) + File.separator + audioFileName);

                if (audioFile.exists()) {
                    audioFile.delete();
                }

                // Deleting music photo
                String photoFileName = track.getPhoto();
                String photoUploadDirectory = "/upload/music";
                File photoFile = new File(getServletContext().getRealPath(photoUploadDirectory) + File.separator + photoFileName);

                if (photoFile.exists()) {
                    photoFile.delete();
                }

                response.sendRedirect("adminDashboardMusic.jsp?status=5"); // Deleted successfully
            } else {
                response.sendRedirect("adminDashboardMusic.jsp?status=6"); // Deletion failed
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboardMusic.jsp?status=7"); // Error occurred
        }
    }
}
