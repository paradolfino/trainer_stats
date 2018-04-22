class Training < ApplicationRecord
    belongs_to :log
    def self.to_csv(options = {})
        items = 0
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |training|
            items += 1
          csv << training.attributes.values_at(*column_names)
        end
        csv << ["Trainings", items]
      end
    end
end
