require "tech_debt_collector/version"

module TechDebtCollector
  def self.collect_file_paths(patterns)
    patterns = [patterns] if patterns.is_a?(String)
    return [] unless patterns.is_a?(Array)
    Dir.glob(patterns.map { |p| File.expand_path(p, Dir.pwd) })
  end

  def self.get_files_hashes_for_paths(paths)
    t = []
    paths.each do |path|
      t.push({
        path: path,
        lines: File.read(path).lines
      })
    end
    return t
  end

  def self.format_lines(lines)
    lines.map { |l| l.strip }
  end
end
