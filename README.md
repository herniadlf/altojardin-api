## Delivery LaNona (API Rest)

By Mariano Hielpos y Hernán de la Fuente (Equipo Altojardín)

[![build status](https://gitlab.com/fiuba-memo2/tp2/altojardin-api/badges/master/build.svg)](https://gitlab.com/fiuba-memo2/tp2/altojardin-api/commits/master)

## Branch convention for production happy path

- develop => Unique branch for developing features in a local environment
- staging => Test Environment. Used for PO validations after a succesfull developing stage. Automatically deploy to "url"
- master => Production. You need to create a Merge Request from staging to this branch in order to trigger a deploy to "url"

In case of feature branch develop, when you end your work you must merge with develop and destroy the feature branch.

## Local application setup

1. Run **_vagrant up_** to build the vm. Then, Run **_vagrant ssh_** to working on it.
1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_bundle exec padrino start -h 0.0.0.0_**, to start the application
