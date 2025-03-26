package org.example.ejb;

import org.example.ejb.entity.Movie;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import jakarta.persistence.Query;

@Stateless
public class MyEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    public List<Movie> getAllMovies() {
        return em.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
    }
    public List<Movie> searchMoviesByName(String name) {
        Query query = em.createQuery("SELECT m FROM Movie m WHERE LOWER(m.movieName) LIKE LOWER(:name)", Movie.class);
        query.setParameter("name", "%" + name + "%");
        return query.getResultList();
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