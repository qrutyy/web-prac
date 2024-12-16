class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :telegram_id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :vk_id

      t.timestamps
    end
  end
end
