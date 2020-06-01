module CommentsHelper
  def current_user_can_change_and_delete_comment(comment)
    current_user == comment.user
  end
end
