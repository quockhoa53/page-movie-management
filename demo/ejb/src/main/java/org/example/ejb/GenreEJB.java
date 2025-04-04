package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.Genre;

import java.util.List;
import java.util.logging.Logger;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class GenreEJB {
    private static final Logger LOGGER = Logger.getLogger(GenreEJB.class.getName());

    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    public List<Genre> getAllGenres() {
        try {
            return em.createQuery("SELECT g FROM Genre g", Genre.class).getResultList();
        } catch (Exception e) {
            LOGGER.severe("Error getting all genres: " + e.getMessage());
            throw e;
        }
    }

    public boolean deleteGenre(int genreId) {
        try {
            Genre genre = em.find(Genre.class, genreId);
            if (genre != null) {
                em.remove(genre);
                return true;
            }
            return false;
        } catch (Exception e) {
            LOGGER.severe("Error deleting genre: " + e.getMessage());
            throw e;
        }
    }

    public Genre getGenreById(Integer genreId) {
        try {
            return em.find(Genre.class, genreId);
        } catch (Exception e) {
            LOGGER.severe("Error getting genre by id: " + e.getMessage());
            throw e;
        }
    }

    public Genre addGenre(String genreName) {
        try {
            if (genreName == null || genreName.trim().isEmpty()) {
                throw new IllegalArgumentException("Genre name cannot be null or empty");
            }

            Genre genre = new Genre();
            genre.setGenreName(genreName.trim());
            em.persist(genre);
            em.flush(); // Force the persist to database
            LOGGER.info("Genre added successfully: " + genreName);
            return genre;
        } catch (Exception e) {
            LOGGER.severe("Error adding genre: " + e.getMessage());
            throw e;
        }
    }

    public boolean updateGenre(int genreId, String genreName) {
        try {
            Genre genre = em.find(Genre.class, genreId);
            if (genre != null) {
                genre.setGenreName(genreName);
                em.merge(genre);
                return true;
            }
            return false;
        } catch (Exception e) {
            LOGGER.severe("Error updating genre: " + e.getMessage());
            throw e;
        }
    }
}