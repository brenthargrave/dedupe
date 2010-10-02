require 'dedupe/errors'
require 'dedupe/validations'
require 'dedupe/orm/mongoid'
require 'dedupe/orm/active_record'

module Dedupe
  extend ActiveSupport::Concern
  
  included do
    cattr_accessor :dedupe_scope_name
  end
  
  module ClassMethods
    
    def validates_uniqueness(options={})
      self.dedupe_scope_name = options.delete :using
      if defined?(Mongoid::Document) && self.new.is_a?(Mongoid::Document)
        self.send :include, Orm::Mongoid
      elsif defined?(ActiveRecord::Base) && self.new.is_a?(ActiveRecord::Base)
        self.send :include, Orm::ActiveRecord
      end
      self.send :include, Validations
    end
    
  end
  
end

Mongoid::Document.send :include, Dedupe if defined? Mongoid::Document
ActiveRecord::Base.send :include, Dedupe if defined? ActiveRecord::Base