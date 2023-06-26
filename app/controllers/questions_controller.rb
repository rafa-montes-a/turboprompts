class QuestionsController < ForceController
  def index
    matching_questions = Question.all

    @list_of_questions = matching_questions.order({ :created_at => :desc })

    render({ :template => "questions/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_questions = Question.where({ :id => the_id })

    @the_question = matching_questions.at(0)

    render({ :template => "questions/show.html.erb" })
  end

  def create
    the_question = Question.new
    the_question.user_id = @current_user.id
    the_question.prompt_id = params.fetch("query_prompt_id")
    the_prompt = Prompt.where({ :id => the_question.prompt_id }).at(0)

    the_question.feed =  ""

    the_prompt.sentences.each do |a_sentence|
    
      the_question.feed = the_question.feed + params.fetch("query_sentence#{a_sentence.id}")

    end

    gpt_prompt = "Answer the following in no more than 25 seconds: " + the_question.feed.to_s

    message_hash = { :role => "user", :content => gpt_prompt }
    api_messages_array = Array.new
    api_messages_array.push(message_hash)

    the_question.answer = "sample"

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_TOKEN"), request_timeout: 200,)

    response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: api_messages_array,
          temperature: 1.0,
        },
      )

      the_question.answer = response.fetch("choices").at(0).fetch("message").fetch("content")

    if the_question.valid?
      the_question.save
      redirect_to("/prompts/chat/#{the_prompt.id}", { :notice => "Question created successfully." })
    else
      redirect_to("#", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    gpt_prompt = "Answer the following in no more than 25 seconds: " + the_question.feed.to_s

    message_hash = { :role => "user", :content => gpt_prompt }
    api_messages_array = Array.new
    api_messages_array.push(message_hash)

    the_question.answer = "sample"

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_TOKEN"), request_timeout: 200,)

    response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: api_messages_array,
          temperature: 1.0,
        },
      )

      the_question.answer = response.fetch("choices").at(0).fetch("message").fetch("content")

    if the_question.valid?
      the_question.save
      redirect_to("/prompts/chat/#{the_question.prompt_id}", { :notice => "Question updated successfully."} )
    else
      redirect_to("/prompts/chat/#{the_question.prompt_id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.destroy

    redirect_to("/prompts/chat/#{the_question.prompt_id}", { :notice => "Question deleted successfully."} )
  end
end
