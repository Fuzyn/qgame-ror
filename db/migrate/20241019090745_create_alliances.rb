class CreateAlliances < ActiveRecord::Migration[7.0]
  def change
    create_table :alliances do |t|
      t.text :name
      t.text :short

      t.timestamps
    end

    add_reference :users, :alliance, index: true, foreign_key: true
  end
end
