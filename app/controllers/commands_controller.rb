class CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery except: [:create]

  def create
    quote,random = find_or_random(command_params[:text])

    EffinLog.create(
      effin_quote: quote, 
      random: random, 
      team_doman: Digest::SHA256.hexdigest(command_params[:team_domain]), 
      text: command_params[:text]
    )

    HTTParty.post(command_params[:response_url], { body: contents(quote).to_json, headers: {
        "Content-Type" => "application/json"
      }
    })

    render json: { response_type: "in_channel" }, status: :created
  end

  private
    
    def contents(quote)
      {
        "response_type": "in_channel",
        "attachments": [
          {
              "title": quote.contents,
              "title_link": quote.twitter_url,
              "image_url": quote.url
          }
        ]
      }
    end

    # Only allow a trusted parameter "white list" through.
    def command_params
      params.permit(:text, :token, :user_id, :response_url, :team_domain)
    end
end
