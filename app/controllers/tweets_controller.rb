class TweetsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @todaytweets = Tweet.where("created_at between '#{Date.today} 0:00:00' and '#{Date.today} 23:59:59'").includes(:user).page(params[:page]).per(10).order("created_at DESC")
    # @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @tweets = Tweet.where("created_at between '2015-01-01 0:00:00' and '#{Date.yesterday} 23:59:59'").includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], folderimage: tweet_params[:folderimage], heart: tweet_params[:heart] ,user_id: current_user.id)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.destroy
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(edit_params)
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text, :folderimage, :heart)
  end

  private
  def edit_params
    params.permit(:image, :text, :folderimage, :heart)
  end

  def move_to_index
    redirect_to :action => "index" unless user_signed_in?
  end

  # def heartmake
  #   Tweet.create(heart: current_user.id)
  #   redirect_to :action => "create"
  # end
end
