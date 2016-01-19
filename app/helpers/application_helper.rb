module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(controller: link_path) ? 'active' : nil

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def random_image
    images = [
      'roller-white.png',
      'saw-white.png',
      'hammer-white.png',
      'screwdriver-white.png'
    ]

    return images.sample
  end
end
