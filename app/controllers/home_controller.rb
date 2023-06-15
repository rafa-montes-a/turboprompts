class HomeController < ApplicationController

  def index
    matching_prompts = Prompt.all

    @list_of_prompts = matching_prompts.order({ :created_at => :desc })

    render({ :template => "prompts/index.html.erb" })
  end

end
