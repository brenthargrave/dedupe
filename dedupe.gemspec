# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dedupe"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Hargrave"]
  s.date = "2012-06-09"
  s.description = "ActiveModel validation against duplicating records."
  s.email = "brent.hargrave@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "dedupe.gemspec",
    "lib/dedupe.rb",
    "lib/dedupe/errors.rb",
    "lib/dedupe/orm/active_record.rb",
    "lib/dedupe/orm/mongoid.rb",
    "lib/dedupe/validations.rb",
    "spec/dedupe_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/active_record.rb",
    "spec/support/mongoid.rb"
  ]
  s.homepage = "http://github.com/jamescallmebrent/dedupe"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "ActiveModel validation against duplicating records."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["< 4.0.0", ">= 3.0.0"])
      s.add_runtime_dependency(%q<activemodel>, ["< 4.0.0", ">= 3.0.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<mongoid>, [">= 0"])
      s.add_development_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, ["< 4.0.0", ">= 3.0.0"])
      s.add_dependency(%q<activemodel>, ["< 4.0.0", ">= 3.0.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["< 4.0.0", ">= 3.0.0"])
    s.add_dependency(%q<activemodel>, ["< 4.0.0", ">= 3.0.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
  end
end

