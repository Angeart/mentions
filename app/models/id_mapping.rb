class IdMapping
  attr_reader :mappings

  def initialize(mention_mappings_yaml)
    if mention_mappings_yaml =~ /\Ahttp(:?s)?/
      require 'open-uri'
      yaml_content = open(mention_mappings_yaml)
      @mappings = YAML.load(yaml_content)
    else
      @mappings = YAML.load_file(mention_mappings_yaml)
    end
  rescue
    @mappings = []
  ensure
    @mappings << { 'esa' => 'all', 'slack' => 'everyone' }
  end

  def find(user_name:, from:, to:)
    if to == 'slack'
      user_name.sub(/\-/, '.')
    else
      user = @mappings.detect { |u| u[from.to_s] == user_name.to_s }
      user[to]
    end
  rescue
    nil
  end
end
