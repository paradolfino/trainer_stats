class AddDateToTrainings < ActiveRecord::Migration[5.2]
  def change
    add_column :trainings, :date, :string
  end
end
