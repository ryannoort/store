# SpatioTemporal Object REpository

STORE is a platform that allows creating spatiotemporal objects (a.k.a items) and organize them in collections and sub-collections.

An item is identified by the following attributes:
- Name: a label for the item
- Start and end date: points in time 
- Geometry: a point, path or polygon located in 2D space.

Items and collections can be described using metadata. Metadata can be specified as a group of descriptive fields called metadata sets. Each such metadata set can be further grouped into “types”, and items and collections can be created based on a selected type. This way, when an item or a collection is created, it will contain a defined set of fields. 

A collection contains both items and collections. An item can be a digital object representing a page, a media clip, etc. A collection of such items could represent a narrative. A collection could also contain sub collections, representing multiple narratives.

## Interface

The front page of STORE shows the list of top level collections. When clicked on each top collection, it shows a detailed view of the collection, with consists of a tree view of the children and a map.

This interface allows drill-down through child items and collections so that one can walk through a nested tree representation of a narrative. 

The interface also allows:
- Defining metadata sets
- Combining multiple metadata sets to types
- Creating items of a given type
- Creating collections and managing their content (i.e. associating items and other collections as its children)

STORE makes its content accessible through an API. This API can be used to build specialized interfaces to present this data to meet project specific requirements.

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

