require "spec_helper"

describe TechDebtCollector do
  it "has a version number" do
    expect(TechDebtCollector::VERSION).not_to be nil
  end

  it 'returns all the files matching the given path' do
    files = TechDebtCollector::collect_file_paths('./spec/fixtures/*.rb')
    expect(files).to eq(["#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/another-ruby-file.rb"])
  end

  it 'returns all the files matching the given paths' do
    files = TechDebtCollector::collect_file_paths(['./spec/fixtures/*.rb', './spec/fixtures/**/*.swift'])
    expect(files).to eq(["#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/another-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/a-folder/a-swift-file.swift"])
  end
end
