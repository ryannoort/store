# SpatioTemporal Object REpository

## Development setup

### Version requirements

* Ruby 2.3.3
* Rails 5.0.1

### System dependencies

* Postgresql
* Postgis 

### Configuration

Environment configuration defined using dontEvn on `./.env`. An example file is provided on `.env-EXAMPLE`. 

Database configuration is defined on `./config/database.yml`, the information provided is meant for development purposes only.

### Database initialization

rake db:setup
rake db:migrate
rake db:seed

### Bower 

Run `bower install` on app directory top install all vendor dependencies

