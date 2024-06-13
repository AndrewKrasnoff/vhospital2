# README

## This is test application

### Deployed at

https://vhospital-cod.herokuapp.com/

### Stack & Features

| Name             | Technologies                                                                                           |
|------------------|--------------------------------------------------------------------------------------------------------|
| Backend          | Ruby 3.2.2<br/>Rails 7.1                                                                               |
| Frontend         | CSS, SCSS<br/>HTML, ERB<br/>Bootstrap                                                                  |
| Database         | PostgreSQL                                                                                             |
| Server           | Puma                                                                                                   |
| Testing Tools    | RSpec<br/>Shoulda Matchers<br/>FactoryBot<br/>Faker                                                    |
| Linters          | Rubocop<br/>ERBLint                                                                                    |
| Authorization    | Cancancan                                                                                              |
| Authentication   | Devise                                                                                                 |

### Credentials

| User type       | Login                                       | Password            |
|-----------------|---------------------------------------------|---------------------|
| Admin           | 1234567890                                  | password            |
|                 |                                             |                     |
| Patients        | See list of patients<br/>when login as admin| password<br/>for all|
|                 |                                             |                     |
| Doctors         | See list of doctors<br/>when login as admin | password<br/>for all|


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

