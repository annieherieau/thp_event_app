module UsersHelper
  def profile_owner?
    if current_user.id != params[:id]
      redirect_to user_path(current_user.id)
    end
  end
end
