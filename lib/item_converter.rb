require 'open3'
require 'logger'
require 'pathname'

# Convert an 3D SDR item on the filesystem from OBJ to GLTF
class ItemConverter
  def self.convert(druid)
    new(druid).convert
  end

  def initialize(druid)
    @druid = druid
    @logger = Logger.new('convert.log')
    @cocina = JSON.parse(File.open("assets/items/#{druid}/#{druid}.json").read)
  end

  def convert
    Dir.chdir("./assets/items/#{@druid}/") do
      obj_file = Dir.entries('.').find { |f| f.end_with?('.obj') }
      if obj_file
        obj2gltf(obj_file)
      else
        @logger.error("#{@druid} missing .obj file")
      end
    end
  end

  def obj2gltf(obj_file)
    @logger.info("converting #{@druid} #{obj_file}")
    glb_file = obj_file.sub(/.obj$/, '.glb')
    cmd = "../../../node_modules/.bin/obj2gltf -i #{obj_file} -o #{glb_file}"

    # unfortunately obj2gltf exits 0 when there are missing texture files
    stdout, _stderr, _status = Open3.capture3(cmd)
    log_errors(stdout) unless stdout.empty?
  end

  # Find each texture file that was missing in the output and log it
  # while also indicating if the filename was listed in the Cocina
  def log_errors(error)
    error.scan(/Could not read texture file at (.+). Attempting/).each do |f|
      filename = Pathname.new(f[0]).basename
      if cocina_filenames.include?(filename)
        @logger.error("#{@druid} cocina has #{filename} but it is missing")
      else
        @logger.error("#{@druid} missing texture file in stacks #{filename}")
      end
    end
  end

  # Get the filenames from the Cocina metadata.
  def cocina_filenames
    @cocina['structural']['contains'].map do |r|
      r['structural']['contains'].map do |d|
        d['filename']
      end
    end.flatten
  end
end
