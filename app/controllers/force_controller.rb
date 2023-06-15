class ForceController < ApplicationController
  # Uncomment line 3 in this file and line 3 in UserAuthenticationController if you want to force users to sign in before any other actions.
  before_action(:force_user_sign_in)

  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

end
