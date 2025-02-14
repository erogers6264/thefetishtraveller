# frozen_string_literal: true

# == Schema Information
#
# Table name: titleholders
#
#  id         :uuid             not null, primary key
#  slug       :string           not null
#  title_id   :uuid             not null
#  user_id    :uuid
#  full_title :string           not null
#  name       :string           not null
#  start_on   :date             not null
#  end_on     :date
#  url        :string
#  abstract   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Titleholder < ApplicationRecord
  extend FriendlyId

  belongs_to :title
  belongs_to :user, optional: true

  friendly_id :full_title, use: :slugged
  validates :full_title, :name, :start_on, presence: true

  has_one_attached :picture
  has_many_attached :gallery_images
end
