FactoryBot.define do
  factory :insurance_policy do
    name { "MyString" }
    policy_number { "MyString" }
    policy_type { "MyString" }
    effective_date { "2021-02-04" }
    expiration_date { "2021-02-04" }
    premium_amount { 1.5 }
  end
end
