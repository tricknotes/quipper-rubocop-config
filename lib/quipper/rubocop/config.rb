# frozen_string_literal: true

require "thor"
require "erb"

module Quipper
  module Rubocop
    module Config
      class CLI < Thor
        RUBOCOP_CONFIG_FILE_NAME = ".rubocop.yml"
        RUBOCOP_TODO_FILE_NAME = ".rubocop_todo.yml"
        GITHOOK_FILE_PATH = ".git/hooks/pre-push"

        desc "install", "Install rubocop config"
        option :with_todo
        def install
          create_rubocop_config!(RUBOCOP_CONFIG_FILE_NAME)
          create_rubocop_todo_file! if options[:with_todo]
        end

        desc "install_prepush", "Install prepush hook"
        def install_prepush
          create_prepush_hook!(GITHOOK_FILE_PATH)
        end

        desc "uninstall", "uninstall rubocop config"
        option :hook
        def uninstall
          remove_file(RUBOCOP_CONFIG_FILE_NAME) unless options[:hook]
          remove_file(RUBOCOP_TODO_FILE_NAME) unless options[:hook]
          remove_file(GITHOOK_FILE_PATH)

          puts "Uninstallation complete"
        end

        private

        def create_rubocop_config!(config_file_name)
          puts "#{File.exist?(config_file_name) ? 'overwrite' : 'create'} #{config_file_name}"
          FileUtils.copy_file(File.join(template_path, config_file_name), config_file_name)
        end

        def create_rubocop_todo_file!
          puts "creating rubocop todo file"
          system "rubocop --auto-gen-config"
        end

        def create_prepush_hook!(file_path)
          puts "adding git prepush hook at #{file_path}"

          raise "File already exists at #{file_path}" if File.exist?(file_path)

          hook_template = File.join(template_path, ".githooks/pre-push.erb")
          @branch_name = ask("What is the name of the branch you would like to compare to? (usually master or develop)")
          hook_template = ERB.new(File.read(hook_template)).result(binding)
          File.open(file_path, "w+") do |f|
            f.write(hook_template)
          end
          FileUtils.chmod(0755, file_path)
          puts "hook created!"
        end

        def remove_file(file_path)
          if File.exist?(file_path) && added_by_this_gem?(file_path)
            File.delete(file_path)
            puts "Removing #{file_path}"
          end
        end

        def template_path
          File.expand_path("../../../templates", __dir__)
        end

        def added_by_this_gem?(file_name)
          File.read(file_name).include?("quipper-rubocop-config")
        end
      end
    end
  end
end
