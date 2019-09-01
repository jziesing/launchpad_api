
# Getting Started
1. [Deploy API to Heroku](#1-deploy-to-heroku)
2. [Configure Heroku Connect](#2-configure-heroku-connect)
3. [Setup API locally](#3-setup-api-locally)
4. [Done! Run the API](#4-view-api)

## 1. Deploy to Heroku
<a href="https://heroku.com/deploy?template=https://github.com/launchpadlab/launchpad_api">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>

Add the `launchpad` add-on to your Heroku App's Resources.

## 2. Configure Heroku Connect
Follow the steps [outlined here](https://devcenter.heroku.com/articles/getting-started-with-heroku-and-connect-without-local-dev#use-heroku-connect-to-sync-with-salesforce). You'll want to sync the tables and columns needed for the application.

Please note the following:
- Use `salesforce` as the schema name
- Please check `Accelerate Polling` for better performance
- If you forget some tables, you can always add them later

## 3. Setup API locally
1. Fork the repo then clone it down to your machine
2. `cd` into your new app's folder. Run the following command (replace `APPNAME` with the name of your Heroku app): `heroku git:remote -a APPNAME`
3. In terminal: `bundle install`
4. Run `heroku config` and copy/paste the DATABASE_URL into config/application.yml
5. Run `bundle exec rake db:migrate`
6. In terminal: `bundle exec rake db:schema:dump`
7. In terminal: `bundle exec rake install_launchpad`
8. For each file that was generated in app/models, add the following line (replacing "account" with the correct table): `self.table_name = 'salesforce.account'`
9. In `app/actions/collect_action.rb`, change `authorized?` to return `true`. This is just while we test to make sure the API is working. We'll need to change this back to `false` afterwards.
10. For each model, add the following line to routes.rb within the block `scope :v1 do` (replacing "accounts" with the pluralized resource name): `create_sweet_actions(:accounts)`. This generates CRUD routes for each resource (show, collect, create, update, destroy).

## 4. Run API
1. In terminal: `rails s`
2. Visit one of your REST tables like so `localhost:3000/api/v1/accounts.json`
