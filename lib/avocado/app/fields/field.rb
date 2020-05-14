module Avocado
  module Fields
    class Field
      attr_reader :id
      attr_reader :name
      attr_reader :component
      attr_reader :updatable
      attr_reader :sortable
      attr_reader :required
      attr_reader :nullable
      attr_reader :block

      def initialize(id_or_name, **args, &block)
        @id = id_or_name.to_s.parameterize.underscore
        @name = args[:name] || id_or_name.to_s.camelize
        @component = 'field'
        @updatable = true
        @sortable = false
        @nullable = false
        @block = block

        @required = args[:required] ? true : false
      end

      def fetch_for_resource(model, view = :index)
        fields = {
          id: id,
          name: name,
          component: component,
          updatable: updatable,
          sortable: sortable,
          required: required,
          nullable: nullable,
          computed: block.present?,
        }

        fields[:value] = model[id] if model_or_class(model) == 'model'

        fields
      end

      def model_or_class(model)
        if model.class == String
          return 'class'
        else
          return 'model'
        end
      end
    end
  end
end