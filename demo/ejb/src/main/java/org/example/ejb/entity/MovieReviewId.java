package org.example.ejb.entity;

import java.io.Serializable;
import java.util.Objects;

public class MovieReviewId implements Serializable {
    private Long movieId;
    private Integer customerId;

    public MovieReviewId() {}
    public MovieReviewId(Long movieId, Integer customerId) {
        this.movieId = movieId;
        this.customerId = customerId;
    }

    public Long getMovieId() { return movieId; }
    public void setMovieId(Long movieId) { this.movieId = movieId; }
    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MovieReviewId that = (MovieReviewId) o;
        return Objects.equals(movieId, that.movieId) && Objects.equals(customerId, that.customerId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(movieId, customerId);
    }
}