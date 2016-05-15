class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
