package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class Application {

    @GetMapping("/hello")
    public String hello() {
        return "Hello from Java 21 Spring Boot!";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
