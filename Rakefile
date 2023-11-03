require 'rake'
require 'csv'
require 'ruby-progressbar'
require_relative 'lib/item_fetcher'

desc 'fetch files for public objects'
task :fetch do
  items = CSV.parse(File.read('_data/items.csv'), headers: true)
  progress = ProgressBar.create(title: 'fetch', total: items.length, format: '%t %a |%b>>%i| %e %p%%')
  items.each do |row|
    progress.increment
    ItemFetcher.fetch(row['druid'])
  end
end

desc 'convert obj files'
task :convert do
  puts 'convert'
end

desc 'build JavaScript bundle'
task :build do
  system('./node_modules/.bin/webpack')
end
