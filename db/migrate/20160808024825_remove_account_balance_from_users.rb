class RemoveAccountBalanceFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :account_balance, :decimal
  end
end
