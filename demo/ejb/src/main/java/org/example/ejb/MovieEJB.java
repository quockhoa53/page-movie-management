package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.Movie;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class MovieEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    public List<Movie> getAllMovies() {
        List<Movie> Movies = em.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
        System.out.println("Movies found: " + Movies.size());
        return Movies;
    }

    public boolean deleteMovie(int MovieId) {
        Movie Movie = em.find(Movie.class, MovieId);
        if (Movie != null) {
            em.remove(Movie);
            return true;
        }
        return false;
    }

    public Movie getMovieById(Integer MovieId) {
        return em.find(Movie.class, MovieId);
    }
}
