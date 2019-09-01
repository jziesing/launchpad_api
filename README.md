1. deploy to Heroku
2. Setup Heroku Connect
3. Clone down the repo: `git clone https://github.com/launchpadlab/launchpad_api`
4. bundle
5. Update database.yml (TODO: show steps to find these values in Heroku)
6. Update application.yml
7. Generate models:
- `bundle exec rake db:schema:dump`
- `gem install schema_to_scaffold`
- `pwd` --> copy this path to your clipboard
- Run the following command: `scaffold`
- - paste the path from your clipboard and hit enter
- - pick the tables you want to sync (usually start at 4): `(4..6)` would be tables 4-6
- - for each result, copy/paste and hit enter into terminal. This will generate your model files.
8. `rails s`
9. You should see your REST API