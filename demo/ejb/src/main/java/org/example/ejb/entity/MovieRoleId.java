package org.example.ejb.entity;

import java.io.Serializable;
import java.util.Objects;

public class MovieRoleId implements Serializable {
    private Long movieId; // Giả sử movie_id là Long
    private Long actorId; // Giả sử actor_id là Long

    // Constructors
    public MovieRoleId() {}
    public MovieRoleId(Long movieId, Long actorId) {
        this.movieId = movieId;
        this.actorId = actorId;
    }

    // Getters và Setters
    public Long getMovieId() { return movieId; }
    public void setMovieId(Long movieId) { this.movieId = movieId; }
    public Long getActorId() { return actorId; }
    public void setActorId(Long actorId) { this.actorId = actorId; }

    // Equals và HashCode (bắt buộc cho IdClass)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MovieRoleId that = (MovieRoleId) o;
        return Objects.equals(movieId, that.movieId) && Objects.equals(actorId, that.actorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(movieId, actorId);
    }
}
