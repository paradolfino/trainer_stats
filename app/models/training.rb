class Training < ApplicationRecord
    belongs_to :log
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |training|
          csv << training.attributes.values_at(*column_names)
        end
      end
    end
end
