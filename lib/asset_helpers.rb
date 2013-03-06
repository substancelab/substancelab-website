module AssetHelpers
  def image_exists?(path)
    File.exist?(File.join(source, images_dir, path))
  end
end
