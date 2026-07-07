module ApplicationHelper
  def pravatar_for(user, options = { size: 80 })
    size = options[:size]
    pravatar_url = "https://i.pravatar.cc/#{size}?u=#{user.email}"
    image_tag(
      pravatar_url,
      alt: user.username,
      class: "rounded-circle shadow d-block mx-auto border"
    )
  end




end
