class CreateCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :credentials do |t|
      t.string :field_name
      t.string :mx_id
      t.string :field_label
      t.string :field_type
      t.references :bank, foreign_key: true

      t.timestamps
    end
  end
end
