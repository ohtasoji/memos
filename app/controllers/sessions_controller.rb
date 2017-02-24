class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(id: params[:user_id])

    if user
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Login successed'
    else
      redirect_to root_path, alert: 'Login failed'
    end
  end

  def destroy
    reset_session
    # session.destroy
    if session[:user_id]
        redirect_to root_path, notice: 'session was not destroyed.'
    else
        redirect_to gest_index_path, notice: 'session was successfully destroyed.'
    end
  end
end
