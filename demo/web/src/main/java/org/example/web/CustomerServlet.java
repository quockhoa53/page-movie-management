package org.example.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.xml.bind.SchemaOutputResolver;

import org.example.ejb.CustomerEJB;
import org.example.ejb.entity.Customer;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    @EJB
    private CustomerEJB customerService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println(action);
        if ("findUser".equals(action)) {
            String customerIdParam = request.getParameter("customerId");
            System.out.println(customerIdParam);
            if (customerIdParam != null) {
                try {
                    int customerId = Integer.parseInt(customerIdParam);
                    Customer customer = customerService.getCustomerById(customerId);

                    if (customer != null) {
                        String jsonResponse = String.format("{\"customerId\": %d, \"customerName\": \"%s\", \"email\": \"%s\", \"phone\": \"%s\", \"birthDate\": \"%s\", \"address\": \"%s\", \"gender\": %b, \"avatar\": \"%s\"}",
                                customer.getCustomerId(), customer.getCustomerName(), customer.getEmail(), customer.getPhone(),
                                new SimpleDateFormat("yyyy-MM-dd").format(customer.getBirthDate()), customer.getAddress(),
                                (customer.getGender() ? "male" : "female"), customer.getAvatar());

                        System.out.println("JSON Response: " + jsonResponse);
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(jsonResponse);

                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        response.getWriter().write("{\"error\": \"Không tìm thấy khách hàng.\"}");
                    }
                } catch (NumberFormatException e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\": \"ID khách hàng không hợp lệ.\"}");
                }
            } else {
                List<Customer> customers = customerService.getAllCustomers();
                request.setAttribute("customers", customers);
                RequestDispatcher dispatcher = request.getRequestDispatcher("customers.jsp");
                dispatcher.forward(request, response);
            }
        }
        else{
                List<Customer> customers = customerService.getAllCustomers();
                request.setAttribute("customers", customers);
                RequestDispatcher dispatcher = request.getRequestDispatcher("customer.jsp");
                dispatcher.forward(request, response);
            }
        }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("add".equals(action)) {
                String name = request.getParameter("customerName");
                String email = request.getParameter("customerEmail");
                String phone = request.getParameter("customerPhone");
                System.out.println(request.getParameter("birthDate"));
                String birthDate = request.getParameter("birthDate");
                String address = request.getParameter("customerAddress");
                String genderStr = request.getParameter("gender"); // Giá trị từ combobox
                String avatar = request.getParameter("avatar");
                System.out.println(name+ email+ phone+ birthDate+ address+ genderStr);

                // Kiểm tra dữ liệu nhập vào
                if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() ||
                        phone == null || phone.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Customer name, email and phone numbers are required");
                    return;
                }

                // Chuyển đổi giới tính từ String sang Boolean (0 = Nữ, 1 = Nam)
                Boolean gender = "1".equals(genderStr);

                // Tạo đối tượng Customer và gán giá trị
                Customer newCustomer = new Customer();
                newCustomer.setCustomerName(name);
                newCustomer.setEmail(email);
                newCustomer.setPhone(phone);
                newCustomer.setBirthDate(java.sql.Date.valueOf(birthDate)); // Chuyển đổi từ String sang Date
                newCustomer.setAddress(address);
                newCustomer.setGender(gender); // Set giới tính
                newCustomer.setAvatar(avatar);

                // Thêm khách hàng vào database
                customerService.addCustomer(newCustomer);

                // Phản hồi cho client
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Customer added successfully!");
            } else if ("delete".equals(action)) {
                String customerId = request.getParameter("customerId");

                if (customerId == null || customerId.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Customer ID is required");
                    return;
                }

                boolean deleted = customerService.deleteCustomer(Integer.parseInt(customerId));
                if (deleted) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Customer deleted successfully!");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Customer not found or could not be deleted");
                }

            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid customer ID format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerId = request.getParameter("customerId");
        System.out.println("id:" + customerId);

        // Đọc JSON từ body request
        StringBuilder stringBuilder = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            stringBuilder.append(line);
        }

        String jsonData = stringBuilder.toString();
        System.out.println("Received JSON: " + jsonData);

        // Parse JSON (Bạn có thể sử dụng thư viện như Jackson hoặc Gson để xử lý JSON)
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> data = objectMapper.readValue(jsonData, Map.class);

        String name = data.get("customerName");
        String email = data.get("customerEmail");
        String phone = data.get("customerPhone");
        String birthDateStr = data.get("birthDate");
        String address = data.get("customerAddress");
        String genderStr = data.get("gender");
        String avatar = data.get("avatar");
            System.out.println(name + email + phone + birthDateStr + address + genderStr);


            // Kiểm tra dữ liệu hợp lệ
            if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() ||
                    phone == null || phone.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Customer name, email, and phone number are required");
                return;
            }

            // Tìm khách hàng trong database
            Customer existingCustomer = customerService.getCustomerById(Integer.valueOf(customerId));
            if (existingCustomer == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Customer not found");
                return;
            }

            // Cập nhật thông tin khách hàng
            existingCustomer.setCustomerName(name);
            existingCustomer.setEmail(email);
            existingCustomer.setPhone(phone);
            if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
                existingCustomer.setBirthDate(java.sql.Date.valueOf(birthDateStr));
            }
            existingCustomer.setAddress(address);
            existingCustomer.setGender("1".equals(genderStr)); // Chuyển đổi từ String sang Boolean
            existingCustomer.setAvatar(avatar);

            // Lưu thay đổi vào database
            customerService.updateCustomer(existingCustomer);

            // Phản hồi thành công
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Customer updated successfully!");

    }



}
