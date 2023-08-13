package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import Classes.DBconnector;
import Classes.Track;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.FileOutputStream;

@WebServlet(name = "AddMusicServlet", urlPatterns = {"/addMusic"})
@MultipartConfig
public class AddMusicServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            int artist = Integer.parseInt(request.getParameter("artist"));
            int album = Integer.parseInt(request.getParameter("album"));
            String genre = request.getParameter("genre");
            String musicDate = request.getParameter("musicDate");
            Part photoPart = request.getPart("photo");
            Part musicPart = request.getPart("file");

            // Check if a file was uploaded
            if (photoPart != null && photoPart.getSize() > 0 && musicPart != null && musicPart.getSize() > 0) {
                String photoFileName = photoPart.getSubmittedFileName();
                String musicFileName = musicPart.getSubmittedFileName();

                if (photoFileName.toLowerCase().endsWith(".jpg") || photoFileName.toLowerCase().endsWith(".png") || photoFileName.toLowerCase().endsWith(".jpeg")) {
                    if (musicFileName.toLowerCase().endsWith(".mp3") || musicFileName.toLowerCase().endsWith(".ogg") || musicFileName.toLowerCase().endsWith(".wav")) {
                        var uploadDirectory = getServletContext().getRealPath("/upload");
                        File albumDirectory = new File(uploadDirectory + File.separator + "music");
                        File musicDirectory = new File(uploadDirectory + File.separator + "audio");

                        // Create directories if they don't exist
                        if (!albumDirectory.exists()) {
                            albumDirectory.mkdirs();
                        }
                        if (!musicDirectory.exists()) {
                            musicDirectory.mkdirs();
                        }

                        String uniquePhotoFileName = System.currentTimeMillis() + "_" + photoFileName;
                        String photoFilePath = albumDirectory.getAbsolutePath() + File.separator + uniquePhotoFileName;

                        String uniqueMusicFileName = System.currentTimeMillis() + "_" + musicFileName;
                        String musicFilePath = musicDirectory.getAbsolutePath() + File.separator + uniqueMusicFileName;

                        Track track = new Track(album, artist, title, genre, musicDate, uniquePhotoFileName, uniqueMusicFileName);
                        if (track.add(DBconnector.getCon())) {
                            try (InputStream photoInputStream = photoPart.getInputStream(); OutputStream photoOutputStream = new FileOutputStream(photoFilePath);
                                    InputStream musicInputStream = musicPart.getInputStream(); OutputStream musicOutputStream = new FileOutputStream(musicFilePath)) {

                                // Copy photoInputStream to photoOutputStream
                                byte[] buffer = new byte[4096];
                                int bytesRead;
                                while ((bytesRead = photoInputStream.read(buffer)) != -1) {
                                    photoOutputStream.write(buffer, 0, bytesRead);
                                }

                                // Copy musicInputStream to musicOutputStream
                                while ((bytesRead = musicInputStream.read(buffer)) != -1) {
                                    musicOutputStream.write(buffer, 0, bytesRead);
                                }
                            }

                            response.sendRedirect("adminDashboardMusic.jsp");
                        } else {
                            response.sendRedirect("adminDashboardMusic.jsp?status=0");
                        }
                    } else {
                        response.sendRedirect("adminDashboardMusic.jsp?status=5"); // music_filetype_error
                    }
                } else {
                    response.sendRedirect("adminDashboardMusic.jsp?status=2"); // photo_filetype_error
                }
            } else {
                response.sendRedirect("adminDashboardMusic.jsp?status=3"); // no_file_uploaded
            }
        } catch (Exception e) {
            // Log the exception details for debugging
            e.printStackTrace();
            response.getWriter().write("An error occurred: " + e.getMessage());
        }
    }
}
