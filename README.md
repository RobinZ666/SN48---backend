# AI Classroom Backend

This repository contains the backend service for the **AI Classroom Web Application**.

The backend is built with Spring Boot and provides core infrastructure such as user authentication, role-based access control, and database persistence.

It is designed to be extensible for future modules including:

- Courses and enrollments
- PDF document management
- Learning behavior tracking
- AI-powered learning evaluation and question generation

------

## Tech Stack

- **Java** 17
- **Spring Boot** 3.2.2
- **Spring Security**
- **Spring Data JPA (****Hibernate****)**
- **PostgreSQL** 15
- **JWT** (JJWT 0.12.5)
- **Maven**

------

## Getting Started

### 1. Prerequisites

Make sure the following are installed on your local machine:

- Java 17
- Maven 3.6+
- PostgreSQL 15+

------

### 2. Database Setup (PostgreSQL)

The application uses PostgreSQL as its primary database.

Configure your database connection in `application.yml`:

```plain
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/ai_classroom
    username: <your_db_username>
    password: <your_db_password>
    driver-class-name: org.postgresql.Driver
```

**Notes**

- You do **not** need to create database tables manually.
- When the application starts successfully, **Flyway** will automatically initialize the database schema and create the required tables.

------

### Run the Application

From the project root directory, run:

`mvn spring-boot:run`

The application will start on the default port:

`http://localhost:8080`

------

## Authentication

The backend uses **JWT-based authentication**.

- Tokens are issued upon successful login.
- The token must be included in subsequent requests using the HTTP header below:

`Authorization: Bearer <access_token>`

### Supported Roles

The system currently supports two user roles:

- `STUDENT`
- `PROFESSOR`