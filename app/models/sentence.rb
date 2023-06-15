# == Schema Information
#
# Table name: sentences
#
#  id         :integer          not null, primary key
#  content    :text
#  kind       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :integer
#
class Sentence < ApplicationRecord
  belongs_to(:prompt, { :required => true, :class_name => "Prompt", :foreign_key => "prompt_id" })
end
