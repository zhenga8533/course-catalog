# OSU Course Grading System

The OSU Course Grading System is a smart web app created with Ruby on Rails. It helps the CSE department at Ohio State University assign undergrads to the right course sections for grading.

This app makes it easy for department staff to match qualified students with specific course sections, making grading smoother. It simplifies the process of coordinating students with the right sections, reducing complexity and errors.

With a user-friendly interface and powerful features, the OSU Course Grading System makes it simple for staff to pair students with the right sections, ensuring grading runs smoothly. It uses advanced tech to meet the unique needs of the CSE department at Ohio State University.

## Features

### User Authentication
- Supports login/logout functionality for Student, Instructor, and Admin users.

### Role-Based Access Control
- Users can specify their role as Student, Instructor, or Admin during signup.
- Admins have the authority to approve Instructor or Admin requests.

### Browse Course Catalog
- Users can view available courses and sections in the CSE department.

### Admin Functionality
- Admins can browse the course catalog, edit it (add/delete/change), reload it using the API, and approve Instructor or Admin requests.

## Installation

1. Clone the repository: `git clone <https://github.com/cse-3901-sharkey/2024-Sp-Team-1-Lab-2>`
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:create db:migrate`
4. Start the Rails server: `rails server`
5. Create default admin account: `rails db:seed` (email: `admin.1@osu.edu`, password: `Password123`)

## Ruby Version

Ensure you have Ruby version 3.2.2 installed on your system. You can use a Ruby version manager like RVM or rbenv to install it.

## System Dependencies

Make sure you have the following dependencies installed:

- Rails 7.1.3
- SQLite 1.4

## API Documentation

- **Class Information:** Available at [OSU Class Search](https://classes.osu.edu/class-search/#/).
- **API URL:** [OSU Content API](https://contenttest.osu.edu/v2/classes/search).

## General Functionality

- Implement a home page with options to login, sign up, or browse the course catalog if logged in.
- Allow users to reset their password if logged in.
- User IDs (email) should be restricted to the OSU name.#@osu.edu format.

## Student Functionality

- Students can login and browse the course catalog.

## Instructor Functionality

- Instructors can login and browse the course catalog.

## Admin Functionality

- Admins can:
  - Browse the course catalog.
  - Edit the course catalog (add/delete/change).
  - Reload the course catalog.
  - Approve Instructor or Admin requests.

## Gems Used

- `devise`: User authentication
- `rails`: Ruby on Rails framework
- `sqlite3`: Database adapter for Active Record
- `puma`: Web server for Rails applications
- `httparty`: Gem for making HTTP requests
