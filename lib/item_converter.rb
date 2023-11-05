require 'json'
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
        run_obj2gltf(obj_file)
      else
        @logger.error("#{@druid} missing .obj file")
      end
    end
  end

  def run_obj2gltf(obj_file)
    @logger.info("converting #{@druid} #{obj_file}")
    glb_file = obj_file.sub(/.obj$/, '.glb')
    cmd = "../../../node_modules/.bin/obj2gltf -i #{obj_file} -o #{glb_file}"

    stdout, _stderr, status = Open3.capture3(cmd)
    @logger.error("#{@druid} gltf conversion error: #{stdout.strip}") unless status.exitstatus.zero?

    # TODO: this doesn't work yet
    # if stdout =~ /Normal index \d+ is out of bounds/
    #   run_patched(obj_file)
    # end

    # unfortunately obj2gltf exits 0 and writes to stdout when there are missing texture files
    log_warnings(stdout) unless stdout.empty?
  end

  # Find each texture file that was missing in the output and log it
  # while also indicating if the filename was listed in the Cocina
  def log_warnings(error)
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

  # convert "nan" to "0" so obj2gltf doesn't complain
  # https://github.com/CesiumGS/obj2gltf/issues/243
  def run_patched(obj_file)
    obj = File.read(obj_file)
    patched = obj.gsub(/vn -nan\(ind\) -nan\(ind\) -nan\(ind\)/m, 'vn -0(ind) -0(ind) -0(ind)')
    patched_file = "patched-#{obj_file}"
    File.write(patched_file, patched)
    @logger.info("running patched #{obj_file} to replace nan values with 0")
    run_obj2gltf(patched_file)
  end
end
