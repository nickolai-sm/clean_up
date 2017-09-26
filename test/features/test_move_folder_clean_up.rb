require 'minitest/autorun'
require 'fileutils'
require 'clean_up'

# require_relative '../test_helper'

class TestMoveFolderCleanUp < Minitest::Test
  INITIAL_DIR = 'test/dummy/initial_dir'.freeze
  TARGET_DIR  = 'test/dummy/target_dir'.freeze
  SOURCE_DIR  = 'test/dummy/source_dir'.freeze

  def setup
    FileUtils.cp_r(test_source_files, tmp_source_dir, verbose: ENV['VERBOSE'])

    CleanUp.define do
      source SOURCE_DIR
      target TARGET_DIR

      move_directories_to 'Pictures' do
        file do
          extension 'jpg'
        end
      end

      directory do
        pattern 'Report'

        move_directories_to 'Reports' do
          file do
            extension 'txt'
          end
        end
      end

      move_directories_to 'Trash' do
        pattern 'Report'
      end
    end
  end

  def test_file_move
    assert_equal ['.', '..', '.DS_Store', '03.mp3', 'Covers', 'Report'], Dir.entries(tmp_source_dir)
    assert_equal ['.', '..', 'nigative.jpg', 'oxxxymiron.png'], Dir.entries(File.join(tmp_source_dir, 'Covers'))
    assert_equal ['.', '..', '12.12.2016'], Dir.entries(File.join(tmp_source_dir, 'Report'))
    assert_equal ['.', '..', 'sales.txt'], Dir.entries(File.join(tmp_source_dir, 'Report', '12.12.2016'))

    CleanUp.check

    assert_equal ['.', '..', '.DS_Store', '03.mp3'], Dir.entries(tmp_source_dir)

    assert_equal ['.', '..', 'Pictures', 'Reports', 'Trash'], Dir.entries(tmp_target_dir)

    assert_equal ['.', '..', 'Covers'], Dir.entries(File.join(tmp_target_dir, 'Pictures'))

    assert_equal ['.', '..', '12.12.2016'], Dir.entries(File.join(tmp_target_dir, 'Reports'))

    assert_equal ['.', '..', 'Report'], Dir.entries(File.join(tmp_target_dir, 'Trash'))
    assert_equal ['.', '..', 'nigative.jpg', 'oxxxymiron.png'], Dir.entries(File.join(tmp_target_dir, 'Pictures', 'Covers'))
  end

  def teardown
    FileUtils.rm_r(tmp_source_dir)
    FileUtils.rm_r(tmp_target_dir)
  end

  private

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
