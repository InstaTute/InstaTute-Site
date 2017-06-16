class AddStripeIdToTutors < ActiveRecord::Migration[5.0]
  def change
    add_column :tutors, :stripe_id, :string
  end
end
