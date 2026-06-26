# Forum App using Flutter, Firebase & BLoC

## Project Overview

Forum App is a discussion platform developed using Flutter, Firebase Authentication, Cloud Firestore, and BLoC State Management. The application allows users to register, log in, create discussion topics, reply to discussions, and manage their own content in real-time.

The project follows a modular architecture by separating Firebase functionality into a local package, ensuring clean code organization and maintainability.

---
# Features

## Authentication Module

* User Registration
* User Login
* Secure Logout
* Firebase Authentication Integration
* Input Validation
* Error Handling

## Forum Module

* Create New Topics
* View Topics in Real-Time
* Delete Own Topics
* Open Topic Details
* Responsive Topic Listing

## Reply Module

* Add Replies to Topics
* View Replies in Real-Time
* Delete Own Replies
* Discussion Thread Interface

## State Management

* Flutter BLoC Implementation
* Event-Based Architecture
* Loading States
* Success States
* Error States

## UI Features

* Material Design Components
* Responsive Layout
* Animated Topic Cards
* Modern Dashboard Design
* Interactive User Experience

## Testing

* Unit Testing
* Mockito Mocking
* Repository Layer Testing
* Firebase Service Testing

---

# Technologies Used

## Frontend

* Flutter
* Dart

## Backend

* Firebase Authentication
* Cloud Firestore

## State Management

* Flutter BLoC
* Equatable

## Testing

* Mockito
* Flutter Test

---

# Project Architecture

```text
forum_app/
│
├── lib/
│   │
│   ├── features/
│   │   │
│   │   ├── auth/
│   │   │   └── screens/
│   │   │       ├── login_screen.dart
│   │   │       └── signup_screen.dart
│   │   │
│   │   └── forum/
│   │       ├── bloc/
│   │       │   ├── forum_bloc.dart
│   │       │   ├── forum_event.dart
│   │       │   └── forum_state.dart
│   │       │
│   │       ├── repository/
│   │       │   └── forum_repository.dart
│   │       │
│   │       └── screens/
│   │           ├── forum_home_screen.dart
│   │           └── topic_detail_screen.dart
│   │
│   ├── firebase_options.dart
│   └── main.dart
│
├── firebase_module/
│   └── lib/
│       ├── firestore_service.dart
│       └── firebase_module.dart
│
└── test/
    └── forum_repository_test.dart
```

---

# Firebase Database Structure

## Topics Collection

```json
{
  "title": "Flutter Discussion",
  "author": "user@example.com",
  "createdAt": "Timestamp"
}
```

## Replies Subcollection

```json
{
  "message": "This is a reply",
  "author": "user@example.com",
  "createdAt": "Timestamp"
}
```

---

# Application Workflow

### User Authentication

1. User creates an account.
2. Firebase Authentication stores user credentials.
3. User logs into the application.
4. User is redirected to the Forum Dashboard.

### Topic Management

1. User creates a topic.
2. Topic is stored in Cloud Firestore.
3. Topics appear instantly for all users.
4. Topic owner can delete the topic.

### Reply Management

1. User opens a topic.
2. User posts a reply.
3. Reply is stored in Firestore.
4. Replies are displayed in real-time.
5. Reply owner can delete their reply.

---

# Assignment Requirements Fulfilled

### Functional Requirements

✔ User Registration

✔ User Login

✔ Create Discussion Topics

✔ View Topics

✔ Delete Own Topics

✔ Add Replies

✔ View Replies

✔ Delete Own Replies

---

### Technical Requirements

✔ Flutter Framework

✔ Firebase Authentication

✔ Cloud Firestore

✔ BLoC State Management

✔ Repository Pattern

✔ Local Firebase Package Module

✔ Mockito Unit Testing

✔ Material Design UI

✔ Validation and Error Handling

✔ Loading Indicators

✔ Responsive User Interface

✔ Implicit Animations

---

# Testing

Run Unit Tests:

```bash
flutter test
```

Run Static Analysis:

```bash
flutter analyze
```

Run Application:

```bash
flutter run
```

---

# Future Enhancements

* User Profile Management
* Search Topics
* Topic Categories
* Dark Mode
* Push Notifications
* Topic Likes and Reactions
* Image Upload Support
* Full BLoC for Topic Fetching and Replies

---

# Conclusion

The Forum App demonstrates the practical implementation of Flutter, Firebase, and BLoC architecture to create a scalable and maintainable discussion platform. The project follows software engineering best practices including modular development, state management, testing, validation, and clean architecture.

---


SCREENSHOTS


## Login Page
![Login Page](screenshots/LOGIN%20PAGE.png)

## Sign Up Page
![Sign Up Page](screenshots/SIGNUP%20PAGE.png)

## Discussion Page
![Discussion Page](screenshots/DISCUSSION%20PAGE.png)

## Add Post
![Add Post](screenshots/ADD%20POST.png)

## Reply Page
![Reply Page](screenshots/REPLY%20PAGE.png)

## Add Reply
![Add Reply](screenshots/ADD%20REPLY.png)

## Reply Added
![Reply Added](screenshots/REPLY%20ADDED.png)
