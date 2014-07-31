class CommentsController < ApplicationController

	def create
		@comment_hash = params[:comment]
	    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
	    # Not implemented: check to see whether the user has permission to create a comment on this object
	    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
	    respond_to do |format|
		    if @comment.save
		    	format.js {}
		        # render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
		    else
		       	render :js => "alert('error saving comment');"
		    end
		end
	end

	def destroy
	    @comment = Comment.find(params[:id])
	    respond_to do |format|
		    if @comment.destroy
		    	format.js {}
		    	# format.json { render :json => @comment, :status => :ok }
		    else
		        render :js => "alert('error deleting comment');"
		    end
		end
	end

end
