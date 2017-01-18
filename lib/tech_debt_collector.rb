require "tech_debt_collector/version"

module TechDebtCollector
  def self.collect_file_paths(patterns)
    patterns = [patterns] if patterns.is_a?(String)
    return [] unless patterns.is_a?(Array)
    Dir.glob(patterns.map { |p| File.expand_path(p, Dir.pwd) })
  end
end
