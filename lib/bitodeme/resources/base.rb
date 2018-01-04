require 'forwardable'

module Bitodeme
  module Resource
    # Base class for all Bitodeme resources
    class Base
      extend SingleForwardable

      def_delegators :conn, :post, :get

      class << self
        private

        def conn
          Bitodeme::Conn.build
        end

        def _find(collection, resource, id)
          item = get("/api/v1/#{collection}/#{id}").body.fetch(resource, {})
          new(item)
        end

        def _all(collection, opts)
          items = get("/api/v1/#{collection}", _query_params(opts)).body
          items.fetch(collection, []).map { |item| new(item) }
        end

        def _create(collection, resource, data)
          item = post("/api/v1/#{collection}", data).body.fetch(resource, data)
          new(item)
        end

        def _query_params(opts)
          query_params = {
            page:     opts.fetch(:page, 1),
            per_page: opts.fetch(:per_page, 50),
            since:    opts.fetch(:since, 0)
          }
          query_params[:starts_at] = opts[:starts_at] if opts.key?(:starts_at)
          query_params[:ends_at]   = opts[:ends_at]   if opts.key?(:ends_at)
          query_params
        end
      end

      def to_h
        attrs.each_with_object({}) do |attr, hash|
          val        = instance_variable_get(:"@#{attr}")
          hash[attr] = val unless val.nil?
        end
      end

      private

      def initialize(attrs:, params:)
        attrs.each do |attr|
          val = params.fetch(attr.to_s, params.fetch(attr, nil))
          instance_variable_set("@#{attr}", val)
        end
      end

      def attrs
        methods - klass_methods - excluded_attrs
      end

      def klass_methods
        self.class.methods - %i[name]
      end

      def excluded_attrs
        %i[to_h validate]
      end

      def raise_for(attr)
        raise Bitodeme::ValidationError.new(attr, send(:"#{attr}"))
      end
    end
  end
end
