#Events Application Design

##Technology

###Rails

Since the requirements include both a traditional website and an API, Rails seemed the ideal choice over other more API focused frameworks such as Sintra, or Padrino.

###Postgres

Many of the functions of the application, user registration, program registration lend themselves to the traditional relational model. However message posts on event pages, and multiple topic tags might benefit from the use of a non relational noSQL database. Postgres' JSONB format and it's integration with ActiveRecord allow for the best of both worlds relational SQL structure where natural and noSQL freedom and performance where possible.

###Puma

When deployed to production I would use Puma ass the application server. Puma uses a combination of native threads as well as an evented  “reactor” like model within each thread. This provides some protection agains slow clients as well preventing slow responses from effecting performance.

###Elasticsearch

The requirements outline the need for the ability to search for events. While a basic event search could be accomplished with Postgres alone, this would suffer from a number of issues; much of the search logic would need to be written into the Ruby code, search result quality would be low and performance would be a problem. Elasticsearch offers the ability to do performant full text searches on multiple fields. It also integrates well with Rails/ActiveRecord.

###S3

User profile images and event images will be stored in AWS S3.

###Nginx

In production Nginx would serve as load balancer, and caching reverse proxy. In addition to serving as a load balancer for multiple app instances, Nginx also serves as an additional check against the slow client problem.

###ELK

If no other monitoring infrastructure exists the ELK stack provides a relatively straight forward means of aggregating, visualizing and analyzing logs. While a separate instance would be required specifically for logs, the ELk's use of Elasticsearch as the underlying store simplifies the overall complexity of the system. A simple Logstash grep filter on the standard Rails and webserver logs would be sufficient, at least initially.

##Software Architecture

The application would consist of a number of pieces outlines above. The primary component is a fairly traditional Rails application. Structurally it’s a typical MVC application. The API has been separated out and name spaced to facilitate the rollout of subsequent versions.

The primary backend for the application is a Postgres database. Search functionality would be provided by a dedicated Elasticsearch database that would sync with the Postgres database. Images for profile and event pictures are stored in AWS S3.

It would run on a number of app servers behind a Nginx load balancer. The Nginx instance would serve cached static content such as css, html, and javascript. Logging is managed by the an instance of the ELK stack running a separate instance of Elasticsearch. Logs are processed with a simple grep filter on the logs from both Nginx and the app instances.

![diagram](/event_architecture.jpeg?raw=true "Software Architecture")

##Database Format

Given the traditional structured relationships between the data, Events, Users, Registrations, etc, I chose a standard relational SQL database (Postgres). That said some aspects of the application may suffer under a traditionally normalized SQL database. Postgres offers, and ActiveRecord supports a the field format JSONB which allows for the storage and querying of json formatted data.

The use of jsonb seem appropriate for a number of the fields on the Event model.

Messages on events seemed an ideal candidate since the information is unlikely to be used outside of the Events details page. That said the use of JSONB allows for querying based on user_id as well if the need were to arise.

Location information is also stored on as JSONB for noSQL like querying. As the service evolves storing location data as a jsonb array rather then a single value will provide greater flexibility. A locations table also exists to facilitate the creation of a listing of canonical locations for selection and display on a map.

The registrations table links users with events. Since registered users needed to be listed on the events page, a username field is included on the registrations model. Since neither registrations nor users names are likely to require frequent changes their seemed little downside in denormalizing the username, when compared with the vast efficiency increase in displaying the names on the events page.

An Organizer table exists to differentiate between Event creator/owners and organizers.

![diagram](/event_schema.jpeg?raw=true "Software Architecture")
