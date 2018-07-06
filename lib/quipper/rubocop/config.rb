require "thor"


module Quipper
  module Rubocop
    module Config
      class CLI < Thor

        RUBOCOP_CONFIG_FILE_NAME = ".rubocop.yml"
        RUBOCOP_TODO_FILE_NAME = ".rubocop_todo.yml"
        GITHOOK_FILE_PATH = ".git/hooks/pre-push"

        desc "install", "Install rubocop config"
        option :todo
        option :hook
        option :all
        def install
          create_rubocop_config!(RUBOCOP_CONFIG_FILE_NAME)
          create_rubocop_todo_file! if options[:todo] || options[:all]
          create_prepush_hook!(GITHOOK_FILE_PATH) if options[:hook] || options[:all]
        end

        desc "uninstall", "uninstall rubocop config"
        def uninstall
          remove_file(RUBOCOP_CONFIG_FILE_NAME)
          remove_file(RUBOCOP_TODO_FILE_NAME)
          remove_file(GITHOOK_FILE_PATH)

          puts "Uninstallation complete"
        end

        private

        def template_path
          File.expand_path("../../../templates", __dir__)
        end

        def create_rubocop_config!(config_file_name)
          puts "#{File.exist?(config_file_name) ? "overwrite" : "create"} #{config_file_name}"
          FileUtils.copy_file(File.join(template_path, config_file_name), config_file_name)
        end

        def create_rubocop_todo_file!
          puts "creating rubocop todo file"
          system "rubocop --auto-gen-config"
        end

        def create_prepush_hook!(file_path)
          puts "adding git prepush hook"
          puts "#{File.exist?(file_path) ? "overwrite" : "create"} #{file_path}"

          unless File.directory?(".githooks")
            FileUtils.mkdir_p(".githooks")
          end

          FileUtils.copy_file(File.join(template_path, file_path), file_path)
          FileUtils.chmod(0755, file_path)
        end

        def remove_file(file_path)
          if File.exist?(file_path)
            File.delete(file_path)
            puts "Removing #{file_path}"
          end
        end
      end
    end
  end
end
