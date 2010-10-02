module Dedupe
  module Orm
    module Mongoid
      extend ActiveSupport::Concern
      
      included do
        scope :excluding, lambda { |instance|
          excludes(:id => instance.id)
        }
      end
      
      module InstanceMethods
        include Errors
        
        def duplicates
          klass, scope_name = self.class, self.class.dedupe_scope_name
          raise MissingScope unless klass.respond_to? scope_name 
          result_set = klass.send scope_name, self 
          raise InvalidScope unless result_set.is_a? ::Mongoid::Criteria
          result_set.excluding self 
        end
        
        def duplicate?
          self.duplicates.present?
        end
        
      end
      
    end
  end
end