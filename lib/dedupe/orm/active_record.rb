module Dedupe
  module Orm
    module ActiveRecord
      extend ActiveSupport::Concern
      include Errors
      
      included do
        scope :excluding, lambda { |instance|
          where('id <> ?', instance.id.to_i)
        }
      end
      
      def duplicates
        klass, scope_name = self.class, self.class.dedupe_scope_name
        raise MissingScope unless klass.respond_to? scope_name 
        result_set = klass.send scope_name, self 
        raise InvalidScope unless result_set.is_a? ::ActiveRecord::Relation
        result_set.excluding self 
      end
        
      def duplicate?
        self.duplicates.present?
      end
      
    end
  end
end
