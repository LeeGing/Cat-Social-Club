class FollowsController < ApplicationController

  def index
  	@content = Content.all
  	@comment = Comment.all
    @save = Save.all
    @like = Like.all
    @likes = 0
    @current_user = current_user
    @follow = Follow.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

	def create
		follow = Follow.new(follow_params)
			flash[:notice] = 'You are now following this user.'
			redirect_back fallback_location: root_path
		if follow.save
		else 
			redirect_back fallback_location: root_path
			flash[:notice] = 'There was a problem with your follow.'
		end
	end

	def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    following = false
		redirect_back fallback_location: root_path
    flash[:notice] = 'Your follow has been removed.'
    sleep(1.0)
	end

	private
		
	def follow_params
		params.require(:follows).permit(:follower_id, :following_id)
	end

end

