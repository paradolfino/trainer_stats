class CreateCancellationLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :cancellation_logs do |t|
      t.string :title

      t.timestamps
    end
  end
end
