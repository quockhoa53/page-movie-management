package com.example.moviemanagement.ejb;

import com.example.moviemanagement.model.Movie;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;


@Stateless
public class MovieBean {

    @PersistenceContext(unitName = "cinema")
    private EntityManager entityManager;

    public void addMovie(Movie movie) {
        entityManager.persist(movie);
    }

    public void updateMovie(Movie movie) {
        entityManager.merge(movie);
    }

    public void deleteMovie(int movieId) {
        Movie movie = entityManager.find(Movie.class, movieId);
        if (movie != null) {
            entityManager.remove(movie);
        }
    }

    public Movie getMovie(int movieId) {
        return entityManager.find(Movie.class, movieId);
    }

    public List<Movie> getAllMovies() {
        return entityManager.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
    }
}
