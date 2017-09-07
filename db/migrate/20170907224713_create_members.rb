class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :mx_id
      t.string :status
      t.references :bank, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
