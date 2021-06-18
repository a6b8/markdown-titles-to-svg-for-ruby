# frozen_string_literal: true

require_relative "lib/markdown_titles_to_svg/version"

Gem::Specification.new do |spec|
  spec.name          = "markdown_titles_to_svg"
  spec.version       = MarkdownTitlesToSvg::VERSION
  spec.authors       = ["a6b8"]
  spec.email         = ["hello@13plu4.com"]

  spec.summary       = "Generate Headlines for (multiple) Github Markdown Pages"
  spec.description   = "Generate beautiful Headlines with Google Fonts for (multiple) Github Markdown Pages."
  spec.homepage      = "https://github.com/a6b8/markdown-titles-to-svg-for-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/a6b8/markdown-titles-to-svg-for-ruby"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/a6b8/markdown-titles-to-svg-for-ruby/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem

  spec.add_dependency 'text2svg', '0.5.1'
  spec.add_dependency 'nokogiri', '1.11.7'
  # spec.add_dependency 'net/http'
  spec.add_dependency 'fileutils', '1.5.0'
  #  spec.add_dependency 'active_support/core_ext/hash/indifferent_access'
  spec.add_dependency 'json', '2.5.1'
  spec.add_dependency 'zip', '2.0.2'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
