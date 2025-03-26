package org.example.web;

import org.example.ejb.MyEJB;
import org.example.ejb.entity.Movie;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/movies")
public class MyServlet extends HttpServlet {
    @EJB
    private MyEJB myEJB;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String searchQuery = req.getParameter("search");

        // Handle search or display all movies
        List<Movie> movies;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            movies = myEJB.searchMoviesByName(searchQuery);
        } else {
            movies = myEJB.getAllMovies();
        }

        if (action == null) {
            req.setAttribute("movies", movies);
            req.setAttribute("searchQuery", searchQuery);
            req.getRequestDispatcher("/movies.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int movieId = Integer.parseInt(req.getParameter("id"));
            Movie movie = myEJB.getMovieById(movieId);
            req.setAttribute("movie", movie);
            req.getRequestDispatcher("/editMovie.jsp").forward(req, resp);
        } else if (action.equals("delete")) {
            int movieId = Integer.parseInt(req.getParameter("id"));
            myEJB.deleteMovie(movieId);
            resp.sendRedirect("movies");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        Movie movie = new Movie();
        movie.setMovieName(req.getParameter("movieName"));
        movie.setCountryOfProduction(req.getParameter("country"));
        movie.setDescription(req.getParameter("description"));
        movie.setDuration(Integer.parseInt(req.getParameter("duration")));
        movie.setReleaseDate(LocalDateTime.parse(req.getParameter("releaseDate"), DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")));
        movie.setStatus(Integer.parseInt(req.getParameter("status")));

        if (action.equals("add")) {
            myEJB.addMovie(movie);
        } else if (action.equals("update")) {
            movie.setMovieId(Integer.parseInt(req.getParameter("movieId")));
            myEJB.updateMovie(movie);
        }
        resp.sendRedirect("movies");
    }
}