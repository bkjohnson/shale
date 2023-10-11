# frozen_string_literal: true

require_relative 'base'

module Shale
  module Schema
    class JSONGenerator
      # Class representing JSON Schema float type
      #
      # @api private
      class Float < Base
        # Return JSON Schema fragment as Ruby Hash
        #
        # @return [Hash]
        #
        # @api private
        def as_type
          { 'type' => 'number',
            'exclusiveMinimum' => schema[:exclusive_minimum],
            'exclusiveMaximum' => schema[:exclusive_maximum],
            'minimum' => schema[:minimum],
            'maximum' => schema[:maximum],
            'multipleOf' => schema[:multiple_of] }.compact
        end
      end
    end
  end
end
