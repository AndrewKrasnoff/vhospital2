# README

## This is test application

### Deployed at

https://vhospital2.onrender.com/

**As hosting is free the application is in 'sleeping' mode.
Please wait about 60 seconds when you follow the link to let the application 'awake'**

### Stack & Features

| Name             | Technologies                                                                                           |
|------------------|--------------------------------------------------------------------------------------------------------|
| Backend          | Ruby 3.2.2<br/>Rails 7.1.3.4                                                                           |
| Frontend         | CSS, SCSS<br/>HTML, ERB<br/>Bootstrap                                                                  |
| Database         | PostgreSQL                                                                                             |
| Server           | Puma                                                                                                   |
| Testing Tools    | RSpec<br/>Shoulda Matchers<br/>FactoryBot<br/>Faker                                                    |
| Linters          | Rubocop<br/>ERBLint                                                                                    |
| Authorization    | Cancancan                                                                                              |
| Authentication   | Devise                                                                                                 |

### Credentials

| User type       | Login                                       | Password                   |
|-----------------|---------------------------------------------|----------------------------|
| Admin           | 1234567890                                  | <b>password</b>            |
|                 |                                             |                            |
| Patients        | See list of patients<br/>when login as admin| <b>password</b><br/>for all|
|                 |                                             |                            |
| Doctors         | See list of doctors<br/>when login as admin | <b>password</b><br/>for all|

### Getting Started

1. **Clone the project.**
    ```bash
    git clone https://github.com/AndrewKrasnoff/vhospital2.git
    ```

3. **Build application.**
    ```bash
    docker compose up --build
    ```

3. **Run seeds.**
    ```bash
    docker compose exec backend bundle exec rails db:seed
    ```

### Links

| Name              | Link                                |
|-------------------|-------------------------------------|
| vhospital2        | http://localhost:3000               |
| Show Emails       | http://localhost:3000/letter_opener |
| Preview Emails    | http://localhost:3000/rails/mailers |

### Task description

To create an application to manage the hospital

Users' types:
- patient (User)
- doctor (Doctor)
- admin (Admin)

Each type of user should have such functionality:

1. The patient can register and log in to his account. Can see doctors' lists by categories,
can make assignments with any doctor, and can receive recommendations from doctors.
2. Doctor can log in to it account. Can see a list of assignments, and write an answer to the patient.
The doctor is assigned to one of the categories.
3. Admin has access to lists of patients and doctors. Can create categories and assign (reassign) doctors to categories.

Authentication and authorization requirements:
- use gem devise for authentication;
- use gem cancancan for authorization
- all users can log in using their phone number and password;

Categories requirements:
- validation by a unique name;
- can be assigned to several doctors;

Assignments requirements:
- a doctor can have only 10 open (not answered) assignments at a time;
- a patient can have only 1 (not answered) assignment with the same doctor;
- the assignment is closed (not deleted) when the doctor writes an answer to the patent;

### Commands

`yarn exec <command>` - execute command inside backend container

`yarn status` - show status of running containers

`yarn build` - build project

`yarn up` - start development environment (you can use `-d` option for silence mode)

`yarn stop` - stop containers

`yarn down` - down containers

`yarn bash` - go inside the backend container to execute commands

`yarn c` - run Ruby console inside the backend container

`yarn routes` - show all routes (you can find all matches `yarn routes | grep <resource_name>`)

`yarn db:seed` - run seeds

`yarn db:replant` - truncate DB and run seeds

`yarn db:migrate` - run migrations

`yarn db:rollback` - run migration rollback

`yarn db:reset` - run reset the database (drop, create, migrate, seed)

`yarn rubocop` - run Rubocop (you can use `-a` option to fix some issues)

`yarn erblint` - run ERBLint (you can use `-a` option to fix some issues)

`yarn rspec` - run RSpec in parallel mode

`yarn linters` - run linters and tests (rubocop, erblint, rspec)

`yarn annotate` - run Annotate models

