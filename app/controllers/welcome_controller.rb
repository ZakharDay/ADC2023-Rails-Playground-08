class WelcomeController < ApplicationController
  def index
    @color = '#'
    options = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
    6.times { @color += options.sample }

    @subscription = Subscription.new
  end

  def about
  end

  def feed
    @posts = Post.all
  end

  def search
    @items = PgSearch.multisearch(params['search'])
  end

  def speech
  end

end
