class AddTimeToTrainings < ActiveRecord::Migration[5.2]
  def change
    add_column :trainings, :time, :string
  end
end
