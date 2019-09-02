
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
1. Click "Manage App" to go to your app's Heroku dashboard
2. Click "Resources" then "Heroku Connect"
3. Click "Setup Connection" then "Next"
4. Authorize your Salesforce account
5. Click "Mappings" then "Create Mapping" (you'll do this for each table you want to sync)
6. Select the table you want to sync (e.g. "Account")
7. Select "Accelerate Polling" for optimal performance
8. Pick the columns you'd like to sync
9. Click "Save"

## 3. Setup API locally
1. Download this repository (github.com/launchpadlab/launchpad_api) as a zip file and extract it into a preferred folder on your machine
2. `cd` into that folder and run the command `git init` to initialize the git repository
3. In terminal, run `heroku git:remote -a APPNAME` (replace `APPNAME` with the name of the Heroku app you just deployed)
4. In terminal, run `bundle install`
5. In terminal, run `heroku addons:create launchpad:test`
6. Create a new file `config/application.yml`. Run `heroku config` and copy/paste DATABASE_URL and LAUNCHPAD_LICENSE_KEY lines into config/application.yml (e.g. `LAUNCHPAD_LICENSE_KEY: lkjsdf198e3kua99sdlkfjkj`)
7. In terminal, run `bundle exec rake db:migrate`
8. In terminal, run `bundle exec rake db:schema:dump`
9. In terminal, run: `bundle exec rake install_launchpad`
10. In `app/actions/collect_action.rb`, change `authorized?` to return `true`. This is just while we test to make sure the API is working. We'll need to change this back to `false` afterwards.
10. For each table you'd like to expose API endpoints, add the following line to routes.rb within the block `scope :v1 do`: `create_sweet_actions(:accounts)` (replace :accounts with the pluralized table name). This generates CRUD routes for each resource (show, collect, create, update, destroy). Your routes file should look something like below:

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
