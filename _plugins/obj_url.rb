BASE_URL = Jekyll.configuration({})['baseurl']

module ObjectUrls 
  def obj_url(druid)
    pick_file(druid, /\.obj$/)
  end

  def glb_url(druid)
    pick_file(druid, /\.glb$/)
  end

  def pick_file(druid, pattern)
    obj_dir = "assets/items/#{druid}"
    obj_path = Dir.entries(obj_dir).find { |f| f =~ pattern }
    "#{BASE_URL}/#{obj_dir}/#{obj_path}"
  end
end

Liquid::Template.register_filter(ObjectUrls)
