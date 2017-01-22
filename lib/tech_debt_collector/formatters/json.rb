require 'json'

module TechDebtCollector
  class JSONFormatter
    def self.format(messages)
      JSON.pretty_generate(messages)
    end
  end
end
