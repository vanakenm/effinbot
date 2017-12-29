class EffinQuotesController < ApplicationController
  before_action :authenticate_user!, except: :home

  def index
    @quotes = EffinQuote.all
  end

  def logs
    @logs = EffinLog.order(created_at: :desc)
  end

  def home; end

  def check
    @quote = EffinQuote.incomplete.first
    @count = EffinQuote.incomplete.count

    render :show
  end

  def show
    @quote = EffinQuote.find(params[:id])
    @count = EffinQuote.incomplete.count
  end

  def incomplete
    @quotes = EffinQuote.incomplete

    render :index
  end

  def update
    @quote = EffinQuote.find(params[:id])
    @quote.update!(quote_params)

    redirect_to check_effin_quotes_path
  end

  def find
    @quote = EffinQuote.find_by_word(params[:query]) || EffinQuote.all.sample
    redirect_to @quote
  end

  def destroy
    @quote = EffinQuote.find(params[:id])
    @quote.destroy
    redirect_to check_effin_quotes_path
  end

  def quote_params
    params.require(:effin_quote).permit(:contents)
    end
end
