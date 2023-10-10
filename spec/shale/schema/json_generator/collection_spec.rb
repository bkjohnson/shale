# frozen_string_literal: true

require 'shale/schema/json_generator/boolean'
require 'shale/schema/json_generator/collection'

RSpec.describe Shale::Schema::JSONGenerator::Collection do
  let(:type) { Shale::Schema::JSONGenerator::Boolean.new('foo') }

  describe '#name' do
    it 'returns name of the wrapped type' do
      expect(described_class.new(type).name).to eq(type.name)
    end
  end

  describe '#as_json' do
    it 'returns JSON Schema fragment as Hash' do
      expected = { 'type' => 'array', 'items' => { 'type' => 'boolean' } }
      expect(described_class.new(type).as_json).to eq(expected)
    end

    context 'when mapping is passed with a schema' do
      it 'can include array keywords from JSON schema' do
        mapping = Shale::Mapping::Descriptor::Dict.new(
          name: 'foo',
          attribute: nil,
          receiver: nil,
          methods: nil,
          group: nil,
          render_nil: nil,
          schema: {
            min_items: 2,
            max_items: 25,
            unique: true,
            min_contains: 5,
            max_contains: 10,
          }
        )
        expected = {
          'type' => 'array',
          'items' => { 'type' => 'boolean' },
          'minItems' => 2,
          'maxItems' => 25,
          'uniqueItems' => true,
          'minContains' => 5,
          'maxContains' => 10,

        }
        expect(described_class.new(type, mapping: mapping).as_json).to eq(expected)
      end

      it 'can use a subset of schema keywords' do
        mapping = Shale::Mapping::Descriptor::Dict.new(
          name: 'foo',
          attribute: nil,
          receiver: nil,
          methods: nil,
          group: nil,
          render_nil: nil,
          schema: { min_items: 4 }
        )
        expected = {
          'type' => 'array',
          'items' => { 'type' => 'boolean' },
          'minItems' => 4,
        }
        expect(described_class.new(type, mapping: mapping).as_json).to eq(expected)
      end

      it 'will not use keywords for other types' do
        mapping = Shale::Mapping::Descriptor::Dict.new(
          name: 'foo',
          attribute: nil,
          receiver: nil,
          methods: nil,
          group: nil,
          render_nil: nil,
          schema: { multiple_of: 3 }
        )
        expected = {
          'type' => 'array',
          'items' => { 'type' => 'boolean' },
        }
        expect(described_class.new(type, mapping: mapping).as_json).to eq(expected)
      end
    end
  end
end
