## Authentication

### Google OAuth Authentication

### Step 1: Redirect to Google for Authentication

**Endpoint:**

```sh
GET /auth/google
```

**Description:**
Redirects the user to Google for authentication.

**Example Request:**

```sh
GET https://api.notyapp.com/auth/google
```

### Step 2: Handle Google OAuth Callback

**Endpoint:**

```sh
GET /auth/google/callback
```

**Description:**
Handles the callback from Google after user authentication and logs in the user.

**Example Request:**

```sh
GET https://api.notyapp.com/auth/google/callback?code=AUTH_CODE
```

**Response:**

```json
{
  "message": "Login successful",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "avatar": "https://example.com/avatar.jpg",
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:34:56Z",
    "last_login": null}
}
```

## Notes

### Create a New Note

**Endpoint:**

```bash
POST /notes
```

**Description:**
Creates a new note for the authenticated user.

**Request Headers:**

```bash
Content-Type: application/json
```

**Request Body:**

```json
{
  "title": "My Note",
  "content": "This is the content of my note.",
  "collection_id": 1
}
```

**Example Request:**

```sh
POST https://api.notyapp.com/notes
```

**Response:**

```json
{
  "message": "Note created successfully",
  "note": {
    "id": 1,
    "title": "My Note",
    "content": "This is the content of my note.",
    "status": null,
    "collection_id": 1,
    "account_id": 1,
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:34:56Z"
  }
}
```

### Retrieve All Notes

**Endpoint:**

```sh
GET /notes
```

**Description:**
Retrieves all notes for the authenticated user.

**Example Request:**

```sh
GET https://api.notyapp.com/notes
```

**Response:**

```json
[
  {
    "id": 1,
    "title": "My Note",
    "content": "This is the content of my note.",
    "status": null,
    "collection_id": 1,
    "account_id": 1,
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:34:56Z"
  }
]

```

### Update a Note

**Endpoint:**

```sh
PUT /notes/:id
```

**Description:**
Updates a note for the authenticated user.

**Request Headers:**

```bash
bashCopy code
Content-Type: application/json

```

**Request Body:**

```json
{
  "title": "Updated Note",
  "content": "This is the updated content of my note."
}
```

**Example Request:**

```sh
PUT https://api.notyapp.com/notes/1
```

**Response:**

```json
{
  "message": "Note updated successfully",
  "note": {
    "id": 1,
    "title": "Updated Note",
    "content": "This is the updated content of my note.",
    "status": null,
    "collection_id": 1,
    "account_id": 1,
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:45:00Z"
  }
}
```

### Delete a Note

**Endpoint:**

```sh
DELETE /notes/:id
```

**Description:**
Deletes a note for the authenticated user.

**Example Request:**

```sh
DELETE https://api.notyapp.com/notes/1
```

**Response:**

```json
{
  "message": "Note deleted successfully"
}
```

## Collections

### Create a New Collection

**Endpoint:**

```sh
POST /collections
```

**Description:**
Creates a new collection for the authenticated user.

**Request Headers:**

```sh
Content-Type: application/json
```

**Request Body:**

```json
{
  "name": "My Collection",
  "prompt": "This is the prompt for my collection."
}
```

**Example Request:**

```sh
POST https://api.notyapp.com/collections
```

**Response:**

```json
{
  "message": "Collection created successfully",
  "collection": {
    "id": 1,
    "name": "My Collection",
    "prompt": "This is the prompt for my collection.",
    "account_id": 1,
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:34:56Z"
  }
}
```

### Retrieve All Collections

**Endpoint:**

```sh
GET /collections
```

**Description:**
Retrieves all collections for the authenticated user.

**Example Request:**

```sh
GET https://api.notyapp.com/collections

```

**Response:**

```json
[
  {
    "id": 1,
    "name": "My Collection",
    "prompt": "This is the prompt for my collection.",
    "account_id": 1,
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:34:56Z"
  }
]
```

### Update a Collection

**Endpoint:**

```bash
PUT /collections/:id

```

**Description:**
Updates a collection for the authenticated user.

**Request Headers:**

```bash
Content-Type: application/json

```

**Request Body:**

```json
jsonCopy code
{
  "name": "Updated Collection",
  "prompt": "This is the updated prompt for my collection."
}

```

**Example Request:**

```sh
PUT https://api.notyapp.com/collections/1
```

**Response:**

```json
{
  "message": "Collection updated successfully",
  "collection": {
    "id": 1,
    "name": "Updated Collection",
    "prompt": "This is the updated prompt for my collection.",
    "account_id": 1,
    "created_at": "2024-07-10T12:34:56Z",
    "updated_at": "2024-07-10T12:45:00Z"
  }
}
```

### Delete a Collection

**Endpoint:**

```bash
DELETE /collections/:id
```

**Description:**
Deletes a collection for the authenticated user.

**Example Request:**

```bash
DELETE https://api.notyapp.com/collections/1
```

**Response:**

```json
{
  "message": "Collection deleted successfully"
}
```