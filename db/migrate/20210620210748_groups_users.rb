class GroupsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :groups_users do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
    end
  end
end
