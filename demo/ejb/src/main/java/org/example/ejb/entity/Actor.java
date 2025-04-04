package org.example.ejb.entity;

import jakarta.persistence.*;

import java.util.Set;

@Entity
@Table(name = "actor")
public class Actor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "actor_id")
    private Integer actorId;

    @Column(name = "actor_name")
    private String actorName;

    @Column(name = "actor_image")
    private String actorImage;

    @OneToMany(mappedBy = "actor", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<MovieRole> movieRoles;

    // Getters and Setters
    public Integer getActorId() {
        return actorId;
    }

    public void setActorId(Integer actorId) {
        this.actorId = actorId;
    }

    public String getActorName() {
        return actorName;
    }

    public void setActorName(String actorName) {
        this.actorName = actorName;
    }

    public String getActorImage() {
        return actorImage;
    }

    public void setActorImage(String actorImage) {
        this.actorImage = actorImage;
    }

    public Set<MovieRole> getMovieRoles() {
        return movieRoles;
    }

    public void setMovieRoles(Set<MovieRole> movieRoles) {
        this.movieRoles = movieRoles;
    }
}

