# Product Listing

[![Code Climate](https://codeclimate.com/github/boddhisattva/product-listing/badges/gpa.svg)](https://codeclimate.com/github/boddhisattva/product-listing) [![Test Coverage](https://codeclimate.com/github/boddhisattva/product-listing/badges/coverage.svg)](https://codeclimate.com/github/boddhisattva/product-listing/coverage) [![Circle CI](https://circleci.com/gh/boddhisattva/product-listing.svg?style=svg)](https://circleci.com/gh/boddhisattva/product-listing)

<hr />

## About

This is a sample product listing app built using AngularJS on the client side and a Rails API in the backend. With this app one can -
* Perform basic CRUD operations with respect to a product

One can try using the app wrt the work done so far on [this link][app website link]

## Usage

### Dependencies

1. Ruby 2.2.2
2. Rails 4.0.6
3. Angular JS 1.2.19
4. PostgreSQL 9.4.1
5. For other dependecies, please check the [Gemfile][gemfile]

### Setup

#### Development
1. Clone the repo, and `cd` into the same
2. Run -
 1. `bundle install`
 2. `cp config/database.yml.example config/database.yml`
 3. `rake db:create`
 4. `rake db:migrate`

#### Test
1. From the project root directory run -
 1. `rake db:migrate RAILS_ENV=test`(this step assumes you've run `rake db:create` already)

### Get the app up and running

#### Development
1. From the project root directory run -
 1. `rails s` to kickstart your app web server
 2. Navigate to `http://localhost:3000` in your browser

### Running your specs
1. From the project root directory -
 1. Use `bundle exec rspec` to run all your specs

<hr />

[gemfile]: https://github.com/boddhisattva/product-listing/blob/master/Gemfile
[app website link]: http://product-listing.herokuapp.com