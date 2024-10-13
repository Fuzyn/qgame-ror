class CreateBuildQueue < ActiveRecord::Migration[7.0]
  def change
    create_table :build_queues do |t|
      t.references :user, foreign_key: true, index: true
      t.string :user_email
      t.string :key
      t.string :source
      t.integer :quantity
      t.datetime :end_time
      t.string :secret_hash
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
