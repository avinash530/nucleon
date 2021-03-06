
module Nucleon
module Translator
class JSON < Nucleon.plugin_class(:nucleon, :translator)
   
  #-----------------------------------------------------------------------------
  # Translator operations
   
  def parse(json_text)
    return super do |properties|
      if json_text && ! json_text.empty?
        properties = Util::Data.symbol_map(Util::Data.parse_json(json_text))
      end
      properties
    end
  end
  
  #---
  
  def generate(properties)
    return super do
      Util::Data.to_json(Util::Data.string_map(properties), get(:pretty, true))
    end
  end
end
end
end
