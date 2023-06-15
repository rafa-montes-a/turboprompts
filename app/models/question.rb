# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  answer     :text
#  feed       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :integer
#  user_id    :integer
#
class Question < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:prompt, { :required => true, :class_name => "Prompt", :foreign_key => "prompt_id" })
end
