class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :code
      t.text :content
      t.timestamps
    end
  end
end
