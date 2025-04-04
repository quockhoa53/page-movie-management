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
        return em.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
    }

    public List<Movie> searchMoviesByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return List.of();
        }
        return em.createQuery("SELECT m FROM Movie m WHERE LOWER(m.movieName) LIKE LOWER(:name)", Movie.class)
                .setParameter("name", "%" + name.trim() + "%")
                .getResultList();
    }

    public void addMovie(Movie movie) {
        em.persist(movie);
    }

    public void updateMovie(Movie movie) {
        em.merge(movie);
    }

    public void deleteMovie(int movieId) {
        Movie movie = em.find(Movie.class, movieId);
        if (movie != null) {
            em.remove(movie);
        }
    }
    public Movie getMovieById(int movieId) {
        return em.find(Movie.class, movieId);
    }
}
