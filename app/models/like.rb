# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :integer
#  user_id    :integer
#
class Like < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:prompt, { :required => true, :class_name => "Prompt", :foreign_key => "prompt_id" })
end
