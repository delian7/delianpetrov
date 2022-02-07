require 'active_record'

class Link < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :url, presence: true
end
