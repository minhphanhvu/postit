class ChangeGroupsUsersToMemberships < ActiveRecord::Migration[6.1]
  def change
    rename_table :groups_users, :memberships
  end
end
