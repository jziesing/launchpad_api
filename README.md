The [LaunchPad](https://elements.heroku.com/addons/launchpad) add-on allows Salesforce customers to build and launch integrated web and mobile applications 2x faster. The add-on is used in conjunction with Heroku Connect, which means that a Salesforce customer can generate a REST API based on their existing Salesforce schema, greatly accelerating the process of building a Salesforce-integrated web or mobile solution.

Unlike traditional add-ons, this add-on is only useful when attached to the [LaunchPad API](github.com/launchpadlab/launchpad_api) application that is generated from the [Deploy to Heroku](#1-deploy-launchpad-api-to-heroku) button. The add-on itself simply provides a license key. Without a license key, the installation process will not succeed.

**Key Features:**

- [Ruby on Rails REST API](#ruby-on-rails)
- [Active Record ORM](#active-record-orm)
- [Postgres Database](#postgres)
- [Salesforce Integration](#salesforce-integration)
- [Security](#security)
- [Authorization](#authorization)
- [Authentication](#authentication)
- [API Documentation](#api-documentation)
- [Pagination](#pagination)
- [Serialization](#serialization)
- [Params Sanitization and Transformation](#params-sanitization-and-transformation)

## Provisioning the add-on
Unlike other Heroku add-ons that can be attached to an existing Heroku app, the LaunchPad add-on must be attached to the [LaunchPad API](github.com/launchpadlab/launchpad_api). Because of this, the first step is to deploy the LaunchPad API application to Heroku using the Deploy to Heroku button found below.

1. [Deploy LaunchPad API to Heroku](#1-deploy-launchpad-api-to-heroku)
2. [Configure Heroku Connect](#2-configure-heroku-connect)
3. [Set up API locally](#3-set-up-api-locally)
4. [Deploy the API](#4-deploy-the-api)

### 1. Deploy LaunchPad API to Heroku
<a href="https://heroku.com/deploy?template=https://github.com/launchpadlab/launchpad_api" target="_blank">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>

### 2. Configure Heroku Connect

>note
> We highly recommend using a Sandbox Salesforce environment until you are comfortable with how the add-on is performing. Once testing is complete, you can generate a second Heroku app using the Deploy to Heroku button and link that app to your Production Salesforce environment in Heroku Connect.

1. Click **`Manage App`** to go to your app's Heroku dashboard
2. Click **`Resources`** then "Heroku Connect"
3. Click **`Setup Connection`** then **`Next`**
4. Authorize your Salesforce account.
5. Click **`Mappings`** then **`Create Mapping`** (you'll do this for each object you want to sync)
6. Select the object you want to sync (e.g. "Account")
7. Select **`Accelerate Polling`** for optimal performance
8. Pick the columns you'd like to sync
9. Click **`Save`**

### 3. Set up API locally

>note
> The API is a Ruby on Rails application that requires Ruby to be installed on your machine. Please make sure Ruby v2.5.1 is installed before proceeding.

In the below commands, replace `APPNAME` with the name of the Heroku app you just deployed:

```term
$ git clone git@github.com:LaunchPadLab/launchpad_api.git APPNAME
$ cd APPNAME
$ bundle install
$ heroku git:remote -a APPNAME
$ heroku addons:create launchpad:test
$ bundle exec rake launchpad:pull
$ bundle exec rake launchpad:install
```

Follow the terminal instructions to select the objects you'd like to add to the API.

Finally, start your server to view the API documentation:

```
$ rails s
$ open localhost:3000/api/docs
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
password: <your LaunchPad License Key found in config/application.yml>
```

## Using the add-on

- [Ruby on Rails](#ruby-on-rails)
- [Active Record ORM](#active-record-orm)
- [Postgres Database](#postgres)
- [Salesforce Integration](#salesforce-integration)
- [Security](#security)
- [Authorization](#authorization)
- [Authentication](#authentication)
- [API Documentation](#api-documentation)
- [Pagination](#pagination)
- [Serialization](#serialization)
- [Params Sanitization and Transformation](#params-sanitization-and-transformation)

### Ruby on Rails
The LaunchPad API leverages [Ruby on Rails](https://rubyonrails.org/) as the underlying application framework. If you are unsure whether Ruby on Rails is a fit for your project, we highly recommend that you read the [Rails Doctrine](https://rubyonrails.org/doctrine/) to determine if the framework aligns philosophically with your development team. 

### Active Record ORM
Each object generated in the LaunchPad API will have a corresponding Active Record [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) object which can be found in `app/models/`. 

To learn more about Active Record, please read the [Active Record Basics Guide](https://guides.rubyonrails.org/active_record_basics.html). As described in this guide, Active Record provides the following key mechanisms:

- Represent models and their data.
- Represent associations between these models.
- Represent inheritance hierarchies through related models.
- Validate models before they get persisted to the database.
- Perform database operations in an object-oriented fashion.

### Postgres
By default the LaunchPad API connects directly to your Heroku Postgres database in development mode. You can change this by modifying the `config/database.yml` file or simply changing the `DATABASE_URL` environment variable for a given environment. You can read more about configuring databases [here](https://edgeguides.rubyonrails.org/configuring.html#configuring-a-database) and managing environment variables [here](https://github.com/laserlemon/figaro).

### Salesforce integration
The LaunchPad API depends on Heroku Connect for the Salesforce Integration. Each ORM object inherits from `app/models/salesforce_model.rb` to provide one place to manage the integration with Salesforce.

### Security
Ruby on Rails comes with excellent security. We highly recommend you read [this article](https://guides.rubyonrails.org/security.html) to learn more about security in Ruby on Rails.

### Authorization
The LaunchPad API comes installed with the popular [CanCanCan Authorization Gem](https://github.com/CanCanCommunity/cancancan). Authorization of objects and their RESTful actions is built into the API by default. To customize authorization behavior, you can simply modify the `app/models/ability.rb` file.

For example, to prevent users from creating a new `Account`, you could add the following line at the bottom of the `initialize` method.

```ruby
  cannot :create, Account
```

To learn more about configuring Authorization for your application, see the [CanCanCan Wiki](https://github.com/CanCanCommunity/cancancan/wiki).

### Authentication
The LaunchPad API leverages [Basic Auth](https://tools.ietf.org/html/rfc7617) for authenticating incoming API requests and web traffic to the API documentation. By default, the username is `launchpad` and the password is your LaunchPad License Key.

API requests should be sent with the following header:

```
Key: Authorization
Value: Bearer <your Basic Auth token>
```

To get your Basic Auth token, run the following commands:

```term
$ rails c
$ Base64.strict_encode64("launchpad:#{ENV['LAUNCHPAD_LICENSE_KEY']}")
```

### API documentation
The API documentation is generated using [RSpec API Doc Generator](https://github.com/zipmark/rspec_api_documentation). You can customize your API Documentation in `spec/acceptance/api/`. Please [read here](https://github.com/zipmark/rspec_api_documentation) to learn more about creating and modifying your API Documentation.

### Pagination
The LaunchPad API leverages [Kaminari](https://github.com/kaminari/kaminari) in conjunction with the [API Pagination gem](https://github.com/davidcelis/api-pagination) to provide pagination within your API. This approach follows the proposed [RFC-8288](https://tools.ietf.org/html/rfc8288) standard for Web linking by using headers for pagination instead of the response body.

### Serialization
Serialization allows the LaunchPad API to define the JSON that is returned for each object in the API. For example, you may only want to respond with certain attributes or adjust how attributes are formatted in the response.

The LaunchPad API leverages the popular [Active Model Serializers](https://github.com/rails-api/active_model_serializers) for providing this serialization behavior. You can customize this behavior in `app/serializers/`.


### Params sanitization and transformation
One of the core responsibilities for every REST API is to handle incoming data in a secure and reliable way. There are two core aspects to accomplishing this:

1. Remove all incoming data that is not explicitly whitelisted by the application
2. Transform incoming data to the format that your database expects.

The LaunchPad API handles this requirement by leveraging the [Decanter gem](https://github.com/LaunchPadLab/decanter). Every object generated by the API will have a corresponding Decanter object that can be customized in `app/decanters/`.


## Removing the add-on

You can remove launchpad via the CLI:

> warning
> This will destroy all associated data and cannot be undone!

```term
$ heroku addons:destroy launchpad:test
```

## Support

All launchpad support and runtime issues should be submitted via one of the [Heroku Support channels](support-channels).