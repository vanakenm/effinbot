class EffinQuotesController < ApplicationController
  def index
    @quotes = EffinQuote.all
  end

  def show
    @quote = EffinQuote.find(params[:id])
  end

  def find
    @quote = EffinQuote.find_by_word(params[:query])
    @quote = EffinQuote.all.sample unless @quote

    redirect_to @quote
  end
end
