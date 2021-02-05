class InsurancePolicyDecanter < Decanter::Base
  input :name, :string
  input :policy_number, :string
  input :policy_type, :string
  input :effective_date, :date
  input :expiration_date, :date
  input :premium_amount, :float
end
