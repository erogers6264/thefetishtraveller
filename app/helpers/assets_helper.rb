# frozen_string_literal: true

module AssetsHelper
  def image_tag(source, options = {})
    return nil if source.blank?

    if source.is_a?(ActiveStorage::Variant) || source.is_a?(ActiveStorage::Attached) || source.is_a?(ActiveStorage::Attachment)
      attachment = source
      width = options[:width]
      height = options[:height]
      source = image_asset_url(source, width: width, height: height)
      options[:loading] = :lazy
      options[:srcset] = "#{source} 1x, #{image_asset_url(attachment, width: width.to_i * 2, height: (height || width).to_i * 2)} 2x" if options[:width]
    end
    super source, options
  end

  def image_asset_url(source, width: nil, height: nil)
    return if source.blank?

    options = {}
    if width
      options[:resize] = "#{width}x#{height || width}>"
    elsif source.try :variation
      options[:resize] = source.variation.transformations[:resize]
    end
    FileProxy.new(blob_id: source.blob.id).url(options)
  end
end