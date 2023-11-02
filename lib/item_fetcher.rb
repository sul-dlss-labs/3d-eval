# A class for fetching the files from PURL and Stacks for a public SDR item.
require 'json'
require 'open-uri'
require 'pathname'

# A class for fetching the files from PURL and Stacks for a public SDR item.
class ItemFetcher
  def self.fetch(druid)
    new(druid).fetch
  end

  def initialize(druid)
    @druid = druid
  end

  def fetch
    cocina = fetch_cocina
    fetch_files(cocina)
  end

  private

  def item_dir
    item_dir = Pathname.new("assets/items/#{@druid}")
    item_dir.mkpath unless item_dir.directory?
    item_dir
  end

  def fetch_cocina
    cocina_url = "https://purl.stanford.edu/#{@druid}.json"
    cocina_file = item_dir + "#{@druid}.json"
    download(cocina_url, cocina_file)
    JSON.parse(File.open(cocina_file).read)
  end

  def fetch_files(cocina)
    cocina['structural']['contains'].each do |resource|
      resource['structural']['contains'].each do |file|
        filename = file['filename']
        stacks_url = "https://stacks.stanford.edu/file/druid:#{@druid}/#{filename}?download=true"
        stacks_file = item_dir + filename
        download(stacks_url, stacks_file)
      end
    end
  end

  def download(url, file, force: false)
    return if file.file? && !force

    File.open(file, 'w') do |write_file|
      URI.parse(url).open do |read_file|
        write_file.write(read_file.read)
      end
    end
  end
end
