class StoriesController < ApplicationController
  before_filter :login_required, :only => [:new, :create]
  def index
	fetch_stories 'votes_count >= 5'
  end
  def bin
	fetch_stories 'votes_count < 5'
	
	render "index"
  end
  def new
	@story = Story.new
  end
  def show
	@story = Story.find(params[:id])
  end
  def edit
	  @story = Story.find(params[:id])
  end
  def create
	@story = @current_user.stories.build params[:story]
	if @story.save
		flash[:notice] = 'Story submission succeeced'
		redirect_to @story
	else
		render "new"
	end
  end
  def update
	  @story = Story.find(params[:id])
	  if @story.update_attributes(params[:story])
		  respond_to do |format|
			  format.html { redirect_to stories_path }
			  format.json
		  end
	  else
		  render "edit"
	  end
  end
  def destroy
	  @story = Story.find(params[:id])
	  @story.destroy
	  respond_to do |format|
		  format.html { redirect_to stories_path }
		  format.json
	  end
  end
  protected
  def fetch_stories(conditions)
	  @story = Story.find :all, :order => 'id DESC', :conditions => conditions
  end
end
