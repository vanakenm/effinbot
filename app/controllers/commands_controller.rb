class CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery except: [:create]

  def create
    if command_params[:text] == 'help'
      render json: help_contents.to_json, status: :created
    elsif command_params[:text] == 'words'
      render json: words_contents.to_json, status: :created
    else
      quote,random = EffinQuote.find_or_random(command_params[:text])

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
  end

  private
    def words_contents
      words = EffinQuote.words.keys.sample(20).join(", ")
      {
         "text": "Here are some possible words to use: #{words}"
      }
    end

    def help_contents
      {
         "text": "Call the command with any words to get a quote using this text. If no proper quote can be found, a random one will be send. Use /effin help for this message, /effin words to get some possible words to use. Thanks for using effinbot."
      }
    end
    
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
