# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def initialize(entity, url:, **attrs)
      @entity = entity
      @url = url
      @attrs = attrs
    end

    def input(name, options = {})
      value = @entity.public_send(name)
      type = options.fetch(:as, 'text')

      HexletCode::Tag.build('input', { type: type, name: name, value: value })
    end
  end
end
