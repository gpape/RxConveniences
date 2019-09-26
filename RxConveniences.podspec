Pod::Spec.new do |spec|

  spec.name = "RxConveniences"
  spec.version = "1.0.1"
  spec.summary = "Small conveniences for writing concise, expressive RxSwift."
  spec.description = <<-DESC
RxConveniences provides a set of conveniences and utilities for making
practical RxSwift/RxCocoa code a bit more concise and expressive.
                   DESC
  spec.homepage = "https://github.com/gpape/RxConveniences"
  spec.license = "MIT"
  spec.author = "Greg Pape"
  spec.platform = :ios, "12.0"
  spec.swift_versions = ['5.1', '5.2']
  spec.source = { :git => "https://github.com/gpape/RxConveniences.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.swift"

  spec.dependency 'CollectiveSwift', '~> 2.1'
  spec.dependency 'RxCocoa', '~> 5.0'
  spec.dependency 'RxSwift', '~> 5.0'

end
