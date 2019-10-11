## Overview
[LaunchPad](https://elements.heroku.com/addons/launchpad) is an add-on that allows developers to build and deploy Salesforce-integrated web and mobile applications 2x faster.

After only a few minutes following the below setup guide, you'll have a REST API for the Salesforce objects you'd like integrated with your web or mobile application.

The LaunchPad Add-On itself simply provides a license to use the LaunchPad framework. Without the add-on, the installation process will not succeed.

**Key Features:**

- REST API
- [ORM](https://guides.rubyonrails.org/active_record_basics.html)
- Postgres Database
- Salesforce Integration
- [Strong Security](https://guides.rubyonrails.org/security.html)
- [Authorization](https://github.com/CanCanCommunity/cancancan)
- [Authentication](https://github.com/LaunchPadLab/lp_token_auth)

## Provisioning the add-on

Since the add-on provides a full web application framework, we actually start by deploying an app to Heroku and then later provision the add-on on that app. The LaunchPad Accelerator add-on must be used in conjuction with the app deployed from the deploy button below.

1. [Deploy API to Heroku](#1-deploy-to-heroku)
2. [Configure Heroku Connect](#2-configure-heroku-connect-optional) (Optional)
3. [Setup API locally](#3-setup-api-locally)
4. [Deploy the API](#4-deploy-the-api)

### 1. Deploy to Heroku
<a href="https://heroku.com/deploy?template=https://github.com/launchpadlab/launchpad_api" target="_blank">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>

### 2. Configure Heroku Connect (Optional)
1. Click "Manage App" to go to your app's Heroku dashboard
2. Click "Resources" then "Heroku Connect"
3. Click "Setup Connection" then "Next"
4. Authorize your Salesforce account
5. Click "Mappings" then "Create Mapping" (you'll do this for each table you want to sync)
6. Select the table you want to sync (e.g. "Account")
7. Select "Accelerate Polling" for optimal performance
8. Pick the columns you'd like to sync
9. Click "Save"

### 3. Setup API Locally

Download [this repository](https://github.com/launchpadlab/launchpad_api) as a zip file and extract it into a preferred folder on your machine.

```term
$ git clone git@github.com:LaunchPadLab/launchpad_api.git
$ cd launchpad_api
$ bundle install
```

In the below command, replace `APPNAME` with the name of the Heroku app you just deployed:

```term
$ heroku git:remote -a APPNAME
$ heroku addons:create launchpad:test
```

After you provision Launchpad, the following config variables will be available in your app's configuration: 

* `LAUNCHPAD_LICENSE_KEY`

You can confirm this via the `heroku config` command:

```term
$ heroku config
=== example Config Vars
LAUNCHPAD_LICENSE_KEY: abcdefghijklmnop

```

Create a new file `config/application.yml`. Copy and paste the DATABASE_URL and LAUNCHPAD_LICENSE_KEY lines from terminal into config/application.yml (e.g. `LAUNCHPAD_LICENSE_KEY: lkjsdf198e3kua99sdlkfjkj`)

```term
$ bundle exec rake db:migrate db:schema:dump
$ bundle exec rake launchpad:install
```

For each table you'd like to expose API endpoints, add the following line to routes.rb within the block `scope :v1 do`: `create_sweet_actions(:accounts)` (replace :accounts with the pluralized table name). This generates CRUD routes for each resource (show, collect, create, update, destroy). Your routes file should look something like below:

```ruby
Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      create_sweet_actions(:accounts)
      create_sweet_actions(:opportunities)
    end
  end
end
```

### 4. Deploy the API

```term
git add -A
commit -m "first commit"
git push heroku master
```

Visit one of your resources (replace `accounts` with your resource):

```term
heroku open /api/v1/accounts.json
```

Enter the following credentials:

```
username: launchpad
password: <your LaunchPad License Key>
```

## Removing the add-on

You can remove launchpad via the CLI:

> warning
> This will destroy all associated data and cannot be undone!

```term
$ heroku addons:destroy launchpad:test
```

## Support

All launchpad support and runtime issues should be submitted via one of the [Heroku Support channels](support-channels).