package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import Classes.DBconnector;
import Classes.Track;

@WebServlet(name = "EditMusicServlet", urlPatterns = {"/editMusic"})
@MultipartConfig
public class EditMusicServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int track_ID = Integer.parseInt(request.getParameter("track_ID"));
            String title = request.getParameter("title");
            int artist_ID = Integer.parseInt(request.getParameter("artist"));
            int album_ID = Integer.parseInt(request.getParameter("album"));
            String genre = request.getParameter("genre");
            String musicDate = request.getParameter("musicDate");
            Part photo = request.getPart("photo");
            Part audioFile = request.getPart("file");

            Track track = Track.getTrack(track_ID, DBconnector.getCon());

            // Update other track information (title, artist, album, etc.)
            // Handle photo update
            if (photo != null && photo.getSize() > 0) {
                String photoFileName = photo.getSubmittedFileName();

                // Delete the old photo if it exists
                if (track.getPhoto() != null && !track.getPhoto().isEmpty()) {
                    String uploadDirectory = "/upload/music";
                    File oldPhotoFile = new File(getServletContext().getRealPath(uploadDirectory)
                            + File.separator + track.getPhoto());
                    if (oldPhotoFile.exists()) {
                        oldPhotoFile.delete();
                    }
                }

                // Save the new photo file
                String uploadDirectory = "/upload/music";
                File directory = new File(getServletContext().getRealPath(uploadDirectory));
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                String uniqueFileName = System.currentTimeMillis() + "_" + photoFileName;
                String photoFilePath = directory.getAbsolutePath() + File.separator + uniqueFileName;

                try (InputStream photoInputStream = photo.getInputStream(); OutputStream photoOutputStream = new FileOutputStream(photoFilePath)) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = photoInputStream.read(buffer)) != -1) {
                        photoOutputStream.write(buffer, 0, bytesRead);
                    }
                }

                track.setPhoto(uniqueFileName);
            }

            // Handle audio file update
            if (audioFile != null && audioFile.getSize() > 0) {
                String audioFileName = audioFile.getSubmittedFileName();

                // Delete the old audio file if it exists
                if (track.getFile() != null && !track.getFile().isEmpty()) {
                    String uploadDirectory = "/upload/audio";
                    File oldAudioFile = new File(getServletContext().getRealPath(uploadDirectory)
                            + File.separator + track.getFile());
                    if (oldAudioFile.exists()) {
                        oldAudioFile.delete();
                    }
                }

                // Save the new audio file
                String uploadDirectory = "/upload/audio";
                File directory = new File(getServletContext().getRealPath(uploadDirectory));
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                String uniqueFileName = System.currentTimeMillis() + "_" + audioFileName;
                String audioFilePath = directory.getAbsolutePath() + File.separator + uniqueFileName;

                try (InputStream audioInputStream = audioFile.getInputStream(); OutputStream audioOutputStream = new FileOutputStream(audioFilePath)) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = audioInputStream.read(buffer)) != -1) {
                        audioOutputStream.write(buffer, 0, bytesRead);
                    }
                }

                track.setFile(uniqueFileName);
            }
            if (track.update(album_ID, title, artist_ID, album_ID, genre, musicDate, track.getPhoto(), track.getFile(), DBconnector.getCon())) {
                // Redirect to appropriate page
                response.sendRedirect("adminDashboardMusic.jsp?status=1"); // Success
            }
        } catch (Exception e) {
            response.getWriter().write("An error occurred: " + e.getMessage());
        }
    }
}
