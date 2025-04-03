package org.example.ejb.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "movie_role")
@IdClass(MovieRoleId.class)
public class MovieRole {
    @Id
    @Column(name = "movie_id")
    private Long movieId;

    @Id
    @Column(name = "actor_id")
    private Long actorId;

    @ManyToOne
    @JoinColumn(name = "movie_id", referencedColumnName = "movie_id", insertable = false, updatable = false)
    private Movie movie;

    @ManyToOne
    @JoinColumn(name = "actor_id", referencedColumnName = "actor_id", insertable = false, updatable = false)
    private Actor actor;

    @Column(name = "role_name")
    private String roleName;

    // Getters và Setters
    public Long getMovieId() { return movieId; }
    public void setMovieId(Long movieId) { this.movieId = movieId; }
    public Long getActorId() { return actorId; }
    public void setActorId(Long actorId) { this.actorId = actorId; }
    public Movie getMovie() { return movie; }
    public void setMovie(Movie movie) { this.movie = movie; }
    public Actor getActor() { return actor; }
    public void setActor(Actor actor) { this.actor = actor; }
    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}
