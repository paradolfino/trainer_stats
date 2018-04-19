class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.string :member
      t.string :company
      t.references :log
      t.timestamps
    end
  end
end
