require 'spec_helper'

describe EmailsController, '#create' do
  it 'responds with success when request is valid' do
    EmailReceiver.should_receive(:receive).and_return(true)
    post :create
    response.should be_success
    response.body.should eq '{"status":"ok"}'
  end

  it 'responds with 403 when request is invalid' do
    EmailReceiver.should_receive(:receive).and_return(false)
    post :create
    response.status.should eq 403
    response.body.should eq '{"status":"rejected"}'
  end
end