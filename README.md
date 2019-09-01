
# Getting Started
1. [Deploy API to Heroku](#1-deploy-to-heroku)
2. [Configure Heroku Connect](#2-configure-heroku-connect)
3. [Setup API locally](#3-setup-api-locally)
4. [Done! Run the API](#4-view-api)

## 1. Deploy to Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## 2. Configure Heroku Connect
Follow the steps [outlined here](https://devcenter.heroku.com/articles/getting-started-with-heroku-and-connect-without-local-dev#use-heroku-connect-to-sync-with-salesforce). You'll want to sync the tables and columns needed for the application.

## 3. Setup API locally
1. Clone down the repo: `git clone https://github.com/launchpadlab/launchpad_api`
2. In terminal: `bundle install`
3. Set DATABASE_URL to your Postgres URI in config/application.yml
4. In terminal: `bundle exec rake db:schema:dump`
5. In terminal: `bundle exec rake build_models`
6. For each file that was generated in app/models, add the following line (replacing "account" with the correct table): `self.table_name = 'salesforce.account'`
7. In `app/actions/collect_action.rb`, change `authorized?` to return `true`. This is just while we test to make sure the API is working. We'll need to change this back to `false` afterwards.
8. For each model, add the following line to routes.rb within the block `scope :v1 do` (replacing "accounts" with the pluralized resource name): `create_sweet_actions(:accounts)`. This generates CRUD routes for each resource (show, collect, create, update, destroy).

## 4. Run API
1. In terminal: `rails s`
2. Visit one of your REST tables like so `localhost:3000/api/v1/accounts.json`
