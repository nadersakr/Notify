# Notify

## Overview

Notify is a Flutter-based mobile application designed for managing group-based notifications. Users can create, join, and leave groups, while group admins can send push notifications to all members. The app utilizes Firebase for user authentication, real-time database management, and push notifications.

## Features

- **User Authentication:**
  - **Email and Password Sign-In/Sign-Up:** Securely sign up and log in using email and password.
  - **Google Sign-In:** Authenticate users easily with their Google accounts.

- **Group Management:**
  - **Create Groups:** Allow users to create new groups with a name and description.
  - **Join and Leave Groups:** Users can search for, join, or leave groups based on their interests.
  - **Admin Control:** Group creators (admins) have special privileges, including managing group members and sending notifications.

- **Push Notifications:**
  - **Real-Time Updates:** Send and receive push notifications using Firebase Cloud Messaging (FCM). Notifications are instantly delivered to all group members.

- **Group Search and Discovery:**
  - **Search Functionality:** Users can search for and discover groups based on name or criteria.

- **User Profile Management:**
  - **Group Membership Tracking:** View and manage group memberships easily.

## Technical Stack

- **Flutter:** The cross-platform framework used to build the mobile application.
- **Dart:** The programming language for writing the application logic.
- **Firebase Authentication:** Manages user sign-in and sign-up via email/password and Google accounts.
- **Cloud Firestore:** NoSQL database for storing user and group data in real-time.
- **Firebase Cloud Messaging (FCM):** Handles the delivery of push notifications.
- **Bloc:** State management solutions used for managing application state effectively.

## Getting Started

To get started with Notify, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/nadersakr/notify.git
