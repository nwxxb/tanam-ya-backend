require 'rails_helper'

# Please move it into spec/support
RSpec.configure do |config|
  RSpec::Matchers.define :json_schematically_match_with do |provided_schema|
    errors = []
    match do |ruby_object|
      errors = JSON::Validator.fully_validate(provided_schema, ruby_object)
      errors.empty?
    end
    failure_message do |ruby_object|
      errors.join('\n')
    end
  end
end

RSpec.describe "Plants", type: :request do
  let(:schema) do
    {
      'type' => 'array',
      'items' => {
        'type' => 'object',
        'properties' => {
          'id' => {'type' => 'integer'},
          'popularName' => {'type' => 'string'},
          'scientificName' => {'type' => 'string'},
          'focus' => {
            'type' => 'string',
            'enum' => ['leaf', 'flower', 'fruit', 'root', 'trunk']
          },
          'colorPallete' => {'type' => 'string'},
          'height' => {
            'type' => 'string',
            'enum' => ['short', 'medium', 'tall']
          },
          'width' => {
            'type' => 'string',
            'enum' => ['small', 'medium', 'high']
          },
          'waterNeed' => {
            'type' => 'string',
            'enum' => ['low', 'medium', 'high']
          },
          'rootType' => {
            'type' => 'string',
            'enum' => ['tap', 'fibrous']
          },
          'imageUrl' => {
            'type' => 'string',
            'format' => 'uri',
            'pattern' => '^https?://'
          }
        },
      }
    }
  end

  describe "GET /index" do
    it "returns all plants" do
      get api_v1_plants_path

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to json_schematically_match_with(schema)
    end
  end
end
