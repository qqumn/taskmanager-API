class Task < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 3 },
                   on: :update

  belongs_to :user
  belongs_to :executor, class_name: User
  belongs_to :project

  has_many :comments, as: :commentable

  enum status: [:not_started, :in_progress, :done]
end

