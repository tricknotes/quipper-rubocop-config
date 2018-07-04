require 'thor'

module Quipper
  module Rubocop
    module Config
      class CLI < Thor

        CONFIG_FILE_NAME = ".rubocop.yml"
        desc "install", "Install rubocop config"
        def install
          raise "usage: onkcop init" unless args.empty?
          template_path = File.expand_path("../../../templates", __dir__)
          puts "#{File.exist?(CONFIG_FILE_NAME) ? "overwrite" : "create"} #{CONFIG_FILE_NAME}"
          FileUtils.copy_file(File.join(template_path, CONFIG_FILE_NAME), CONFIG_FILE_NAME)
        end
      end
    end
  end
end
