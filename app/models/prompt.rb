# == Schema Information
#
# Table name: prompts
#
#  id         :integer          not null, primary key
#  desc       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Prompt < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  has_many(:questions, { :class_name => "Question", :foreign_key => "prompt_id", :dependent => :destroy })
  has_many(:likes, { :class_name => "Like", :foreign_key => "prompt_id", :dependent => :destroy })
  has_many(:sentences, { :class_name => "Sentence", :foreign_key => "prompt_id", :dependent => :destroy })
end
