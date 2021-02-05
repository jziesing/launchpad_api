FactoryBot.define do
  factory :claim do
    claim_number { "MyString" }
    initiation_date { "2021-02-04" }
    amount { 1.5 }
    approved_amount { 1.5 }
    claim_reason { "MyText" }
  end
end
