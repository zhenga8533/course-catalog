# OSU Course Grading System

The **OSU Course Grading System** is a smart web app created with Ruby on Rails. It helps the CSE department at Ohio State University assign undergrads to the right course sections for grading.

This app makes it easy for department staff to match qualified students with specific course sections, making grading smoother. It simplifies the process of coordinating students with the right sections, reducing complexity and errors.

With a user-friendly interface and powerful features, the **OSU Course Grading System** makes it simple for staff to pair students with the right sections, ensuring grading runs smoothly. It uses advanced tech to meet the unique needs of the CSE department at Ohio State University.

## Features

- **User Authentication**: Supports login/logout functionality for Student, Instructor, and Admin users.
- **Role-Based Access Control**: Users can specify their role as Student, Instructor, or Admin during signup. Admins have the authority to approve Instructor or Admin requests.
- **Browse Course Catalog**: Users can view available courses and sections in the CSE department.
- **Admin Functionality**: Admins can browse the course catalog, edit it (add/delete/change), reload it using the API, and approve Instructor or Admin requests.

## Installation

1. Clone the repository: `git clone <https://github.com/cse-3901-sharkey/2024-Sp-Team-1-Lab-2>`
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:create db:migrate`
4. Create default admin account: `rails db:seed` (email: admin.1@osu.edu, password: Password123)
5. Start the Rails server: `rails server`

## Ruby Version

Ensure you have Ruby version 3.2.2 installed on your system. You can use a Ruby version manager like RVM or rbenv to install it.

## System Dependencies

Make sure you have the following dependencies installed:

- Rails 7.1.3
- SQLite 1.4

## API Documentation

- **Class Information**: Available at [OSU Class Search](https://class-search-api.osu.edu/v1/classes/search).
- **API URL**: [OSU Content API](https://content.osu.edu/v2/classes/search).

## General Functionality

- Implement a home page with options to login, sign up, or browse the course catalog if logged in.
- Allow users to reset their password if logged in.
- User IDs (email) should be restricted to the OSU name.#@osu.edu format.

## How to use

- Create account using your email and create a password and choose whether you want to be a Student, Instructor, or Admin.
- Once logged in you can search for classes in the catalog and even filter them with specific requirements.
- You can change/update your availability in the Profile section. To do so you just click the time slots you are available then click save.
- If a student wants to submit an application to be a grader they can click on Student Applications.
- In Student Applications you should input your phone number, select the course you would like to grade for, and if you want include a preference in grading assignments then submit.
- If click the Sign Out tab if you want to log out to sign in another account or create another account.

## Troubleshooting

- If files are accidentally or incorrectly modified to a point where the app is unresponsive, not behaving as expected, or otherwise unrecoverable, then the best thing to do is to delete the entire app from your local system and go through the installation steps above again.
- This website is designed only for individuals with emails ending in ".osu.edu". This constraint can be changed in the `app/models/user.rb` file via an update of the RegEx on line 9.
- Ohio State offers two different links to fetch course information. If the current one is down, the base URL in `app/services/course_service.rb` can be changed to `'https://contenttest.osu.edu/v2/classes/search'`.

## Gems Used

- **devise**: User authentication
- **rails**: Ruby on Rails framework
- **sqlite3**: Database adapter for Active Record
- **puma**: Web server for Rails applications
- **httparty**: Gem for making HTTP requests