class UsersApi < BaseApi

  before do
    @user = authenticate!
  end

  get '/show' do
    json Result::Success.create(@user)
  end

  put '/update' do
    if @user.update_attributes(params[:user])
      json Result::Success.create(@user)
    else
      json Result::Failure.create(20201)
    end
  end

  get '/update_avatar' do
    "Update User Avatar"
  end
end