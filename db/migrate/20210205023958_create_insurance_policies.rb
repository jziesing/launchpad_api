class CreateInsurancePolicies < ActiveRecord::Migration[5.2]
  def change
    create_table :insurance_policies do |t|
      t.string :name
      t.string :policy_number
      t.string :policy_type
      t.date :effective_date
      t.date :expiration_date
      t.float :premium_amount

      t.timestamps
    end
  end
end
