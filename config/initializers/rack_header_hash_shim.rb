# Rack 3 Compatibility Shim for Rack::Utils::HeaderHash
#
# WHAT: This provides a compatibility layer for Rack::Utils::HeaderHash which was
# removed in Rack 3.0 but is still used by some older gems.
#
# WHY NEEDED: Rails 8 uses Rack 3, but one or more gems in this application still
# reference the removed Rack::Utils::HeaderHash class. Suspected gems:
# - warden 1.2.9 (used by Devise)
# - skylight 7.0.0 (performance monitoring)
# - heroku-deflater 0.7.0 (compression middleware)
#
# TEMPORARY: This is a temporary workaround. The proper fix is to update the
# offending gem(s) to versions that support Rack 3.
#
# TODO: Remove this file once all gems are Rack 3 compatible. Monitor:
# - https://github.com/wardencommunity/warden for Rack 3 updates
# - Update gems regularly with `bundle update`
#
# Created: 2025-12-26 during Rails 8 upgrade
#
module Rack
  module Utils
    # Compatibility implementation of HeaderHash for Rack 3
    # This mimics the behavior from Rack 2.x
    class HeaderHash < Hash
      def initialize(hash = {})
        super()
        @names = {}
        hash.each { |k, v| self[k] = v }
      end

      def []=(key, value)
        canonical = key.to_s.downcase
        @names[canonical] = key
        super(@names[canonical], value)
      end

      def [](key)
        super(@names[key.to_s.downcase])
      end

      def delete(key)
        canonical = key.to_s.downcase
        result = super(@names[canonical])
        @names.delete(canonical)
        result
      end

      def include?(key)
        @names.include?(key.to_s.downcase)
      end

      alias_method :has_key?, :include?
      alias_method :member?, :include?
      alias_method :key?, :include?

      def merge!(other)
        other.each { |k, v| self[k] = v }
        self
      end

      def merge(other)
        dup.merge!(other)
      end

      def replace(other)
        clear
        other.each { |k, v| self[k] = v }
        self
      end
    end
  end
end
