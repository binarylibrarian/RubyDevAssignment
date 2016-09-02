#Events Application Design

##Technology

###Rails

Since the requirements include both a traditional website and an API Rails would seem the ideal choice over other more API focused frameworks such as Sintra, or Padrino.

###Postgres

Many of the functions of the application, user registration, program registration lend themselves to the traditional SQL model. However message posts on event pages, and multiple topic tags might benfit from the use of a noSQL database. Postgres' JSONB format and it's integration with ActiveRecord allow for the best of both worlds SQL structure were natural and noSQL freedom and performace where possible.

###Elasticsearch

The requirements outline the need for the ability to search for events. While a basic event search could be acomplished with Postgres alone, this would suffer from a number of issues; much of the search logic would need to be written into the Ruby code, search result quality would be low and performance would be a problem. Elasticsearch offers the ability to do performant full text searches on mulitple fields. It also intagrates well with Rails/ActiveRecord.

###S3

User profile images and event images will be stored in AWS S3.

###Nginx

Nginx would serve as load balancer, and caching reverse proxy. In addtion to serving as a load balancer for multiple app instances, Nginx also serves as a check against the slow client problem. This is less nessesary depending on the choice of app server but is never the less helpful.

###ELK

If no other monitoring infrastrcture exists the ELK stack provides a relatively straight forward means of agrigating, visualizing and analysing logs. While a seperate instance would be required specificly for logs, the ELk's use of Elasticsearch as the underlying store simplifies the overall complexty of the system. A simple Logstash grep filter on the standard Rails logs would be sufficiant, at least initially.

##Software Architecture

The application would consist of a number of pieces outlines above. The primary component is a fairly traditional Rails application. It would run on a number of app servers behind a Nginx load balancer. The Nginx instance would serve cached static content such as css, html, and javascript. The primary backend for the application is a Postgres database. Search functionality would be provided by a dedicated Elasticsearch database that would sync with the Postgres database. Images for profile and event pictures are stored in AWS S3. Logging is managed by the an instance of the ELK stack running a seperate instance of Elasticsearch. Logs are processed with a simple grep filter on the logs from both Nginx and the app instances.

##Database Format

Given the traditional structured relationships between the data, Events, Users, Registrations, etc, I chose a standard SQL database (Postgres). That said some aspects of the application may suffer under a traditionally normalized SQL database. Postgres offers, and ActiveRecord supports a the field format JSONB which allows for the storage and querying of json formated data. This seem apropriate for a number of the fields on the Event model. Messages on events seemed an ideal canidate since the information is unlikely to be used outside of the Events details page. That said the use of JSONB allows for querying based on user_id as well if the need were to arise. Location information is also stored on as JSONB for noSQL like querying, a locations table also exists to facilitate the creation of a listing of connonical locations for selection and display on a map. An Organizer table exists to differentiate between Event creator/owners and organizers.
