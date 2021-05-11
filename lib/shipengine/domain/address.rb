# frozen_string_literal: true

module ShipEngine
  class AddressValidationMessage
    attr_reader :type, :code, :message

    # @param type [:info" | :warning | :error"]
    # @param code [String] = e.g. "suite_missing"
    def initialize(type:, code:, message:)
      @type = type
      @code = code
      @message = message
    end
  end

  class AddressValidationResult
    attr_reader :valid, :normalized_address, :errors, :warnings, :info

    # @param [Boolean] valid
    # @param [NormalizedAddress] normalized_address
    # @param [AddressValidationMessage] errors
    # @param [AddressValidationMessage] warnings
    # @param [AddressValidationMessage] info
    def initialize(valid:, normalized_address:, errors:, warnings:, info:)
      @valid = valid
      @errors = errors
      @info = info
      @normalized_address = normalized_address
      @warnings = warnings
    end
  end

  class NormalizedAddress
    attr_reader :street, :name, :company, :phone, :city_locality, :state_province, :postal_code, :country_code

    # @param [Array<String>] street - e.g. ["123 FAKE ST."]
    # @param [String] country_code - e.g. "US"
    # @param [String] postal_code - e.g "78751"
    # @param [String?] name - e.g. "John Smith"
    # @param [String?] company - e.g. "ShipEngine"
    # @param [String?] phone - e.g. 5551234567
    # @param [String?] city_locality - e.g. "AUSTIN"
    # @param [String?] state_province - e.g. "TX"
    # @param [Boolean?] residential
    def initialize(street:, name:, company:, phone:, city_locality:, state_province:, postal_code:, country_code:, residential:)
      @street = street
      @name = name
      @company = company
      @phone = phone
      @city_locality = city_locality
      @state_province = state_province
      @postal_code = postal_code
      @country_code = country_code
      @residential = residential
    end

    def residential?
      @residential
    end
  end

  module Domain
    class Address
      # @param [ShipEngine::InternalClient] internal_client
      def initialize(internal_client)
        @internal_client = internal_client
      end

      # @param [String] street
      # @param [String?] city_locality
      # @param [String?] state_province
      # @param [String?] postal_code
      # @param [String] country_code
      # @return [ShipEngine::Domain::Address::ValidateAddressResult]
      def validate(address, cfg)
        address_params = {
          street: address.fetch(:street),
          cityLocality: address.fetch(:city_locality, nil),
          stateProvince: address.fetch(:state_province, nil),
          postalCode: address.fetch(:postal_code, nil),
          countryCode: address.fetch(:country_code)
        }.compact # drop nil

        @internal_client.make_request('address.validate.v1', { address: address_params }, cfg)
      end
    end
  end
end
