require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

shared_examples_for "any Dedupe helper method" do
  it "should raise error if validates_uniqueness omitted" do
    instance ||= @macroless_model.new
    lambda do 
      instance.send(@method_name)
    end.should raise_error(NoMethodError)
  end
end
shared_examples_for "any Dedupe instance method" do
  it "should raise error if scope omitted" do
    instance = @scopeless_model.new
    lambda do
      instance.send(@method_name)
    end.should raise_error(Dedupe::Errors::MissingScope)
  end
  it "should raise error if scope returns a non-criterion" do
    instance = @invalid_scope_model.new
    lambda do
      instance.send(@method_name)
    end.should raise_error(Dedupe::Errors::InvalidScope)
  end
end

shared_examples_for "any supported ORM" do
  context "finding" do
    context "all but a provided instance (excluding)" do
      before do
        @existing = @model.create!(:foo => 'a', :bar => 'b')
        @others = []
        @others << @model.create!(:foo => 'd', :bar => 'e')
        @others << @model.create!(:foo => 'g', :bar => 'g')
        @found = @model.excluding(@existing).to_a
      end
      it "should not include that instance" do
        @found.should_not include(@existing)
      end
      it "should include all other instances" do
        @others.all? { |instance| @found.include?(instance) }.should be_true
      end
      it "should raise error if validates_uniqueness omitted" do
        lambda do
          @macroless_model.excluding 
        end.should raise_error(NoMethodError)
      end
    end
    context 'duplicates of a provided instance (dev-defined scope/finder)' do
      before do
        @existing = @model.create! :foo => 'foo', :bar => 'bar'
        @unique_bar = @model.create! :foo => 'foo', :bar => 'unique'
        @unique_foo = @model.create! :foo => 'unique', :bar => 'bar'
        @duplicate = @model.new :foo => 'foo', :bar => 'bar'
        @found = @model.with_attributes_of(@duplicate).to_a
      end
      it 'should exclude instances with only *some* duplicate attributes' do
        @found.should_not include(@unique_foo)
        @found.should_not include(@unique_bar)
      end
      it 'should include instances with duplicate attributes' do
        @found.should include(@existing)
      end
    end
  end
  context "instance" do
    context "duplicates" do
      before do
        @method_name = "duplicates"
        @existing = @model.create! :foo => 'a', :bar => 'b'
        @other = @model.create! :foo => 'c', :bar => 'd'
        @proposed = @model.new :foo => 'a', :bar => 'b'
      end
      it "should include its duplicate" do
        @proposed.duplicates.should include(@existing)
      end
      it "should exclude non-duplicates" do
        @proposed.duplicates.should_not include(@other)
      end
      it "should exclude itself" do
        @existing.duplicates.should_not include(@existing)
      end
      it_should_behave_like "any Dedupe helper method"
      it_should_behave_like "any Dedupe instance method"
    end
    context "duplicate?" do
      before do
        @method_name = "duplicate?"
        @existing = @model.create! :foo => 'a', :bar => 'b'
        @duplicate = @model.new :foo => 'a', :bar => 'b'
        @non_duplicate = @model.new :foo => 'c', :bar => 'd'
      end
      it "duplicate? should be true if it has duplicates" do
        @duplicate.should be_duplicate
      end
      it "duplicate? should be false if it lacks duplicates" do
        @non_duplicate.should_not be_duplicate
      end
      # shared behavior?
      it_should_behave_like "any Dedupe helper method"
      it_should_behave_like "any Dedupe instance method"
    end
    context "validation (valid?)" do
      before do
        @method_name = "valid?"
        @existing = @model.create! :foo => 'a', :bar => 'b'
        @duplicate = @model.new :foo => 'a', :bar => 'b'
        @non_duplicate = @model.new :foo => 'c', :bar => 'd'
      end
      it "with unique attributes should be true" do
        @non_duplicate.should be_valid
      end
      context "with duplicate attributes" do
        it "should be false" do
          @duplicate.should_not be_valid
        end
        it "should add an error" do
          @duplicate.valid? # call valid 
          @duplicate.errors[:base].should include "Duplicates existing record"
        end
      end
      it_should_behave_like "any Dedupe instance method"
    end
  end
end

describe "Mongoid model" do
  before do
    @macroless_model = MongoidMacrolessModel
    @scopeless_model = MongoidScopelessModel
    @invalid_scope_model = MongoidInvalidScopeModel
    @model = MongoidModel
  end
  it_should_behave_like "any supported ORM"
end

describe "ActiveRecord model" do
  before do
    @macroless_model = ActiveRecordMacrolessModel
    @macroless_model.destroy_all
    @scopeless_model = ActiveRecordScopelessModel
    @scopeless_model.destroy_all
    @invalid_scope_model = ActiveRecordInvalidScopeModel
    @invalid_scope_model.destroy_all
    @model = ActiveRecordModel
    @model.destroy_all
  end
  it_should_behave_like "any supported ORM"
end
