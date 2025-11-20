# Silsilah Digital Blueprint

## Overview

Silsilah Digital is a Flutter application designed to connect Murshids (spiritual guides) and Mureeds (disciples) in a digital environment. The application facilitates the management of their spiritual lineage (silsilah) and provides a platform for communication and guidance.

## Features

### Authentication

*   **Sign-up:** Separate sign-up flows for Murshids and Mureeds.
    *   **Murshid Sign-up:** Collects name, email, phone number, and password.
    *   **Mureed Sign-up:** Collects name, email, phone number, password, and allows the Mureed to select their Murshid from a list of approved Murshids.
*   **Sign-in:** A single sign-in screen for all user roles.
*   **User Roles:** The application defines the following user roles:
    *   `superAdmin`: Manages the entire application, including user approvals and silsilah creation.
    *   `admin`: Manages a specific branch of the silsilah.
    *   `murshid`: A spiritual guide who can have multiple Mureeds.
    *   `mureed`: A disciple connected to a Murshid.
*   **Authentication Provider:** Manages the application's authentication state, handling user sign-up, sign-in, and sign-out.

### Super Admin Dashboard

*   **User Management:** A dedicated dashboard for the super admin to manage all users.
*   **User List:** Displays a list of all registered users with their names and roles.
*   **User Details:** Shows detailed information for a selected user, including their name, email, phone number, role, and approval status.
*   **User Approval:** Allows the super admin to approve or disapprove users, controlling their access to the application.
*   **Silsilah Management:** Allows the super admin to create, view, edit, and delete silsilahs.
*   **Silsilah Tree View:** Displays the silsilahs in a hierarchical tree structure.

### Admin Dashboard

*   **User Management:** A dashboard for the admin to manage users within the silsilahs they are assigned to.
*   **User List:** Displays a list of users who belong to the silsilahs managed by the admin.
*   **User Details:** Shows detailed information for a selected user, including their approval status. The admin can approve or disapprove users within their silsilahs.

### Murshid Dashboard

*   **Mureed List:** Displays a list of all Mureeds assigned to the Murshid.

### Mureed Dashboard

*   **Murshid Information:** Displays the name of the Mureed's Murshid.

### Firestore Integration

*   **User Service:** A service class that handles all interactions with the Firestore `users` collection.
*   **Data Models:** A `User` model that represents the user data stored in Firestore.
*   **Silsilah Service:** A service class that handles all interactions with the Firestore `silsilahs` collection.
*   **Silsilah Model:** A `Silsilah` model that represents the silsilah data stored in Firestore.

### Routing

*   **GoRouter:** The application uses the `go_router` package for declarative routing.
*   **Authentication-based Redirects:** The router is configured to redirect users based on their authentication state. For example, unauthenticated users are redirected to the login screen.

## Project Structure

*   `lib/`
    *   `main.dart`: The main entry point of the application.
    *   `models/`: Contains the data models, such as `user.dart` and `silsilah.dart`.
    *   `providers/`: Contains the application's providers, such as `auth_provider.dart`.
    *   `routing/`: Contains the application's routing configuration, such as `app_router.dart`.
    *   `screens/`: Contains the different screens of the application, organized by user role.
    *   `services/`: Contains the services that interact with external dependencies, such as `user_service.dart` and `silsilah_service.dart`.

## Current Plan

*   **Implement User-to-Silsilah Assignment:** Create a UI for the `superAdmin` and `admin` to assign users to specific silsilahs.
*   **Implement Communication Features:** Add features that allow Mureeds to communicate with their Murshids, such as a messaging system.
*   **Enhance User Profiles:** Add more details to user profiles, such as a profile picture and a short bio.
*   **Refine UI/UX:** Improve the overall look and feel of the application.
