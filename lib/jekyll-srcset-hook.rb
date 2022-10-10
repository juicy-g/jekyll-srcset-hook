# frozen_string_literal: true

require "nokogiri"

module JekyllSrcsetHook
  @@config = {}

  def set_config
    proc do |site|
      @@config = site.config["jekyll-srcset-hook"]

      if @@config.nil?
        Jekyll.logger.warn(
          "WARNING: jekyll-srcset-hook configuration is not present in _config.yml",
        )
        next
      end

      unless @@config["transformations_widths"].nil? && @@config["sizes"].nil?
        Jekyll::Hooks.register(:posts, :post_render, &modify_post_output)
        Jekyll::Hooks.register(:pages, :post_render, &modify_page_output)
      end

      unless @@config["posts"].nil?
        Jekyll::Hooks.register(:posts, :post_render, &modify_post_output)
      end

      unless @@config["pages"].nil?
        Jekyll::Hooks.register(:pages, :post_render, &modify_page_output)
      end
    end
  end

  def modify_post_output
    proc do |post|
      # posts are fragments (i.e. no DOCTYPE declaration/<html>...</html>)
      fragment = Nokogiri::HTML5.fragment(post.content)
      fragment
        .xpath(".//img")
        .each do |image|
          if image[:src].start_with?(
               @@config["url_endpoint"] || @@config["posts"]["url_endpoint"],
             )
            original_image = image
            original_image = original_image.to_s.gsub!(">", " />")

            image =
              process_image(
                image,
                @@config["transformations_widths"] ||
                  @@config["posts"]["transformations_widths"],
                @@config["sizes"] || @@config["posts"]["sizes"],
              )

            post.output.gsub!(original_image, image)
          end
        end
    end
  end

  def modify_page_output
    proc do |page|
      doc = Nokogiri.HTML5(page.content)
      elements = doc.xpath(".//body//img")
      # for some reason, need to remove last element as it is empty
      elements.pop

      elements.each do |image|
        if image[:src].start_with?(
             @@config["url_endpoint"] || @@config["pages"]["url_endpoint"],
           )
          original_image = image
          original_image = original_image.to_s.gsub!(">", " />")

          image =
            process_image(
              image,
              @@config["transformations_widths"] ||
                @@config["pages"]["transformations_widths"],
              @@config["sizes"] || @@config["pages"]["sizes"],
            )

          page.output.gsub!(original_image, image)
        end
      end
    end
  end

  def process_image(image, transformations, sizes)
    srcset_value = ""
    transformations.each { |t_w| srcset_value += "#{image[:src]}#{t_w}, " }
    # remove the extra ", " at the end of srcset_value
    srcset_value.chomp!(", ")
    # add the attributes to the image
    image[:srcset] = srcset_value
    image[:sizes] = sizes
    image.to_s.gsub!(">", " />")
  end

  module_function :set_config
  module_function :modify_post_output
  module_function :modify_page_output
  module_function :process_image

  Jekyll::Hooks.register(:site, :after_init, &set_config)
end
