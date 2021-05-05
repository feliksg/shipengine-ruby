# frozen_string_literal: true

require_relative 'exceptions/error_code'

module ShipEngine
  module Exceptions
    # 400 error, or other "user exceptions"
    class ShipEngineError < StandardError
      attr_reader :request_id, :message, :source, :type, :code

      def initialize(request_id, message, source, type, code)
        super(message)
        @request_id = request_id
        @message = message
        @source = source
        @type = type
        @code = code
      end
    end

    # 400 error, or other "user exceptions"
    class InvalidParams < ShipEngineError
      def initialize(message)
        super(nil, message, 'shipengine', 'validation', Exceptions::ErrorCode.get(:INVALID_FIELD_VALUE))
      end
    end

    class FieldValueRequired < ShipEngineError
      def self.assert_field_exists(field_name, value)
        raise self, field_name if value.nil? || value == ''
      end

      def initialize(missing_item)
        super(nil, "#{missing_item} must be specified.", 'shipengine', 'validation', Exceptions::ErrorCode.get(:FIELD_VALUE_REQUIRED))
      end
    end
  end
end
