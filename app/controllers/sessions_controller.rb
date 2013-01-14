class SessionsController < ApplicationController

def new
end

def create
	user = User.find_by_email(params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
 else
  flash.now[:error] = 'E-mail/Senha incorretos. Tente novamente'
  render 'new'
 end
end

def destroy
	sign_out
	redirect_to root_url
end

end
