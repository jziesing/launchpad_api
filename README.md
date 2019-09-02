
# Getting Started
1. [Deploy API to Heroku](#1-deploy-to-heroku)
2. [Configure Heroku Connect](#2-configure-heroku-connect)
3. [Setup API locally](#3-setup-api-locally)
4. [Done! Run the API](#4-view-api)

## 1. Deploy to Heroku
<a href="https://heroku.com/deploy?template=https://github.com/launchpadlab/launchpad_api">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>

## 2. Configure Heroku Connect
Follow the steps [outlined here](https://devcenter.heroku.com/articles/getting-started-with-heroku-and-connect-without-local-dev#use-heroku-connect-to-sync-with-salesforce). You'll want to sync the tables and columns needed for the application.

Please note the following:
- Use `salesforce` as the schema name
- Please check `Accelerate Polling` for better performance
- If you forget some tables, you can always add them later
- Make sure to sync at least one table!

## 3. Setup API locally
1. Fork this repo then clone it down to your machine
2. `cd` into your new app's folder. Run the following command (replace `APPNAME` with the name of your Heroku app): `heroku git:remote -a APPNAME`
3. In terminal: `bundle install`
4. In terminal: `heroku addons:create launchpad:test`
5. Create a new file `config/application.yml`. From terminal, run `heroku config` and copy/paste (1) DATABASE_URL and (2) LAUNCHPAD_LICENSE_KEY into config/application.yml (e.g. `LAUNCHPAD_LICENSE_KEY: lkjsdf198e3kua99sdlkfjkj`)
6. Run `bundle exec rake db:migrate`
7. In terminal: `bundle exec rake db:schema:dump`
8. In terminal: `bundle exec rake install_launchpad`
9. In `app/actions/collect_action.rb`, change `authorized?` to return `true`. This is just while we test to make sure the API is working. We'll need to change this back to `false` afterwards.
10. For each table you'd like to expose API endpoints, add the following line to config/routes.rb within the block `scope :v1 do` (replacing ":accounts" with the pluralized table name): `create_sweet_actions(:accounts)`. This generates CRUD routes for each resource (show, collect, create, update, destroy). Your routes file should look something like:

```
Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      create_sweet_actions(:accounts)
      create_sweet_actions(:opportunities)
    end
  end
end
```

## 4. Run API
1. In terminal: `rails s`
2. Visit one of your REST tables like so `localhost:3000/api/v1/accounts.json`
