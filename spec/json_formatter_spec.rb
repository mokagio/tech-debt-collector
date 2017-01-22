require 'spec_helper'

describe 'JSONFormatter' do
  it 'formats the given messages as JSON' do
    messages = [
      { file: 'a/path/to/a/file', messages: [
        { message: 'foo' },
        { message: 'bar' }
      ] },
      { file: 'a/path/to/another/file', messages: [
        { message: 'baz' }
      ] }
    ]

    expect(TechDebtCollector::JSONFormatter.format(messages)).to eq %q([
  {
    "file": "a/path/to/a/file",
    "messages": [
      {
        "message": "foo"
      },
      {
        "message": "bar"
      }
    ]
  },
  {
    "file": "a/path/to/another/file",
    "messages": [
      {
        "message": "baz"
      }
    ]
  }
])
  end
end
