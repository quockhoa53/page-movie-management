package com.example.moviemanagement.REST;

import com.example.moviemanagement.ejb.MovieBean;
import com.example.moviemanagement.model.Movie;
import jakarta.ejb.EJB;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/movies")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class MovieResource {

    @EJB
    private MovieBean movieBean;

    @GET
    public List<Movie> getAllMovies() {
        return movieBean.getAllMovies();
    }

    @GET
    @Path("/{id}")
    public Response getMovie(@PathParam("id") int id) {
        Movie movie = movieBean.getMovie(id);
        return movie != null ? Response.ok(movie).build() : Response.status(Response.Status.NOT_FOUND).build();
    }

    @POST
    public Response addMovie(Movie movie) {
        movieBean.addMovie(movie);
        return Response.status(Response.Status.CREATED).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateMovie(@PathParam("id") int id, Movie movie) {
        Movie existingMovie = movieBean.getMovie(id);
        if (existingMovie == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        movie.setMovieId(id);
        movieBean.updateMovie(movie);
        return Response.ok().build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteMovie(@PathParam("id") int id) {
        movieBean.deleteMovie(id);
        return Response.ok().build();
    }
}
