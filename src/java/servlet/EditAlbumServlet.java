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
import Classes.Album;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.FileOutputStream;

@WebServlet(name = "EditAlbumServlet", urlPatterns = {"/editAlbum"})
@MultipartConfig
public class EditAlbumServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int album_ID = Integer.parseInt(request.getParameter("album_ID"));
            String albumTitle = request.getParameter("albumTitle");
            String albumdate = request.getParameter("albumdate");
            Part photoPart = request.getPart("albumPhoto");

            Album album = Album.getAlbum(album_ID, DBconnector.getCon());

            if (photoPart != null && photoPart.getSize() > 0) {
                String photoFileName = photoPart.getSubmittedFileName();

                // Delete the old photo if it exists
                if (album.getAlbumPhoto() != null && !album.getAlbumPhoto().isEmpty()) {
                    String uploadDirectory = "/upload/album";
                    File oldPhotoFile = new File(getServletContext().getRealPath(uploadDirectory) + File.separator + album.getAlbumPhoto());
                    if (oldPhotoFile.exists()) {
                        oldPhotoFile.delete();
                    }
                }

                // Update album with new photo
                album.setAlbumPhoto(photoFileName);

                // Save the new photo file
                String uploadDirectory = "/upload/album";
                File directory = new File(getServletContext().getRealPath(uploadDirectory));
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                String uniqueFileName = System.currentTimeMillis() + "_" + photoFileName;
                String photoFilePath = directory.getAbsolutePath() + File.separator + uniqueFileName;

                try (InputStream photoInputStream = photoPart.getInputStream();
                     OutputStream photoOutputStream = new FileOutputStream(photoFilePath)) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = photoInputStream.read(buffer)) != -1) {
                        photoOutputStream.write(buffer, 0, bytesRead);
                    }
                }

                // Update album in the database
                album.update(album_ID, albumTitle, albumdate, uniqueFileName, DBconnector.getCon());
            } else {
                // Update album in the database without changing the photo
                album.update(album_ID, albumTitle, albumdate, album.getAlbumPhoto(), DBconnector.getCon());
            }

            response.sendRedirect("adminDashboardAlbum.jsp?status=1"); // Success
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboardAlbum.jsp?status=4"); // Error
        }
    }
}
