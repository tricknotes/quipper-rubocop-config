require 'thor'

module Quipper
  module Rubocop
    module Config
      class CLI < Thor

        CONFIG_FILE_NAME = ".rubocop.yml"
        GITHOOK_FILE_PATH = ".githook/prepush"
        desc "install", "Install rubocop config"
        option :todo
        def install
          template_path = File.expand_path("../../../templates", __dir__)
          puts "#{File.exist?(CONFIG_FILE_NAME) ? "overwrite" : "create"} #{CONFIG_FILE_NAME}"
          FileUtils.copy_file(File.join(template_path, CONFIG_FILE_NAME), CONFIG_FILE_NAME)

          puts "creating rubocop todo file"

          system "rubocop --auto-gen-config" if options[:todo]

          puts "adding git hook"
          #puts "#{File.exist?(GITHOOK_FILE_PATH) ? "overwrite" : "create"} #{GITHOOK_FILE_PATH}"
          #FileUtils.copy_file(File.join(template_path, GITHOOK_FILE_PATH), GITHOOK_FILE_PATH)

        end
      end
    end
  end
end
