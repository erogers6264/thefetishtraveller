# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  user_agent :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SessionSerializer < ApplicationSerializer
  attributes :id, :user_id, :level

  def level
    object.user.level
  end
end
