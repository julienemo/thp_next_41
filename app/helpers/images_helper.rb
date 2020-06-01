module ImagesHelper
  def current_user_can_see_image(image)
    if !image.is_private
      return true
    elsif image.uploaded_by == current_user
      return true
    else
      return false
    end
  end
end
