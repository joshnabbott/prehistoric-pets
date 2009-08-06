# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{query-analyzer}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Eberly and Todd Tyree"]
  s.date = %q{2009-02-07}
  s.description = %q{Run explain on all the sql queries rails generates.}
  s.email = %q{todd@snappl.co.uk}
  s.extra_rdoc_files = ["lib/query_analyzer.rb", "README.rdoc"]
  s.files = ["init.rb", "lib/query_analyzer.rb", "Rakefile", "README.rdoc", "Manifest", "query-analyzer.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tatyree/cookieless_sessions}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Query-analyzer", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{query-analyzer}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Run explain on all the sql queries rails generates.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
