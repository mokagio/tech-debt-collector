require "spec_helper"

describe TechDebtCollector do
  context 'when running on a lits of files with tech-debt messages' do
    it 'extracts the tech debt messages as a map' do
      collector = TechDebtCollector::Collector.new
      debts = collector.collect({
        paths: ['./spec/fixtures/*.rb', './spec/fixtures/a-folder/*.swift']
      })

      expect(debts).to eq [
        { 
          file: "#{Dir.pwd}/spec/fixtures/a-ruby-file.rb", 
          messages: [
            { message: 'foo tech debt message' },
            { message:'another ruby debt message' }
          ] 
        },
        { 
          file: "#{Dir.pwd}/spec/fixtures/a-folder/a-swift-file.swift",
          messages: [
            { message: 'Swift debt message' },
          ] 
        },
      ]
    end
  end
end
