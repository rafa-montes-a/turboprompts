class SentencesController < ForceController
  def index
    matching_sentences = Sentence.all

    @list_of_sentences = matching_sentences.order({ :created_at => :desc })

    render({ :template => "sentences/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_sentences = Sentence.where({ :id => the_id })

    @the_sentence = matching_sentences.at(0)

    render({ :template => "sentences/show.html.erb" })
  end

  def create
    the_sentence = Sentence.new
    the_sentence.content = params.fetch("query_content")
    the_sentence.kind = params.fetch("query_kind")
    the_sentence.prompt_id = params.fetch("query_prompt_id")

    if the_sentence.valid?
      the_sentence.save
      redirect_to("/prompts/#{the_sentence.prompt_id}", { :notice => "Sentence created successfully." })
    else
      redirect_to("/prompts/#{the_sentence.prompt_id}", { :alert => the_sentence.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_sentence = Sentence.where({ :id => the_id }).order({ :created_at => :asc }).at(0)

    the_sentence.content = params.fetch("query_content")
    the_sentence.kind = params.fetch("query_kind")
    the_sentence.prompt_id = params.fetch("query_prompt_id")

    if the_sentence.valid?
      the_sentence.save
      redirect_to("/prompts/#{the_sentence.prompt_id}", { :notice => "Sentence updated successfully."} )
    else
      redirect_to("/prompts/#{the_sentence.prompt_id}", { :alert => the_sentence.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("sentence_id")
    the_sentence = Sentence.where({ :id => the_id }).at(0)

    the_sentence.destroy

    redirect_to("/prompts/#{the_sentence.prompt.id}", { :notice => "Sentence deleted successfully."} )
  end
end
