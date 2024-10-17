class CreateUserMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :user_messages do |t|
      t.references :user, foreign_key: true, index: true
      t.text :title
      t.text :message
      t.text :message_type
      t.datetime :read_date

      t.timestamps
    end
  end
end
