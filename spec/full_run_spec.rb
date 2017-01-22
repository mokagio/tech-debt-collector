require "spec_helper"

describe TechDebtCollector do
  context 'when running on a lits of files with tech-debt messages' do
    context 'when the formatter is json' do
      it 'extracts the tech debt messages as pretty JSON string' do
        collector = TechDebtCollector::Collector.new
        output = collector.collect({
          paths: ['./spec/fixtures/*.rb', './spec/fixtures/a-folder/*.swift'],
          formatter: 'json'
        })

        expect(output).to eq %Q([
  {
    "file": "#{Dir.pwd}/spec/fixtures/a-ruby-file.rb",
    "messages": [
      {
        "message": "foo tech debt message"
      },
      {
        "message": "another ruby debt message"
      }
    ]
  },
  {
    "file": "#{Dir.pwd}/spec/fixtures/a-folder/a-swift-file.swift",
    "messages": [
      {
        "message": "Swift debt message"
      }
    ]
  }
])
      end
    end
  end
end
