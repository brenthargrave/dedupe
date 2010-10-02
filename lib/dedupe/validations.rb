module Dedupe
  module Validations
    extend ActiveSupport::Concern
    
    included do
      validates_with RecordUniquenessValidator
    end
    
    class RecordUniquenessValidator < ActiveModel::Validator
      def validate(record)
        if record.duplicate?
          record.errors.add :base, "Duplicates existing record"
        end
      end
    end
    
  end
end
