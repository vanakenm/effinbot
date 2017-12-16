class OauthController < ApplicationController
  def authorize                                                                   
    options = {                                                                   
      site: 'https://slack.com/oauth/authorize'                                  
    }                                                                             
    client ||= OAuth2::Client.new(                                                
      '12060783617.285877762837',                                                 
      ENV('SLACK_CLIENT_SECRET'),                                         
      options                                                                     
    )                                                                             
    params = {                                                                    
      scope: 'commands',                                        
      redirect_uri: 'https://www.effinbot.com/oauth/callback'                       
    }                                                                             
    redirect_to client.auth_code.authorize_url(params)                            
  end                                                                             

  def authorize_callback                                                          
    puts params["code"] 
    redirect_to root_url                                                              
  end 
end
