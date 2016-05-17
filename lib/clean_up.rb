require 'clean_up/version'

require 'clean_up/rules'
require 'clean_up/conditions'
require 'clean_up/folder'
require 'clean_up/folders_rules'
require 'clean_up/option_values'

module CleanUp
  class << self
    attr_reader :folders_rules

    def define(&block)
      @folders_rules = FoldersRules.collect(&block)
    end

    def check
      Array(folders_rules).each do |folder_rules|
        Dir.entries(folder_rules.source).each do |entry|
          if File.directory?(entry)
            folder_rules.process_directory(entry)
          else
            folder_rules.process_file(entry)
          end
        end
      end
    end
  end
end
