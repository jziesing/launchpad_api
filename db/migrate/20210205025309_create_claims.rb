class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :claims do |t|
      t.string :claim_number
      t.date :initiation_date
      t.float :amount
      t.float :approved_amount
      t.text :claim_reason

      t.timestamps
    end
  end
end
