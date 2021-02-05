# seeds file runs every deployment since it is a task in the release
# I couldn't figure out a way to trigger a rake task via Heroku Platform API other than using the release mechanism
if AdminUser.count == 0 # only run once
  AdminUser.create(email: 'admin@example.com', password: 'password')
end

InsurancePolicy.create(
  name: 'Tesla Model 3',
  policy_number: '412983819',
  effective_date: Date.today,
  expiration_date: Date.today + 1.year,
  premium_amount: 200.00,
  policy_type: 'Auto',
)

InsurancePolicy.create(
  name: 'Volvo SUV',
  policy_number: '1928471829',
  effective_date: Date.today - 5.months,
  expiration_date: Date.today + 7.months,
  policy_type: 'Auto',
)

Claim.create(
  claim_number: '123918274',
  initiation_date: Date.today,
  amount: 500.00,
  approved_amount: 400.00,
  claim_reason: 'Car accident',
)

Claim.create(
  claim_number: '2123871273',
  initiation_date: Date.today - 2.months,
  amount: 2000.00,
  approved_amount: 2000.00,
  claim_reason: 'Car accident',
)