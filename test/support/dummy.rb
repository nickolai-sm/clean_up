module CleanUp
  module Dummy
    INITIAL_DIR = 'test/dummy/initial_dir'.freeze
    TARGET_DIR = 'test/dummy/target_dir'.freeze
    SOURCE_DIR = 'test/dummy/source_dir'.freeze

    def setup
      FileUtils.cp_r(test_source_files, tmp_source_dir, verbose: ENV['VERBOSE'])
    end

    def teardown
      FileUtils.rm_r(tmp_source_dir)
      FileUtils.rm_r(tmp_target_dir) if Dir.exist?(tmp_target_dir)
    end

      def check_with_initial_state
      assert_equal ['.', '..', '.DS_Store', '03.mp3', 'Covers', 'Report'], Dir.entries(tmp_source_dir)
      assert_equal ['.', '..', 'nigative.jpg', 'oxxxymiron.png'], Dir.entries(File.join(tmp_source_dir, 'Covers'))

      CleanUp.check

      yield
    end

    def test_source_files
      File.absolute_path(INITIAL_DIR)
    end

    def tmp_source_dir
      File.absolute_path(SOURCE_DIR)
    end

    def tmp_target_dir
      File.absolute_path(TARGET_DIR)
    end
  end
end