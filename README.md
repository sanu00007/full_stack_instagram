# Instagram Clone App



## Overview

This Instagram clone app is a full-stack solution developed using Flutter for the frontend and Firebase for the backend. It replicates key features of the popular social media platform, allowing users to authenticate, post images, search for other users, comment on posts, and more.

## Features

### User Authentication

- **Sign Up:**
  - New users can create an account by providing necessary details.

- **Log In:**
  - Existing users can log in securely to access their accounts.

- **Log Out:**
  - Users can log out to securely end their session.

### Post Management

- **Create and Publish Posts:**
  - Users can create new posts by uploading images and share them with their followers.

- **View and Like Posts:**
  - Users can scroll through their feed, view posts, and express their appreciation by liking them.

- **Comment on Posts:**
  - Interactive commenting system allows users to engage in discussions about posts.

### User Interaction

- **Follow and Unfollow Users:**
  - Users can follow others to stay updated with their posts and unfollow if needed.

- **Explore and Search for Users:**
  - A user-friendly search functionality to discover and connect with other users.

- **View User Profiles:**
  - Detailed user profiles showcase their posts, followers, and following.

### Real-time Updates

- **Real-time Post Updates:**
  - Users receive instant updates on new posts in their feed.

- **Real-time Notifications:**
  - Notifications for likes, comments, and new followers are delivered in real-time.

## Tech Stack

### Frontend

- **Flutter:**
  - Cross-platform framework for building expressive and natively compiled applications.

- **Dart:**
  - Programming language optimized for building mobile, desktop, server, and web applications.

### Backend

- **Firebase Authentication:**
  - Securely authenticate users through Firebase.

- **Cloud Firestore (Database):**
  - NoSQL cloud database to store and sync app data in real-time.

- **Firebase Storage:**
  - Cloud storage for securely uploading and storing images.

## Getting Started

### Prerequisites

- Install Flutter by following the instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone the repository:

   git clone https://github.com/sanu00007/full_stack_instagram.git
   cd instagram-clone
2.Install dependencies:
flutter pub get

3.Set up Firebase:

Create a new Firebase project on the Firebase Console.
Configure your app to use Firebase (follow the instructions on the Firebase Console).
Download the google-services.json file and place it in the android/app directory for Android, or the GoogleService-Info.plist file in the ios/Runner directory for iOS.

4.Run the app:
flutter run


License
This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgments
Inspiration: This project is inspired by the Instagram app.
Thanks to the Flutter and Firebase communities.
