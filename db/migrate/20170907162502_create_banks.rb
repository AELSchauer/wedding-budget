class CreateBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :banks do |t|
      t.string :mx_id
      t.string :medium_logo_url
      t.string :small_logo_url
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
