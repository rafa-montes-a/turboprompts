class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  before_action(:define_prompt)
  before_action(:define_admin)
  before_action(:define_locations)
  
  def load_current_user
    the_id = session[:user_id]
    
    @current_user = User.where({ :id => the_id }).first
  end

  def define_prompt
    @kind = ["Fixed", "Input"]
    @n_questions = 10
  end

  def define_admin
    @admin_email = "rmontes@chicagobooth.edu"
  end

  def define_locations
    @homepage_link = ""
    @sign_in_link = ""
    @sign_up_link = ""
  end

end
