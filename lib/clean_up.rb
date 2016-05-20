require 'clean_up/version'

require 'clean_up/rules'
require 'clean_up/conditions'
require 'clean_up/folder'
require 'clean_up/folders_rules'
require 'clean_up/option_values'

module CleanUp
  IGNORED_ENTRIES = %w(. .. .DS_Store .localized)

  class << self
    attr_reader :folders_rules

    def define(&block)
      @folders_rules = FoldersRules.collect(&block)
    end

    def check
      Array(folders_rules).each do |folder_rules|
        (Dir.entries(folder_rules.source) - IGNORED_ENTRIES).each do |entry|
          entry_expand_path = folder_rules.expand_path(entry)

          if File.directory?(entry_expand_path)
            folder_rules.process_directory(entry_expand_path) || puts("No match conditions: #{entry}")
          else
            folder_rules.process_file(entry_expand_path) || puts("No match conditions: #{entry}")
          end
        end
      end
    end
  end
end
