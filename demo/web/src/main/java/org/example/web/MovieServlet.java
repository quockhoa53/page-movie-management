package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.MovieEJB;
import org.example.ejb.entity.Movie;

import java.io.IOException;
import java.util.List;

@WebServlet("/Movies")
public class MovieServlet extends HttpServlet {
    @EJB
    private MovieEJB MovieService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> Movies = MovieService.getAllMovies();
        request.setAttribute("Movies", Movies);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Movie.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String MovieId = request.getParameter("MovieId");
            if (MovieId == null || MovieId.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Movie ID is required");
                return;
            }

            boolean deleted = MovieService.deleteMovie(Integer.parseInt(MovieId));
            if (deleted) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Movie deleted successfully!");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Movie not found or could not be deleted");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid Movie ID format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Server error: " + e.getMessage());
            e.printStackTrace(); // Log the error
        }
    }
}