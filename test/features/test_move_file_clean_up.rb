require_relative '../test_helper'

class TestMoveFileCleanUp < Minitest::Test
  include CleanUp::Dummy

  def test_move_file_inside_source_dir
    CleanUp.define do
      source SOURCE_DIR
      target TARGET_DIR

      move_files_to 'Music' do
        extension 'mp3'
      end
    end

    check_with_initial_state do
      assert_equal ['.', '..', '.DS_Store', 'Covers', 'Report'], Dir.entries(tmp_source_dir)

      assert_equal ['.', '..', 'Music'], Dir.entries(tmp_target_dir)

      assert_equal ['.', '..', '03.mp3'], Dir.entries(File.join(tmp_target_dir, 'Music'))
    end
  end

  def test_move_files_inside_sub_directory
    CleanUp.define do
      source SOURCE_DIR
      target TARGET_DIR

      directory do
        move_files_to 'Pictures' do
          extension 'jpg', 'png'
        end
      end
    end

    check_with_initial_state do
      assert_equal ['.', '..', 'Pictures'], Dir.entries(tmp_target_dir)

      assert_equal ['.', '..', 'nigative.jpg', 'oxxxymiron.png'], Dir.entries(File.join(tmp_target_dir, 'Pictures'))
    end
  end
end
