module BaseMacros
  def stub_current_user(user)
    session = create(:session, user: user)
    allow(controller).to receive(:session_token).and_return(session.token)
    allow(controller).to receive(:current_session).and_return(session)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def json_response_body
    @json_response_body ||= JSON.load(response.body)
  end
end