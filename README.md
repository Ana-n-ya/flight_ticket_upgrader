# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 3.0.2p107

* Rails version - Rails 7.0.4.3

* System dependencies - Mentioned in the gemfile

* Database creation - Postgres


How to test the code in Local

Go to root folder, cd ../flight_ticket_upgrader

1. Install rvm

\curl -sSL https://get.rvm.io | bash

2. Install ruby 3.0.2p107 

rvm install 3.0.2

3. Install Rails 7.0.4.3

gem install rails -v 7.0.4.3

4. Install postgres

gem install pg

5. Create local database and table called FlightDetails

6. Run migration  

rake db::migrate

7. Now you can test the get,post,upload APIs using curl/postman

To test via postman

GET API - http://localhost:3000/api/v1/flight_details

Upload API - http://localhost:3000/api/v1/flight_details/upload , attach file - csv format

8. After upload, if file has no error messages, data will get stored in saved.csv

9. After upload, if file has error messages, data will get stored in failed.csv with error messages









