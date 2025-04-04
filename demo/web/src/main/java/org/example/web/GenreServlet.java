package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.GenreEJB;
import org.example.ejb.entity.Genre;

import java.io.IOException;
import java.util.List;

@WebServlet("/genres")
public class GenreServlet extends HttpServlet {
    @EJB
    private GenreEJB genreService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Genre> genres = genreService.getAllGenres();
        request.setAttribute("genres", genres);
        RequestDispatcher dispatcher = request.getRequestDispatcher("genre.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");

        try {
            String action = request.getParameter("action");

            if ("add".equals(action)) {
                String genreName = request.getParameter("genreName");
                if (genreName == null || genreName.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Genre name is required");
                    return;
                }

                try {
                    genreService.addGenre(genreName);
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Genre added successfully!");
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to add genre: " + e.getMessage());
                }

            } else if ("edit".equals(action)) {
                String genreId = request.getParameter("genreId");
                String genreName = request.getParameter("genreName");
                if (genreId == null || genreName == null) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Genre ID and name are required");
                    return;
                }
                boolean updated = genreService.updateGenre(Integer.parseInt(genreId), genreName);
                if (updated) {
                    response.getWriter().write("Genre updated successfully!");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Genre not found");
                }

            } else {
                String genreId = request.getParameter("genreId");
                if (genreId == null || genreId.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Genre ID is required");
                    return;
                }
                boolean deleted = genreService.deleteGenre(Integer.parseInt(genreId));
                if (deleted) {
                    response.getWriter().write("Genre deleted successfully!");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Genre not found");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}