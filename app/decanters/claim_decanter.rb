class ClaimDecanter < Decanter::Base
  input :claim_number, :string
  input :initiation_date, :date
  input :amount, :float
  input :approved_amount, :float
  input :claim_reason, :text
end
