# Howard Treasury Project

## Overview
A comprehensive web application dedicated to Robert E. Howard's literary works, featuring story collections, poems, illustrations, and interactive features. Built with Spring Boot backend and Angular frontend, this project provides an immersive experience for fans of Howard's writings.

## Features
* Story Collections & Library Management
* Poetry Database & Archive 
* Character & Illustrator Profiles
* Interactive Blog System with Comments
* Real-time Chat Rooms
* Customizable User Lists/Collections
* AI-Powered Adventure System
* Full-Text Search Functionality
* Image Gallery with Historical Illustrations
* Weird Tales Magazine Archive Access
* User Authentication & Authorization
* WebSocket Communication

## Technology Stack

### Backend
* Java Spring Boot
* Spring Security with JWT
* Spring Data JPA/Hibernate
* WebSocket Integration
* MySQL Database
* Gradle Build System
* OpenAI Integration

### Frontend  
* Angular 15
* TypeScript
* RxJS
* Material UI Components
* TinyMCE Rich Text Editor
* WebSocket Client
* Custom Animation System

## Project Structure

    ├── DB/                          # Database files & schema
    ├── HowardTreasury/             # Spring Boot Backend
    │   ├── src/main/java
    │   │   ├── configurations/     # App configs
    │   │   ├── controllers/        # REST endpoints
    │   │   ├── services/          # Business logic
    │   │   ├── repositories/      # Data access
    │   │   ├── entities/          # Data models
    │   │   └── security/          # Auth & security
    │   └── resources/             # Properties & static
    ├── JPAHowardTreasury/         # JPA Entity Project
    └── ngHowardTreasury/          # Angular Frontend
        ├── src/app
        │   ├── components/        # UI components
        │   ├── services/         # Data & state
        │   ├── models/          # TypeScript interfaces
        │   ├── guards/          # Route protection
        │   └── pipes/           # Data transformation

## Setup & Installation

### Prerequisites
* Java 8+
* Node.js & npm 
* MySQL
* Gradle

### Database Setup
1. Create MySQL database
2. Run schema script from DB folder
3. Configure connection in application.properties

### Backend Setup
1. Clone repository
2. Navigate to HowardTreasury directory
3. Build project:

    ```
    ./gradlew build
    ```
4. Run application:
    ```
    ./gradlew bootRun 
    ```

### Frontend Setup
1. Navigate to ngHowardTreasury
2. Install dependencies:
    ```
    npm install
    ```
3. Start development server:
    ```
    ng serve
    ```

## Key Features Implementation

### Authentication
* JWT token based auth
* Email verification
* Password reset
* Account reactivation
* Rate limiting

### Content Management
* Story collections & series
* Poetry database
* Character profiles
* Blog system
* Image galleries
* Historical archives

### Interactive Features
* Real-time chat
* AI storytelling
* User collections
* Story voting
* Blog comments
* Search functionality

## Testing
* Backend: JUnit tests for repositories, services & controllers
* Frontend: Karma & Jasmine for components & services

## Contributing
1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Submit pull request

## License
All rights reserved

## Contact
[Your contact information]