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
import Classes.Artist;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.FileOutputStream;

@WebServlet(name = "AddArtistServlet", urlPatterns = {"/addArtist"})
@MultipartConfig
public class AddArtistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("artistname");
            Part photoPart = request.getPart("artistphoto");

            // Check if a file was uploaded
            if (photoPart != null && photoPart.getSize() > 0) {
                String photoFileName = photoPart.getSubmittedFileName();

                if (photoFileName.toLowerCase().endsWith(".jpg") || photoFileName.toLowerCase().endsWith(".png") || photoFileName.toLowerCase().endsWith(".jpeg")) {
                    var uploadDirectory = "/upload/artist"; // Note the leading slash
                    File directory = new File(getServletContext().getRealPath(uploadDirectory));
                    if (!directory.exists()) {
                        directory.mkdirs();
                    }
                    String uniqueFileName = System.currentTimeMillis() + "_" + photoFileName;
                    String photoFilePath = directory.getAbsolutePath() + File.separator + uniqueFileName;

                    Artist artist = new Artist(name, uniqueFileName);
                    if (artist.add(DBconnector.getCon())) {
                        try (InputStream photoInputStream = photoPart.getInputStream(); OutputStream photoOutputStream = new FileOutputStream(photoFilePath)) {

                            // Copy photoInputStream to photoOutputStream
                            byte[] buffer = new byte[4096];
                            int bytesRead;
                            while ((bytesRead = photoInputStream.read(buffer)) != -1) {
                                photoOutputStream.write(buffer, 0, bytesRead);
                            }
                        }
                        response.sendRedirect("adminDashboardArtist.jsp?status=1");
                    } else {
                        response.sendRedirect("adminDashboardArtist.jsp?status=0");
                    }
                } else {
                    response.sendRedirect("adminDashboardArtist.jsp?status=2"); //filetype_error
                }
            } else {
                response.sendRedirect("adminDashboardArtist.jsp?status=3"); //no_file_uploaded

            }
        } catch (Exception e) {
            // Log the exception details for debugging
            e.printStackTrace();
            response.sendRedirect("adminDashboardArtist.jsp?status=4");
            response.getWriter().write("An error occurred: " + e.getMessage());
        }
    }
}
