class TweetsController < ApplicationController
  before_action :set_tweet, only:[:edit, :update, :destroy]
  before_action :set_all_tweets, only:[:index, :new, :create, :confirm]

  def index
  end

  def new
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end
  end

  def create
     @tweet = Tweet.new(tweets_params)
     if @tweet.save
     # ビューヘルパーの「rake routesのprefix_path」でルーティングにリンク
        redirect_to new_tweet_path, notice: "つぶやきました"
     else
       render 'new' # newのViewへ(new.html.erb)
     end
  end

  def edit
  end
  
  def update
    if @tweet.update(tweets_params)
      redirect_to new_tweet_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to new_tweet_path, notice: "削除しました"
  end
  
  def confirm
    @tweet = Tweet.new(tweets_params)
    render :new if @tweet.invalid? # if文1行書き 実行文 if 条件
  end

## ストロングパラメータ
## paramsメソッドにて取得した値の内、contentだけ取り込み
  private
   def tweets_params
      params.require(:tweet).permit(:content)
   end
   
  #idをキーとして値を取得するメソッド
   def set_tweet
    @tweet = Tweet.find(params[:id])
   end
   
   def set_all_tweets
     @tweets = Tweet.all.reverse
   end
end
