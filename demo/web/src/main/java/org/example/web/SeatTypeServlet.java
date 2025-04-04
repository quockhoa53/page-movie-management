package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.SeatTypeEJB;
import org.example.ejb.entity.SeatType;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/typeseats")
public class SeatTypeServlet extends HttpServlet {

    @EJB
    private SeatTypeEJB seatTypeEJB;

    // Display all SeatTypes
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<SeatType> seatTypes = seatTypeEJB.getAllSeatTypes();
        request.setAttribute("seatTypes", seatTypes);
        request.getRequestDispatcher("/typeseat.jsp").forward(request, response);
    }

    // Add a new SeatType
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");

        if (method != null && method.equals("delete")) {
            doDelete(request, response);
        } else if (method != null && method.equals("update")) {
            doPut(request, response);
        } else {
            // Xử lý doPost thông thường
            String typeName = request.getParameter("seatTypeName");
            String priceStr = request.getParameter("seatTypePrice");

            // Kiểm tra nếu giá trị null hoặc rỗng thì gán giá trị mặc định
            if (priceStr == null || priceStr.trim().isEmpty()) {
                request.setAttribute("error", "Price cannot be empty");
                request.getRequestDispatcher("/typeseat.jsp").forward(request, response);
                return;
            }

            BigDecimal price = new BigDecimal(priceStr);

            // Tạo đối tượng SeatType mới
            SeatType newSeatType = new SeatType();
            newSeatType.setTypeName(typeName);
            newSeatType.setPrice(price);

            // Gọi EJB để tạo SeatType mới
            seatTypeEJB.createSeatType(newSeatType);

            // Chuyển hướng về danh sách SeatType
            response.sendRedirect("seatTypes");
        }
    }

    // Update an existing SeatType
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seatTypeIdStr = request.getParameter("seatTypeId");
        Integer seatTypeId = Integer.parseInt(seatTypeIdStr);
        String typeName = request.getParameter("seatTypeName");
        String priceStr = request.getParameter("seatTypePrice");
        BigDecimal price = new BigDecimal(priceStr);

        SeatType seatType = seatTypeEJB.findSeatTypeById(seatTypeId);
        if (seatType != null) {
            seatType.setTypeName(typeName);
            seatType.setPrice(price);
            seatTypeEJB.updateSeatType(seatType);
        }

        response.sendRedirect("seatTypes");
    }


    // Delete a SeatType
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seatTypeIdStr = request.getParameter("seatTypeId");
        Integer seatTypeId = Integer.parseInt(seatTypeIdStr);

        seatTypeEJB.deleteSeatType(seatTypeId);

        response.sendRedirect("seatTypes");
    }
}
