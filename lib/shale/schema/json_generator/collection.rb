# frozen_string_literal: true

module Shale
  module Schema
    class JSONGenerator
      # Class representing array type in JSON Schema
      #
      # @api private
      class Collection
        attr_reader :schema

        # Initialize Collection object
        #
        # @param [Shale::Schema::JSONGenerator::Base] type
        #
        # @api private
        def initialize(type, schema: nil)
          @type = type
          @schema = schema
        end

        # Delegate name to wrapped type object
        #
        # @return [String]
        #
        # @api private
        def name
          @type.name
        end

        # Return JSON Schema fragment as Ruby Hash
        #
        # @return [Hash]
        #
        # @api private
        def as_json
          schema = @schema || {}

          { 'type' => 'array',
            'items' => @type.as_type,
            'minItems' => schema[:min_items],
            'maxItems' => schema[:max_items],
            'uniqueItems' => schema[:unique],
            'minContains' => schema[:min_contains],
            'maxContains' => schema[:max_contains] }.compact
        end
      end
    end
  end
end
