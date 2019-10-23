## Overview
The [LaunchPad](https://elements.heroku.com/addons/launchpad) add-on allows developers to generate a Ruby on Rails REST API based on a Postgres database. The add-on is typically used in conjunction with Heroku Connect, which means that a Salesforce customer can generate a REST API based on their existing Salesforce schema, greatly accelerating the process of building a Salesforce-integrated web or mobile solution.

Unlike traditional add-ons, this add-on is only useful when attached to the [LaunchPad API](github.com/launchpadlab/launchpad_api) application that is generated from our [Deploy to Heroku](#1-deploy-to-heroku) button. The add-on itself simply provides a license key. Without a license key, the installation process will not succeed.

**Key Features:**
- [Ruby on Rails](https://rubyonrails.org/) REST API
- [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) ORM
- [Postgres](https://www.postgresql.org/) Database
- [Salesforce](https://salesforce.com) Integration
- [Strong Security](https://guides.rubyonrails.org/security.html)
- [Authorization](https://github.com/CanCanCommunity/cancancan)
- [Authentication](https://tools.ietf.org/html/rfc7617)
- [API Documentation Generation](https://github.com/zipmark/rspec_api_documentation)
- [Pagination](https://github.com/davidcelis/api-pagination)
- [Serialization](https://github.com/rails-api/active_model_serializers)
- [Params Sanitization](https://github.com/launchpadlab/decanter)

## Provisioning the add-on
1. [Deploy LaunchPad API to Heroku](#1-deploy-to-heroku)
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
Clone the [LaunchPad API](https://github.com/launchpadlab/launchpad_api) to your machine:

```term
$ git clone git@github.com:LaunchPadLab/launchpad_api.git
$ cd launchpad_api
$ bundle install
```

In the below command, replace `APPNAME` with the name of the Heroku app you just deployed:

```term
$ heroku git:remote -a APPNAME
$ heroku addons:create launchpad:test
$ bundle exec rake launchpad:pull
$ bundle exec rake launchpad:install
```

### 4. Deploy the API

```term
git add -A
commit -m "first commit"
git push heroku master
heroku open /api/docs
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