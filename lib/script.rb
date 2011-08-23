class Script
  def self.home(*a)
    Main.root 'data', 'recipes', *a
  end

  def self.all
    items = Dir["#{home}/*.sh"].map { |f| self.new f  unless File.basename(f)[0] == '_' }
    items = items.compact

    # Make advanced recipes only available for development mode
    items = items.select { |item| ! item.meta[:advanced] }  unless ENV['RACK_ENV'] == 'development'

    items.sort_by { |item| item.sort_position }
  end

  def self.[](id)
    @@cache ||= Hash.new
    @@cache[id] ||= begin
      id = id.scan(/[A-Za-z0-9\-_]/).join('').downcase

      item = new home("#{id}.sh")
      item if item.exists?
    end
  end

  attr_reader :id
  attr_reader :file

  def initialize(file)
    @file = file
    @id   = File.basename(file, '.sh')
  end

  def exists?
    File.exists? @file
  end

  def name
    meta.name
  end

  def notes?
    meta.notes?
  end

  def notes
    Tilt.new("markdown") { meta.notes }.render  if notes?
  end

  def dependencies
    @dependencies ||= begin
      needs = [*meta[:needs]]
      deps  = needs.map { |name| Script[name] }
      deps += deps.map { |d| d.dependencies }.flatten
      deps
    end
  end

  # Returns a list of recipe names that the recipe implies it needs.
  def implies
    [* meta[:implies] ]
  end

  def sort_position
    [ (meta[:position] || 50).to_i, id ]
  end

  def description
    meta[:description].to_s
  end

  def meta
    raw_contents && @meta
  end

  def contents
    raw_contents && @contents
  end

  def on_by_default
    meta[:on_by_default]
  end

  def fields
    return Array.new  unless meta.fields?

    meta.fields.map { |k, v|
      if v.is_a?(String)
        v =~ /^(.*?) \((.*?)\)$/
        Hashie::Mash.new :type => $2, :name => $1, :id => k, :default => ''
      elsif v.is_a?(Hash)
        defaults = { :type => 'text', :placeholder => '', :default => '', :id => k }
        Hashie::Mash.new defaults.merge(v)
      end
    }
  end

  def raw_contents
    @raw_contents ||= begin
      raw = File.read @file

      # Extract the metadata
      meta = Array.new
      
      lines = raw.split("\n")
      lines.each { |line|
        break  unless line =~ /^# (.*)$/
        meta << $1
      }

      @meta     = Hashie::Mash.new YAML::load(meta.join("\n"))
      @contents = [*lines[(meta.size+1)..-1]].join("\n")

      raw
    end
  end

  alias to_s name
end
