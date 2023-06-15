class PromptsController < ForceController

  def new

    render({ :template => "prompts/new.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_prompts = Prompt.where({ :id => the_id })

    @the_prompt = matching_prompts.at(0)

    render({ :template => "prompts/show.html.erb" })
  end

  def chat
    the_id = params.fetch("path_id")

    matching_prompts = Prompt.where({ :id => the_id })

    @the_prompt = matching_prompts.at(0)

    render({ :template => "prompts/chat.html.erb" })
  end

  def create
    the_prompt = Prompt.new
    the_prompt.desc = params.fetch("query_desc")
    the_prompt.user_id = @current_user.id

    if the_prompt.valid?
      the_prompt.save
      redirect_to("/prompts/#{the_prompt.id}", { :notice => "Prompt created successfully." })
    else
      redirect_to("/prompts/new", { :alert => the_prompt.errors.full_messages.to_sentence })
    end
  end

  def duplicate
    old_prompt_id = params.fetch("old_prompt_id")
    old_prompt = Prompt.where({ :id => old_prompt_id }).at(0)

    the_prompt = Prompt.new
    the_prompt.desc = old_prompt.desc + " Copy"
    the_prompt.user_id = @current_user.id

    if the_prompt.valid?
      the_prompt.save

      old_prompt.sentences.each do |old_sentence|
        the_sentence = Sentence.new
        the_sentence.kind = old_sentence.kind

        if the_sentence.kind == "Fixed"
          the_sentence.content = old_sentence.content
        else
          the_sentence.content = nil
        end

        the_sentence.prompt_id = the_prompt.id
        the_sentence.save!
      end

      redirect_to("/prompts/#{the_prompt.id}", { :notice => "Prompt created successfully." })
    else
      redirect_to("/prompts", { :alert => the_prompt.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_prompt = Prompt.where({ :id => the_id }).at(0)

    the_prompt.desc = params.fetch("query_desc")

    if the_prompt.valid?
      the_prompt.save
      redirect_to("/prompts/#{the_prompt.id}", { :notice => "Prompt updated successfully."} )
    else
      redirect_to("/prompts/#{the_prompt.id}", { :alert => the_prompt.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_prompt = Prompt.where({ :id => the_id }).at(0)

    the_prompt.destroy

    redirect_to("/prompts", { :notice => "Prompt deleted successfully."} )
  end
end
