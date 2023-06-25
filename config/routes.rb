Rails.application.routes.draw do

  # Home 
  get("/", { :controller => "home", :action => "index" })

  # Routes for the Like resource:

  # CREATE
  get("/insert_like/:prompt_id", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:like_id/:prompt_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Question resource:

  # CREATE
  post("/insert_question", { :controller => "questions", :action => "create" })
          
  # READ
  get("/questions", { :controller => "questions", :action => "index" })
  
  get("/questions/:path_id", { :controller => "questions", :action => "show" })
  
  # UPDATE
  
  get("/modify_question/:path_id", { :controller => "questions", :action => "update" })
  
  # DELETE
  get("/delete_question/:path_id", { :controller => "questions", :action => "destroy" })

  #------------------------------

  # Routes for the Sentence resource:

  # CREATE
  post("/insert_sentence", { :controller => "sentences", :action => "create" })
          
  # READ
  get("/sentences", { :controller => "sentences", :action => "index" })
  
  get("/sentences/:path_id", { :controller => "sentences", :action => "show" })
  
  # UPDATE
  
  post("/modify_sentence/:path_id", { :controller => "sentences", :action => "update" })
  
  # DELETE
  get("/delete_sentence/:sentence_id/:prompt_id", { :controller => "sentences", :action => "destroy" })

  #------------------------------

  # Routes for the Prompt resource:

  # CREATE
  post("/insert_prompt", { :controller => "prompts", :action => "create" })
  get("/duplicate_prompt/:old_prompt_id", { :controller => "prompts", :action => "duplicate" })
          
  # READ
  get("/prompts", { :controller => "home", :action => "index" })

  get("/prompts/new", { :controller => "prompts", :action => "new" })
  get("/prompts/:path_id", { :controller => "prompts", :action => "show" })
  get("/prompts/chat/:path_id", { :controller => "prompts", :action => "chat" })
  
  # UPDATE
  
  post("/modify_prompt/:path_id", { :controller => "prompts", :action => "update" })
  
  # DELETE
  get("/delete_prompt/:path_id", { :controller => "prompts", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  get("/admin", { :controller => "user_authentication", :action => "index" })
  
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
