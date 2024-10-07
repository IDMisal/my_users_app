# Welcome to My Users App
***

## Task
The task is to implement a basic Users App following the Model-View-Controller (MVC) architecture. 
The challenge lies in managing user data using SQLite, handling user sessions, and ensuring proper routing and response formatting in a Sinatra-based web application.

## Description
The problem is solved by creating a Sinatra application with the following components:
- A User class that interacts with an SQLite database to perform CRUD operations.
- A controller that defines routes for creating, retrieving, updating, and deleting users, as well as handling user sessions.
- A view that renders an HTML page displaying user information.
The application uses the sqlite3 gem for database interactions and follows MVC principles to separate concerns and make the codebase more maintainable.

## Installation
To install the project, follow these steps:
1. Navigate to the project directory:
 cd my_users_app
2. Install the necessary gems:
 bundle install
3. Run the Sinatra server:
 ruby app.rb

## Usage
To use the application, you can interact with it using curl or a similar tool. Here are some example commands:
1. Create a user:
2. curl -X POST http://0.0.0.0:8080/users -d "firstname=John" -d "lastname=Doe" -d "age=30" -d "password=secret" -d "email=johndoe@example.com"
Get all users:
3. curl http://0.0.0.0:8080/users
Sign in:
4. curl -X POST http://0.0.0.0:8080/sign_in -d "email=johndoe@example.com" -d "password=secret" -c cookies.txt
Update user password (requires sign-in):
5. curl -X PUT http://0.0.0.0:8080/users -d "password=newsecret" -b cookies.txt
Sign out:
6. curl -X DELETE http://0.0.0.0:8080/sign_out -b cookies.txt
Delete user (requires sign-in):
7. curl -X DELETE http://0.0.0.0:8080/users -b cookies.txt

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
