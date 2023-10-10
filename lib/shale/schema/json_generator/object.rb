# frozen_string_literal: true

require_relative 'base'
require_relative 'collection'

module Shale
  module Schema
    class JSONGenerator
      # Class representing JSON Schema object type
      #
      # @api private
      class Object < Base
        # Initialize object
        #
        # @param [String] name
        # @param [
        #   Array<Shale::Schema::JSONGenerator::Base,
        #   Shale::Schema::JSONGenerator::Collection>
        # ] properties
        #
        # @api private
        def initialize(name, properties)
          super(name)
          @properties = properties
        end

        # Return JSON Schema fragment as Ruby Hash
        #
        # @return [Hash]
        #
        # @api private
        def as_type
          required_props = @properties.filter_map do |prop|
            prop.name if !prop.is_a?(Collection) && prop.mapping&.schema&.[](:required)
          end

          {
            'type' => 'object',
            'properties' => @properties.to_h { |el| [el.name, el.as_json] },
            'required' => required_props.empty? ? nil : required_props,
          }.compact
        end
      end
    end
  end
end
