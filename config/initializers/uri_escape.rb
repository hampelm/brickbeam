# Monkey patch to restore URI.escape and URI.unescape for Ruby 3.0+
# These methods were deprecated in Ruby 2.7 and removed in Ruby 3.0
# This provides backward compatibility for gems that haven't updated yet

module URI
  # Escape unsafe characters in a string for use in URLs
  # Uses the modern encode_www_form_component as the implementation
  def self.escape(str, unsafe = nil)
    encode_www_form_component(str)
  end
  
  # Unescape escaped characters in a URL string
  # Uses the modern decode_www_form_component as the implementation
  def self.unescape(str)
    decode_www_form_component(str)
  end
end
