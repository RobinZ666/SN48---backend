1. ## User Registration

### Endpoint

- Method: `POST`
- URL: `/auth/register`
- Authentication: **Not required**

### Request Body

json

```
{  
    "name": "Alice",  
    "email": "alice@example.com",  
    "password": "123456",  
    "role": "STUDENT"
}
```

FieldTypeRequiredDescriptionValidationnamestringYesUser's nameLength between 2 and 100 charactersemailstringYesEmail (used as login username)Must be a valid email formatpasswordstringYesLogin passwordLength between 6 and 100 charactersrolestringYesUser roleMust be STUDENT or PROFESSOR (case-insensitive, normalized to upper case on backend). Invalid values cause an error.

> Note: If `role` is invalid, the backend returns an error:`Invalid role. Must be STUDENT or PROFESSOR`.

### Success Response (201 Created)

json

```
{  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",  "tokenType": "Bearer"}
```

FieldTypeDescriptionaccessTokenstringJWT access tokentokenTypestringAlways "Bearer"

After successful registration, the user is effectively “logged in” because an access token is returned. The frontend can directly use this token for subsequent authenticated requests.

#### Possible Error Responses

- `400 Bad Request`: Validation errors (e.g., invalid email format, password too short, missing fields).
- `409 Conflict`: Email already exists (depending on business logic in `UserService`).

------

1. ## User Login

### Endpoint

- Method: `POST`
- URL: `/auth/login`
- Authentication: **Not required**

### Request Body

```
{  
    "email": "alice@example.com",  
    "password": "123456"
}
```

FieldTypeRequiredDescriptionValidationemailstringYesEmail accountMust be a valid emailpasswordstringYesLogin passwordMust not be blank

### Success Response (200 OK)

json

```
{  
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",  
    "tokenType": "Bearer"
}
```

Same structure as the registration response.

### Possible Error Responses

- `400 Bad Request`: Request body validation errors (missing/invalid fields).
- `401 Unauthorized`: Invalid email or password.
    - Backend message: `"Invalid email or password"`.

------

1. ## Get Current User Information

### Endpoint

- Method: `GET`
- URL: `/auth/me`
- Authentication: **Required**

### Request Headers

http

```
Authorization: Bearer <accessToken>
```

There must be a space between `Bearer` and `<accessToken>`.

### Request Body

- None

### Success Response (200 OK)

json

```
{  
    "id": 1,  
    "name": "Alice",  
    "email": "alice@example.com",  
    "role": "STUDENT"
}
```

FieldTypeDescriptionidnumberUser IDnamestringUser's nameemailstringUser's emailrolestringUser role: STUDENT or PROFESSOR

### Possible Error Responses

- `401 Unauthorized`:
    - Missing `Authorization` header.
    - Invalid or expired token.
- `404 Not Found`:
    - Edge case: token contains an email that no longer exists in the database.