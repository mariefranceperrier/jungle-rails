class ChangeUsersTable < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :first_name, limit: 50, null: false
      t.string :last_name, limit: 50, null: false
      t.remove :name
      t.change :email, :string, limit: 50, null: false
      t.string :password_digest, null: false
    end
  end
end
