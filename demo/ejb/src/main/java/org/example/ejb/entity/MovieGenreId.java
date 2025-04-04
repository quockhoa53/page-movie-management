package org.example.ejb.entity;

import java.io.Serializable;
import java.util.Objects;

public class MovieGenreId implements Serializable {
    private Long movieId; // Giả sử movie_id là Long
    private Integer genreId; // Khớp với kiểu Integer của genre_id trong Genre

    // Constructors
    public MovieGenreId() {}
    public MovieGenreId(Long movieId, Integer genreId) {
        this.movieId = movieId;
        this.genreId = genreId;
    }

    // Getters và Setters
    public Long getMovieId() { return movieId; }
    public void setMovieId(Long movieId) { this.movieId = movieId; }
    public Integer getGenreId() { return genreId; }
    public void setGenreId(Integer genreId) { this.genreId = genreId; }

    // Equals và HashCode (bắt buộc cho IdClass)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MovieGenreId that = (MovieGenreId) o;
        return Objects.equals(movieId, that.movieId) && Objects.equals(genreId, that.genreId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(movieId, genreId);
    }
}
