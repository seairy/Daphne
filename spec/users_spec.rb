require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../app/apis/users_api.rb', __FILE__

describe "Sessions" do

  def app
    UsersApi.new
  end

  it "should be retrieve user data" do
    token = User.where(account: PHONE_NUMBER).first.tokens.available.first.content
    get '/show', token: token
    JSON.parse(last_response.body)['data']['phone'].should eq(PHONE_NUMBER)
  end

  it "should be update user email" do
    fax_number = Random.new.rand(12345678..87654321).to_s
    token = User.where(account: PHONE_NUMBER).first.tokens.available.first.content
    put '/update', { user: { mail: MAIL_ADDRESS, fax: fax_number}, token: token }
    JSON.parse(last_response.body)['data']['fax'].should eq(fax_number)
  end
end