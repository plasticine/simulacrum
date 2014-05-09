require 'simulacrum/driver/base'

module Simulacrum
  module Driver
    # A driver for configuring local browser tests using the Firefox browser
    class LocalDriver < Simulacrum::Driver::Base
      private

      def configuration
        { browser: :firefox }
      end

      def driver_name
        'default'
      end
    end
  end
end
