ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
                                        :database => ':memory:'
ActiveRecord::Migration.verbose = false
tables = %w{ active_record_macroless_models active_record_scopeless_models active_record_invalid_scope_models active_record_models }
ActiveRecord::Schema.define(:version => 1) do
  tables.each do |table_name|
    create_table table_name.intern, :force => true do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :foo
      t.string   :bar
    end
  end
end

# a "vanilla" ActiveRecord model
class ActiveRecordMacrolessModel < ActiveRecord::Base
end
# ActiveRecord model with macro included, but required scope "forgotten"
class ActiveRecordScopelessModel < ActiveRecordMacrolessModel
  validates_uniqueness :using => :with_attributes_of
end
# ActiveRecord model with gem improperly implemented
# returns an instance of Array instead of Criteria
class ActiveRecordInvalidScopeModel < ActiveRecordScopelessModel
  def self.with_attributes_of(instance)
    where(:foo => instance.foo, :bar => instance.bar).to_a
  end
end
# ActiveRecord model with gem properly implemented
class ActiveRecordModel < ActiveRecordScopelessModel
  def self.with_attributes_of(instance)
    where(:foo => instance.foo, :bar => instance.bar)
  end
end
