class CreateCancellations < ActiveRecord::Migration[5.2]
  def change
    create_table :cancellations do |t|
      t.string :member
      t.string :company
      t.string :reason
      t.text :notes
      t.references :cancellation_log, foreign_key: true

      t.timestamps
    end
  end
end
