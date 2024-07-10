# Noty

## Overview
Noty is a note-taking application using Ruby Roda and Vue.js (Vite). It enables users to create notes with titles, content, and prompts, which are private to each owner. Notes are organized into collections with names and prompts. Users can log in via Google, automatically creating an account with their Google name, email, and avatar.

## Requirements
- Ruby
- net/http, uri, json, dotenv Ruby gems
- OpenAI API Key

## Installation
1. Clone the repository.
2. Run `bundle install` to install the required Ruby gems.
3. Use $`export OPENAI_API_KEY=your_api_key_here` to set the key in enviroment. And consider create a .env file in the root directory and add your OpenAI API key as `OPENAI_API_KEY=your_api_key_here`.


### Backend (Ruby Roda)

### Folder Structure

```
noty-backend/
|-- app/
|   |-- controllers/
|   |   |-- application_controller.rb
|   |   |-- notes_controller.rb
|   |   |-- collections_controller.rb
|   |   |-- sessions_controller.rb
|   |-- models/
|   |   |-- note.rb
|   |   |-- collection.rb
|   |   |-- user.rb
|   |-- services/
|   |   |-- authentication_service.rb
|   |   |-- authorization_service.rb
|   |-- serializers/
|   |   |-- note_serializer.rb
|   |   |-- collection_serializer.rb
|   |   |-- user_serializer.rb
|   |-- validators/
|   |   |-- note_validator.rb
|   |   |-- collection_validator.rb
|   |-- helpers/
|   |   |-- application_helper.rb
|-- config/
|   |-- initializers/
|   |   |-- google_oauth.rb
|   |-- routes.rb
|-- db/
|   |-- migrations/
|   |   |-- create_notes.rb
|   |   |-- create_collections.rb
|   |   |-- create_users.rb
|-- spec/
|   |-- controllers/
|   |-- models/
|   |-- services/
|-- Gemfile
|-- Gemfile.lock
|-- Rakefile
|-- config.ru

```

### File Functions

- **controllers/**: Contains the logic for handling requests and returning responses.
    - `application_controller.rb`: Base controller with common functionalities.
    - `notes_controller.rb`: Manages CRUD operations for notes.
    - `collections_controller.rb`: Manages CRUD operations for collections.
    - `sessions_controller.rb`: Manages user sessions and Google login.
- **models/**: Contains the business logic and database interaction.
    - `note.rb`: Defines the Note model.
    - `collection.rb`: Defines the Collection model.
    - `user.rb`: Defines the User model.
- **services/**: Encapsulates complex business logic.
    - `authentication_service.rb`: Handles authentication logic.
    - `authorization_service.rb`: Handles authorization logic.
- **serializers/**: Formats the data before sending it to the client.
    - `note_serializer.rb`: Formats note data.
    - `collection_serializer.rb`: Formats collection data.
    - `user_serializer.rb`: Formats user data.
- **validators/**: Validates data before processing.
    - `note_validator.rb`: Validates note data.
    - `collection_validator.rb`: Validates collection data.
- **helpers/**: Utility functions for controllers.
    - `application_helper.rb`: Common helper methods.
- **config/**: Configuration files.
    - `initializers/`: Initialization code for external services.
        - `google_oauth.rb`: Configures Google OAuth.
    - `routes.rb`: Defines application routes.
- **db/**: Database migrations.
    - `migrations/`: Contains database migration files.
- **spec/**: Test files.
    - `controllers/`: Tests for controllers.
    - `models/`: Tests for models.
    - `services/`: Tests for services.

### Frontend (Vue.js with Vite)

### Folder Structure

```
noty-frontend/
|-- src/
|   |-- assets/
|   |-- components/
|   |   |-- Note.vue
|   |   |-- Collection.vue
|   |   |-- Login.vue
|   |-- layouts/
|   |   |-- DefaultLayout.vue
|   |-- pages/
|   |   |-- Home.vue
|   |   |-- NoteDetail.vue
|   |   |-- CollectionDetail.vue
|   |-- router/
|   |   |-- index.js
|   |-- store/
|   |   |-- index.js
|   |   |-- modules/
|   |       |-- notes.js
|   |       |-- collections.js
|   |       |-- user.js
|   |-- services/
|   |   |-- api.js
|   |   |-- auth.js
|   |-- utils/
|   |   |-- helpers.js
|-- public/
|   |-- index.html
|-- vite.config.js
|-- package.json
|-- README.md

```

### File Functions

- **assets/**: Static assets like images and styles.
- **components/**: Reusable Vue components.
    - `Note.vue`: Component for displaying a single note.
    - `Collection.vue`: Component for displaying a single collection.
    - `Login.vue`: Component for handling Google login.
- **layouts/**: Layout components.
    - `DefaultLayout.vue`: Main layout for the application.
- **pages/**: Page-level components.
    - `Home.vue`: Home page displaying notes and collections.
    - `NoteDetail.vue`: Page for viewing and editing a single note.
    - `CollectionDetail.vue`: Page for viewing and managing a single collection.
- **router/**: Routing configuration.
    - `index.js`: Defines routes for the application.
- **store/**: Vuex store for state management.
    - `index.js`: Vuex store setup.
    - `modules/`: Vuex modules for different parts of the application.
        - `notes.js`: State management for notes.
        - `collections.js`: State management for collections.
        - `user.js`: State management for user authentication and information.
- **services/**: API interaction.
    - `api.js`: Functions for making API calls.
    - `auth.js`: Functions for handling authentication.
- **utils/**: Utility functions.
    - `helpers.js`: Common helper functions.
- **public/**: Static files served by the server.
    - `index.html`: Main HTML file.

## License
This project is licensed under the MIT License.

