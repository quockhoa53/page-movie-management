package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.DirectorEJB;
import org.example.ejb.entity.Director;

import java.io.IOException;
import java.util.List;

@WebServlet("/directors")
public class DirectorServlet extends HttpServlet {
    @EJB
    private DirectorEJB directorService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Director> directors = directorService.getAllDirectors();
        System.out.println("Directors list: " + directors);
        request.setAttribute("directors", directors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("director.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("add".equals(action)) {
                String name = request.getParameter("directorName");

                if (name == null || name.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Director name is required");
                    return;
                }

                Director newDirector = new Director();
                newDirector.setDirectorName(name);

                directorService.addDirector(newDirector);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Director added successfully!");

            } else if ("delete".equals(action)) {
                String directorId = request.getParameter("directorId");

                if (directorId == null || directorId.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Director ID is required");
                    return;
                }

                boolean deleted = directorService.deleteDirector(Integer.parseInt(directorId));
                if (deleted) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Director deleted successfully!");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Director not found or could not be deleted");
                }
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid director ID format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
