module InSpecMultiServer
  module Config

    class Settings
      attr_reader :data, :file
      def initialize(file)
        @file = file
        @data = JSON.parse(File.read(file))
      end

      def self.default_stage
        'development'
      end

      def self.default_project
        'cme-eventhub-core'
      end

      def self.current=(value)
        Thread.current[:inspec_settings] = value
      end

      def self.current
        Thread.current[:inspec_settings]
      end

      def self.cookbook_directory(path)
        File.join(path)
      end

      def server(server)
        servers[server]
      end

      def self.load(config)
        InSpecMultiServer::Config::Settings.new(config)
      end
    end
  end
end
