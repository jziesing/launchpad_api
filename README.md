1. deploy to Heroku
2. Setup Heroku Connect
3. Clone down the repo: `git clone https://github.com/launchpadlab/launchpad_api`
4. bundle
5. Update database.yml (TODO: show steps to find these values in Heroku)
6. Update application.yml
7. Generate models:
- `bundle exec rake db:schema:dump`
- `bundle exec rake build_models`
- For each file that was generated in app/models, add the following line (replacing account with the right table): `self.table_name = 'salesforce.account'`
- Add the following line to routes.rb (within the block `scope :v1 do`): `create_sweet_actions(:accounts)`
8. In `app/actions/collect_action.rb`, change `authorized?` to return `true`. This is just while we test to make sure the API is working. We'll need to change this back to `false` afterwards.
9. `rails s`
10. Visit one of your REST tables like so `localhost:3000/api/v1/accounts.json`
