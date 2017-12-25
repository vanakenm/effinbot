class OauthController < ApplicationController
  def authorize
    options = {
      site: 'https://slack.com/oauth/authorize'
    }
    client ||= OAuth2::Client.new(
      ENV('SLACK_CLIENT_ID'),
      ENV('SLACK_CLIENT_SECRET'),
      options
    )
    params = {
      scope: 'commands',
      redirect_uri: 'https://www.effinbot.com/oauth/callback'
    }
    redirect_to client.auth_code.authorize_url(params)
  end

  def success; end

  def error; end

  def authorize_callback
    code = params['code']
    response = HTTParty.get("https://slack.com/api/oauth.access?code=#{code}&client_id=#{ENV('SLACK_CLIENT_ID')}&client_secret=#{ENV['SLACK_CLIENT_SECRET']}")

    if response['ok'] && response['ok'] == true
      redirect_to '/success'
    else
      redirect_to '/error'
    end
  end
end
