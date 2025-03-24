package com.example.moviemanagement;

import jakarta.ejb.Stateless;

@Stateless
public class HelloBean {
    public String sayHello() {
        return "Hello, EJB running on TomEE!";
    }
}
