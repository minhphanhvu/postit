class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.references :user
      t.references :voteable, polymorphic: true

      t.timestamps
    end
  end
end
