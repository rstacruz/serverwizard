class ScriptBundle
  # Builds a script
  def self.build(recipe_names, custom={}, host='serverwizard.org')
    item = new recipe_names, custom, host
    item.build
  end

  def initialize(recipe_names, custom={}, host='serverwizard.org')
    @custom  = custom
    @recipes = recipe_names.map { |r| Script[r] }.compact
    @host    = host
  end

  def build
    [ header_src,
      files_src,
      common_src,
      custom_variables_src,
      contents_src,
      done_src
    ].join.gsub('HTTP_HOST', @host)
  end

  def files_src
    files = @recipes.map { |r| r.meta.files }.compact.flatten

    if files.any?
      dirs = files.map { |f| File.dirname(f) }.uniq
      [ "# Note: this script relies on a few files from the http://HTTP_HOST server.",
        "# If you don't like this, download the files like so:",
        "#",
        dirs.map  { |d| "#     mkdir -p #{d}/" },
        files.map { |f| "#     wget http://HTTP_HOST/#{f} -O #{f}" },
        "\n"
      ].flatten.join("\n")

    else
      ""
    end
  end

  def header_src
    Script['_header'].contents + "\n\n"
  end

  def common_src
    Script['_common'].contents + "\n\n"
  end

  def done_src
    [ "\n\n",
      heading("Done"),
      Script['_done'].contents
    ].join
  end

  def contents_src
    @recipes.map { |r|
      heading(r.name) + r.contents
    }.join("\n\n")
  end

  def custom_variables_src
    output = ""

    if @custom && @custom.any?
      output += heading("Custom variables")

      @custom.each { |k, v|
        output += "export #{k}=#{v.inspect}\n"
      }

      output += "\n"
    end
    output
  end


private
  def heading(str)
    "# == #{str} " + ("=" * (75-str.size)) + "\n\n"
  end
end