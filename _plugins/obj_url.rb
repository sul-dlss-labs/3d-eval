BASE_URL = Jekyll.configuration({})['baseurl']

module ViewerUrl
  def obj_url(druid)
    obj_path = "assets/items/#{druid}/#{druid}_low.obj"
    return "#{BASE_URL}/#{obj_path}" if File.exist?(obj_path)

    obj_path = "assets/items/#{druid}/#{druid}.obj"
    return "#{BASE_URL}/#{obj_path}" if File.exist?(obj_path)

    ''
  end
end

Liquid::Template.register_filter(ViewerUrl)
