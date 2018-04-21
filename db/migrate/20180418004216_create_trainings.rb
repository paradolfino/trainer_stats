class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.string :member
      t.string :company
      t.string :trainer
      t.string :stage
      t.string :status
      t.text :notes
      t.references :log
      t.timestamps
    end
  end
end
