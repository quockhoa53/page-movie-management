package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.TicketEJB;
import org.example.ejb.entity.Ticket;

import java.io.IOException;
import java.util.List;

@WebServlet("/tickets")
public class TicketServlet extends HttpServlet {
    @EJB
    private TicketEJB ticketService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Ticket> tickets = ticketService.getAllTickets();
        request.setAttribute("tickets", tickets);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ticket.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String ticketId = request.getParameter("ticketId");
            if (ticketId == null || ticketId.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Ticket ID is required");
                return;
            }

            boolean deleted = ticketService.deleteTicket(Integer.parseInt(ticketId));
            if (deleted) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Ticket deleted successfully!");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Ticket not found or could not be deleted");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid ticket ID format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Server error: " + e.getMessage());
            e.printStackTrace(); // Log the error
        }
    }
}