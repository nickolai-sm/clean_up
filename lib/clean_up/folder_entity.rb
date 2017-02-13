module CleanUp
  class FolderEntity
    IGNORED_ENTRIES = %w(. .. .DS_Store .localized rules.rb).freeze

    attr_reader :source

    def initialize(source)
      @source = source
    end

    # TODO: use partition
    def folders
      @folders || assign_attributes && @folders
    end

    def files
      @files || assign_attributes && @files
    end

    private

    def assign_attributes
      @folders, @files = entries.partition { |entry| File.directory?(entry) }
    end

    def entries
      @entries ||= (Dir.entries(@source) - IGNORED_ENTRIES).map do |entry|
        File.absolute_path(entry, @source)
      end
    end
  end
end