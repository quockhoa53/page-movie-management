package org.example.ejb.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "movie_review")
@IdClass(MovieReviewId.class)
public class MovieReview {
    @Id
    @Column(name = "movie_id")
    private Long movieId;

    @Id
    @Column(name = "customer_id")
    private Integer customerId;

    @ManyToOne
    @JoinColumn(name = "movie_id", referencedColumnName = "movie_id", insertable = false, updatable = false)
    private Movie movie;

    @ManyToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "customer_id", insertable = false, updatable = false)
    private Customer customer;

    @Column(name = "score")
    private Float score;

    @Column(name = "review_date")
    private Date reviewDate;

    // Getters và Setters
    public Long getMovieId() { return movieId; }
    public void setMovieId(Long movieId) { this.movieId = movieId; }
    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public Movie getMovie() { return movie; }
    public void setMovie(Movie movie) { this.movie = movie; }
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    public Float getScore() { return score; }
    public void setScore(Float score) { this.score = score; }
    public Date getReviewDate() { return reviewDate; }
    public void setReviewDate(Date reviewDate) { this.reviewDate = reviewDate; }
}