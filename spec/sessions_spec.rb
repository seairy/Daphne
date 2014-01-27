require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../app/apis/sessions_api.rb', __FILE__

describe "Sessions" do

  def app
    SessionsApi.new
  end

  it "should be signin" do
    post '/captcha', phone: PHONE_NUMBER
    captcha = JSON.parse(last_response.body)['data']
    post '/signin', phone: PHONE_NUMBER, captcha: captcha
    JSON.parse(last_response.body)['data'].length.should eq(32)
  end
end