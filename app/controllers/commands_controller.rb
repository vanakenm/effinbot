class CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery except: [:create]

  def create
    params = command_params.to_h

    quote = EffinQuote.find_by_word(command_params[:text])

    message = contents(quote)

    HTTParty.post(params[:response_url], { body: message.to_json, headers: {
        "Content-Type" => "application/json"
      }
    })

    render json: { response_type: "in_channel" }, status: :created
  end

  def contents(quote)
    {
      "response_type": "in_channel",
      "attachments": [
        {
            "title": quote.contents,
            "title_link": quote.url,
            "image_url": quote.url
        }
      ]
    }
  end

  private

    # Only allow a trusted parameter "white list" through.
    def command_params
      params.permit(:text, :token, :user_id, :response_url)
    end

end
