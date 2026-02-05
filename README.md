# AI Classroom Backend

基于 Spring Boot 3.x 的课堂管理系统后端服务，提供用户认证功能。

## 技术栈

- Java 17
- Spring Boot 3.2.2
- Spring Security
- Spring Data JPA
- PostgreSQL 15
- JWT (JJWT 0.12.5)
- Maven

## 项目结构

```
ai-classroom-backend/
├── docker-compose.yml          # PostgreSQL 容器配置
├── pom.xml                     # Maven 配置
├── README.md
└── src/main/
    ├── java/com/classroom/
    │   ├── AiClassroomBackendApplication.java
    │   ├── config/
    │   │   └── SecurityConfig.java
    │   ├── controller/
    │   │   └── AuthController.java
    │   ├── dto/
    │   │   ├── AuthResponse.java
    │   │   ├── LoginRequest.java
    │   │   ├── MeResponse.java
    │   │   └── RegisterRequest.java
    │   ├── entity/
    │   │   ├── Role.java
    │   │   └── User.java
    │   ├── exception/
    │   │   ├── ErrorResponse.java
    │   │   └── GlobalExceptionHandler.java
    │   ├── repository/
    │   │   └── UserRepository.java
    │   ├── security/
    │   │   ├── CustomUserDetailsService.java
    │   │   ├── JwtAuthenticationFilter.java
    │   │   └── JwtTokenProvider.java
    │   └── service/
    │       ├── AuthService.java
    │       └── UserService.java
    └── resources/
        ├── application.yml
        └── schema.sql
```

## 启动步骤

### 1. 环境要求

- Java 17+
- Maven 3.6+
- PostgreSQL 15+
- Docker (推荐用于数据库)

### 2. 启动 PostgreSQL 数据库

```bash
# 进入项目目录
cd ai-classroom-backend

# 启动 PostgreSQL 容器
docker-compose up -d
```

数据库配置：
- Host: localhost
- Port: 5432
- Database: ai_classroom
- Username: classroom_user
- Password: classroom_pass

### 2. 配置 JWT Secret（可选）

默认已配置测试用的 JWT Secret，生产环境请设置环境变量：

```bash
# Windows PowerShell
$env:JWT_SECRET="your-production-secret-key-at-least-32-characters"

# Linux/Mac
export JWT_SECRET="your-production-secret-key-at-least-32-characters"
```

### 3. 启动应用

#### 方法一：使用批处理脚本（Windows）

```bash
# 直接运行批处理脚本
run-app.bat
```

#### 方法二：手动启动

```bash
# 使用 Maven 启动
./mvnw spring-boot:run

# 或 Windows 上使用
mvnw.cmd spring-boot:run

# 或直接使用 Maven
mvn spring-boot:run
```

应用将在 http://localhost:8080 启动。

## API 接口

### 1. 用户注册

```bash
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "张三",
    "email": "zhangsan@example.com",
    "password": "password123",
    "role": "STUDENT"
  }'
```

响应示例：
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiJ9...",
  "tokenType": "Bearer"
}
```

### 2. 用户登录

```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "zhangsan@example.com",
    "password": "password123"
  }'
```

响应示例：
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiJ9...",
  "tokenType": "Bearer"
}
```

### 3. 获取当前用户信息

```bash
curl -X GET http://localhost:8080/auth/me \
  -H "Authorization: Bearer <your_access_token>"
```

响应示例：
```json
{
  "id": 1,
  "name": "张三",
  "email": "zhangsan@example.com",
  "role": "STUDENT"
}
```

## 错误响应

### 重复邮箱注册

```json
{
  "status": 400,
  "error": "Bad Request",
  "message": "Email already exists: zhangsan@example.com"
}
```

### 登录凭证错误

```json
{
  "status": 401,
  "error": "Unauthorized",
  "message": "Invalid email or password"
}
```

### Token 无效或未提供

```json
{
  "status": 403,
  "error": "Forbidden",
  "message": "Access Denied"
}
```

## 角色说明

系统支持两种角色：
- `STUDENT` - 学生
- `PROFESSOR` - 教授

## 停止服务

```bash
# 停止 PostgreSQL 容器
docker-compose down

# 如需删除数据卷
docker-compose down -v
```
