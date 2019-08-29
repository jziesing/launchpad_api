<!-- # <app_name> -->

## Getting Started
### Initial Project Setup
If you created this project, instructions for setting up GitHub, Heroku, and other integrations can be found in the **[Project Setup Checklist](PROJECT_SETUP_CHECKLIST.md)**.

### Running in Development
<!-- TODO: update the below accordingly -->
- `git clone git@github.com:LaunchPadLab/<project_name>.git`
- `cd <project_name>`
- `bundle install`
- `load_secrets`
- `bundle exec rake db:create db:migrate db:seed`
- `rails server`
- `open localhost:3000`

<!--
  TODO: Additional notes about your app
This application supports both server rendering and client rendering of react components from within `ERB` templates.
Starting the application with `foreman start -f Profile.dev` starts the rails server as well as the webpack-dev-server that will rebuild the javascript assets on change.
It's possible that a page refresh completes BEFORE webpack finishes, just refresh again or check the log to make sure the rebuild has completed if you don't see your changes right away.
If this becomes an issue we can revisit to either optimize the build or add HMR.
 -->
### Development Workflow

#### Committing
Pull requests to the `dev` branch will trigger review apps in Heroku.
The `staging` branch will auto-deploy to the *staging* environment on Heroku.
The `master` branch can then be deployed to *production* after successful QA.

#### Testing
All Ruby/Rails unit tests must pass for a PR to be merged. They can be run locally with:

- Ruby/Rails unit tests: `bundle exec rspec`

#### Linting
The project is set up to lint ruby, <!-- javascript and scss (`TODO`) --> so its advised that you have this integrated in your editor.
Currently, linting errors will not block a PR merge, but this may change in the future.

You can run these manually with:
- Ruby: `rubocop` (if installed globally with `gem install rubocop`)
<!-- + JavaScript: `npm run eslint` -->
