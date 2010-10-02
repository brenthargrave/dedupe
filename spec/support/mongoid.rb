Mongoid.configure do |config|
  name = "mongoid_test"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  config.logger = nil
end

RSpec.configure do |config|
  config.before do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end

# a "vanilla" Mongoid model
class MongoidMacrolessModel
  include Mongoid::Document
  field :foo
  field :bar
  field :baz
end

# a Mongoid model with macro included, but required scope "forgotten"
class MongoidScopelessModel < MongoidMacrolessModel
  validates_uniqueness :using => :with_attributes_of
end

# a Mongoid model with gem improperly implemented
# returns an instance of Array instead of Criteria
class MongoidInvalidScopeModel < MongoidScopelessModel
  def self.with_attributes_of(instance)
    where(:foo => instance.foo, :bar => instance.bar).to_a
  end
end

# a Mongoid model with gem properly implemented
class MongoidModel < MongoidScopelessModel
  def self.with_attributes_of(instance)
    where(:foo => instance.foo, :bar => instance.bar)
  end
end
