package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.Customer;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class CustomerEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    // Lấy tất cả khách hàng
    public List<Customer> getAllCustomers() {
        return em.createQuery("SELECT c FROM Customer c", Customer.class).getResultList();
    }

    // Xóa khách hàng theo ID
    public boolean deleteCustomer(int customerId) {
        Customer customer = em.find(Customer.class, customerId);
        if (customer != null) {
            em.remove(customer);
            return true;
        }
        return false;
    }

    // Lấy khách hàng theo ID
    public Customer getCustomerById(Integer customerId) {
        return em.find(Customer.class, customerId);
    }

    // Thêm khách hàng mới
    public void addCustomer(Customer customer) {
        em.persist(customer);
    }
    public void updateCustomer(Customer customer) {
        em.merge(customer);
    }

}