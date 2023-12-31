class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new', status: :unauthorized
    end
  end

  def delete
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
