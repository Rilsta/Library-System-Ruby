# Library-System-Ruby
**by Riley Starnes and Mike Mahone**

## Project
Build a library catalog website where users can view animals for adoption. Practice CRUD functionality 
with Ruby, Sinatra, and psql to manipulate data in a Postgres database. Practice RESTful routing and
Behavior Driven Development.

## Installation
Clone the Repository
* `git clone https://github.com/Rilsta/Library-System-Ruby.git`
* Navigate to project directory

Install the ruby gems
* `$bundle install`

Set up the database by running the following:
* `$psql`
* `CREATE DATABASE library_system`
* `\c library_system`
* `CREATE TABLE patrons (id serial PRIMARY KEY, name varchar)`
* `CREATE TABLE books (id serial PRIMARY KEY, author varchar, genre varchar, title varchar)`

For testing, stay in psql and run the following
* `CREATE DATABASE library_system_test WITH TEMPLATE library_system`
* exit psql and run `$rspec`

To view:
* `ruby app.rb`
* Open a web browser and navigate to localhost:4567

## License
MIT License 2016
