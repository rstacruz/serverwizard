class ScriptBundle
  # Builds a script
  def self.build(recipe_names, custom={}, host='serverwizard.org')
    item = new recipe_names, custom, host
    item.build
  end

  attr_reader :recipes
  attr_reader :host

  def initialize(recipe_names, custom={}, host='serverwizard.org')
    @custom  = custom
    @recipes = recipe_names.map { |r| Script[r] }.compact
    @host    = host
  end

  def notes
    @notes ||= begin
      notes = @recipes.map { |r|
        ("<h4>#{r}</h4>" + r.notes)  if r.notes?
      }.compact.join("\n")
    end
  end

  def notes?
    ! notes.empty?
  end

  def tarball
    path   = "/tmp/tarball-#{Time.now.to_i}-#{rand(65535)}"
    prefix = "#{path}/bootstrap"

    # Copy main tarball files
    FileUtils.rm_rf path
    FileUtils.mkdir_p path
    FileUtils.cp_r "#{Main.root}/data/tarball", prefix

    # Add the main bootstrap file
    File.open("#{prefix}/bootstrap.sh", 'w') { |f| f.write build(:no_files => true) }

    # 755
    FileUtils.chmod 0100755, "#{prefix}/bootstrap.sh"
    FileUtils.chmod 0100755, "#{prefix}/remote.sh"

    # Add files
    files.each { |f|
      FileUtils.mkdir_p File.dirname("#{prefix}/#{f}")
      FileUtils.cp "#{Main.root}/public/#{f}", "#{prefix}/#{f}"
    }

    # Tar it
    tarball = `cd "#{path}" && tar -zc bootstrap/`

    FileUtils.rm_rf path

    tarball
  end

  def build(options={})
    [ header_src,
      (files_src  unless options[:no_files]),
      common_src,
      custom_variables_src,
      contents_src,
      done_src
    ].compact.join.gsub('HTTP_HOST', @host)
  end

  def files
    @recipes.map { |r| r.meta.files }.compact.flatten
  end

  def files_src
    if files.any?
      dirs = files.map { |f| File.dirname(f) }.uniq.sort
      dirs = dirs.map { |d| "#{d}/" }

      files = self.files.map { |f| "http://HTTP_HOST/#{f} -O #{f}" }

      mkdir = "mkdir -p #{dirs.join(' ')}"
      wget  = "wget #{files.join(' ')}"

      cmd = "#{mkdir} && #{wget}"

      [ "# Note: this script relies on a few files from the http://HTTP_HOST",
        "# server. To freeze these dependencies, download them like so:",
        "#",
        "#     #{cmd}\n\n"
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
