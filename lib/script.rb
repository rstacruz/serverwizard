class Script
  def self.home(*a)
    Main.root 'data', *a
  end

  def self.all
    items = Dir["#{home}/*.sh"].map { |f| self.new f  unless File.basename(f)[0] == '_' }
    items = items.compact

    items.sort_by { |item| item.sort_position }
  end

  def self.[](id)
    id = id.scan(/[A-Za-z0-9\-_]/).join('').downcase

    item = new home("#{id}.sh")
    item if item.exists?
  end

  # Builds a script
  def self.build(recipe_names, custom={})
    recipes = recipe_names.map { |r| Script[r] }.compact

    output = ""
    output += Script['_common'].contents
    output += "\n\n"

    if custom && custom.any?
      output += heading("Custom variables")

      custom.each { |k, v|
        output += "export #{k}=#{v.inspect}\n"
      }

      output += "\n"
    end

    contents = recipes.map { |r|
      heading(r.name) + r.contents
    }

    output += contents.join("\n\n")

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

  def sort_position
    (meta[:position] || 50).to_i
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
      v =~ /^(.*?) \((.*?)\)$/
      Hashie::Mash.new :type => $2, :name => $1, :id => k, :default => ''
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

private
  def self.heading(str)
    "# == #{str} " + ("=" * (75-str.size)) + "\n\n"
  end
end
