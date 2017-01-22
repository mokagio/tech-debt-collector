require "tech_debt_collector/version"
require 'tech_debt_collector/formatters/json'

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

  def self.extract_tech_debt_messages(lines)
    debt = []
    lines.each do |line|
      next unless line =~ /\A(\/\/|#) tech-debt/

      tech_debt_message_regex = /\A(\/\/|#) tech-debt: /
      if line =~ tech_debt_message_regex
        message = line.gsub(/\A(\/\/|#) tech-debt: /, '')
        debt.push({ message: message })
      end
    end
    debt
  end

  class Collector

    def collect(options)
      paths = options[:paths] || ['./**/*']
      formatter = options[:formatter].to_sym || :json

      debts = TechDebtCollector::get_files_hashes_for_paths(TechDebtCollector::collect_file_paths(paths))
      .map do |hash|
        {
          file: hash[:path],
          messages: TechDebtCollector::extract_tech_debt_messages(
            TechDebtCollector::format_lines(hash[:lines])
          )
        }
      end
      .reject { |debt| debt[:messages].empty? }

      case formatter
      when :json
        return TechDebtCollector::JSONFormatter.format(debts)
      end
    end
  end
end
