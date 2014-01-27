require "sinatra/json"

class BaseApi < Sinatra::Base
  helpers Sinatra::JSON
  
  enable :logging

  configure :development do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end

  configure :test do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end

  configure :production do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end

  error 403 do
    json Result::Failure.create(10002)
  end

  not_found do
    json Result::Failure.create(10001)
  end

  protected
  def authenticate!
    if not BaseHelper.is_token? params[:token]
      halt 403
    else
      token = Token.where(content: params[:token]).first
      if token.blank?
        halt 403
      elsif not token.available?
        halt 403
      elsif not token.user.status == User::STATUS_AVAILABLE
        halt 403
      else
        token.user
      end
    end
  end
end