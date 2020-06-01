module UsersHelper
  def display_name(user)
    "#{user.first_name.capitalize}.#{user.last_name[0].upcase}"
  end
end
