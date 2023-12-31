class LikesController < ForceController
  def index
    matching_likes = Like.all

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    render({ :template => "likes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_likes = Like.where({ :id => the_id })

    @the_like = matching_likes.at(0)

    render({ :template => "likes/show.html.erb" })
  end

  def create
    the_like = Like.new
    the_like.user_id = @current_user.id
    the_like.prompt_id = params.fetch("prompt_id")

    if the_like.valid?
      the_like.save
      redirect_to(request.referrer, { :notice => "Like created successfully." })
    else
      redirect_to(request.referrer, { :alert => the_like.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.user_id = params.fetch("query_user_id")
    the_like.prompt_id = params.fetch("query_prompt_id")

    if the_like.valid?
      the_like.save
      redirect_to("/likes/#{the_like.id}", { :notice => "Like updated successfully."} )
    else
      redirect_to("/likes/#{the_like.id}", { :alert => the_like.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("like_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.destroy

    redirect_to(request.referrer, { :notice => "Like deleted successfully."} )
  end
end

