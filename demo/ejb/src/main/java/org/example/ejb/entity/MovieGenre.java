package org.example.ejb.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "movie_genre")
@IdClass(MovieGenreId.class)
public class MovieGenre {
    @Id
    @Column(name = "movie_id")
    private Long movieId;

    @Id
    @Column(name = "genre_id")
    private Integer genreId;

    @ManyToOne
    @JoinColumn(name = "movie_id", referencedColumnName = "movie_id", insertable = false, updatable = false)
    private Movie movie;

    @ManyToOne
    @JoinColumn(name = "genre_id", referencedColumnName = "genre_id", insertable = false, updatable = false)
    private Genre genre;

    // Getters và Setters
    public Long getMovieId() { return movieId; }
    public void setMovieId(Long movieId) { this.movieId = movieId; }
    public Integer getGenreId() { return genreId; }
    public void setGenreId(Integer genreId) { this.genreId = genreId; }
    public Movie getMovie() { return movie; }
    public void setMovie(Movie movie) { this.movie = movie; }
    public Genre getGenre() { return genre; }
    public void setGenre(Genre genre) { this.genre = genre; }
}