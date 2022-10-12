# frozen_string_literal: true

require_relative "lib/jekyll-srcset-hook/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-srcset-hook"
  spec.version = Jekyll::SrcsetHook::VERSION
  spec.authors = ["Jocelyn Gaudette"]
  spec.email = ["95389546+juicy-g@users.noreply.github.com"]

  spec.summary =
    "A Jekyll plugin to add srcset and sizes attributes to images without using Liquid tags."
  spec.homepage = "https://github.com/juicy-g/jekyll-srcset-hook"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata[
    "source_code_uri"
  ] = "https://github.com/juicy-g/jekyll-srcset-hook"
  spec.metadata[
    "changelog_uri"
  ] = "https://github.com/juicy-g/jekyll-srcset-hook/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(__dir__) do
      `git ls-files -z`.split("\x0")
                       .reject do |f|
        (f == __FILE__) ||
          f.match(
            %r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)}
          )
      end
    end
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.13", ">= 1.13.8"
end
