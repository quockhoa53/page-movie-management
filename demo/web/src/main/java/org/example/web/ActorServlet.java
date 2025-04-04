package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.ActorEJB;
import org.example.ejb.entity.Actor;

import java.io.IOException;
import java.util.List;

@WebServlet("/actors")
public class ActorServlet extends HttpServlet {
    @EJB
    private ActorEJB actorService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Actor> actors = actorService.getAllActors();
        request.setAttribute("actors", actors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("actor.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("add".equals(action)) {
                String name = request.getParameter("actorName");

                if (name == null || name.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Actor name is required");
                    return;
                }

                Actor newActor = new Actor();
                newActor.setActorName(name);

                actorService.addActor(newActor);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Actor added successfully!");

            } else if ("delete".equals(action)) {
                String actorId = request.getParameter("actorId");

                if (actorId == null || actorId.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Actor ID is required");
                    return;
                }

                boolean deleted = actorService.deleteActor(Integer.parseInt(actorId));
                if (deleted) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Actor deleted successfully!");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Actor not found or could not be deleted");
                }
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid actor ID format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}