# Monkey patch to restore URI.escape and URI.unescape for Ruby 3.0+
# These methods were deprecated in Ruby 2.7 and removed in Ruby 3.0
# This provides backward compatibility for gems that haven't updated yet

# This is some AI slop BUT we aren't accepting new user input from URLs
# So OK for now
# https://github.com/hampelm/brickbeam/issues/293

module URI
  # Escape unsafe characters in a string for use in URLs
  # Special handling for URLs vs query parameters to avoid over-encoding
  def self.escape(str, unsafe = nil)
    return str if str.nil?
    
    # If it's already a valid URL (starts with protocol or //), don't encode it
    # This is important for S3 URLs and other external asset URLs
    return str if str.to_s =~ %r{\A(https?:)?//}
    
    # For other strings, use CGI.escape which is appropriate for URL encoding
    # but un-escape forward slashes to preserve path structure
    CGI.escape(str.to_s).gsub('%2F', '/')
  end
  
  # Unescape escaped characters in a URL string
  # Uses the modern decode_www_form_component as the implementation
  def self.unescape(str)
    decode_www_form_component(str.to_s)
  end
end
