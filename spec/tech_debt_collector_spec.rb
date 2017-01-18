require "spec_helper"

describe TechDebtCollector do
  it "has a version number" do
    expect(TechDebtCollector::VERSION).not_to be nil
  end

  describe 'collect_file_paths' do
    it 'returns all the files matching the given path' do
      files = TechDebtCollector::collect_file_paths('./spec/fixtures/*.rb')
      expect(files).to eq(["#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/another-ruby-file.rb"])
    end

    it 'returns all the files matching the given paths' do
      files = TechDebtCollector::collect_file_paths(['./spec/fixtures/*.rb', './spec/fixtures/**/*.swift'])
      expect(files).to eq(["#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/another-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/a-folder/a-swift-file.swift"])
    end
  end

  describe 'get_files_hashes_for_paths' do
    it 'returns an array of dictionaries with the file paths' do
      paths = ["#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/another-ruby-file.rb"]
      hashes = TechDebtCollector::get_files_hashes_for_paths(paths)

      expect(hashes.count).to eq 2
      expect(hashes.first[:path]).to eq paths.first
      expect(hashes.last[:path]).to eq paths.last
    end

    it 'returns an array of dictionaries with the file lines' do
      paths = ["#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", "#{Dir.pwd}/spec/fixtures/another-ruby-file.rb"]
      hashes = TechDebtCollector::get_files_hashes_for_paths(paths)

      expect(hashes.count).to eq 2
      expect(hashes.first[:lines]).to eq ["def foo\n", "  puts \"foo\"\n", "end\n"]
      expect(hashes.last[:lines]).to eq ["def bar\n", "  puts \"bar\"\n", "end\n"]
    end
  end
end
