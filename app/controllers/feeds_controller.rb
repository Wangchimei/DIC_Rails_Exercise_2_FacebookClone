class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  # skip_before_action :logged_in_status, only: [:home]
  layout 'feed', only: [:index, :show]

  def home
    render layout: 'home'
  end
  
  def index
    @feeds = Feed.all.order(created_at: :desc)
  end

  def new
    if params[:back]
     @feed = Feed.new(feed_params)
    else
    @feed = Feed.new
    end
    render layout: 'user'
  end
 
  def create
    @feed = Feed.new(feed_params)
    if params[:back]
      render :new
    else 
      if @feed.save
        redirect_to feeds_path and return
        render layout: 'user'
        flash[:notice] = "フィードが投稿されました"
      else
        render :new
      end
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    render layout: 'user'
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path and return
      render layout: 'user'
      flash[:notice] = "フィードが更新されました"
    else
      render :edit
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    render :new if @feed.invalid?
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path
    flash[:notice] = "フィードが削除されました"
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache, :user_id)
  end
end
