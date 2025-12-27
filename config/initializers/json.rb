# Temp fix for
# https://stackoverflow.com/questions/66750055/wrong-number-of-arguments-errors-when-upgrading-rails-5-2-to-6-0
module JSON
  module_function

  def parse(source, opts = {})
    Parser.new(source, **opts).parse
  end
end