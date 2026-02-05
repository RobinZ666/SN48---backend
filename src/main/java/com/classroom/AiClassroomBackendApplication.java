package com.classroom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class AiClassroomBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(AiClassroomBackendApplication.class, args);
    }
}
