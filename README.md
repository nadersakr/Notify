# Notify
A Flutter app for group-based notifications using Firebase. Users can create, join, and leave groups. Admins send push notifications to all group members. Features include email/Google authentication, real-time updates, and group search. Built with Flutter, Dart, Firebase Authentication, Firestore, and FCM.

# Group Notification Platform

## Overview

The Group Notification Platform is a Flutter-based mobile application designed for managing group-based notifications. Users can create, join, and leave groups, while group admins can send push notifications to all members. This app utilizes Firebase for user authentication, real-time database management, and push notifications.

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
  - **Search Functionality:** Users can search for and discover groups based on their interests or other criteria.

- **User Profile Management:**
  - **Group Membership Tracking:** View and manage group memberships easily.

## Technical Stack

- **Flutter:** The cross-platform framework used to build the mobile application.
- **Dart:** The programming language for writing the application logic.
- **Firebase Authentication:** Manages user authentication via email/password and Google accounts.
- **Cloud Firestore:** NoSQL database used for storing user and group data in real-time.
- **Firebase Cloud Messaging (FCM):** Handles the delivery of push notifications.
- **Bloc:** State management solutions used for managing application state effectively.

