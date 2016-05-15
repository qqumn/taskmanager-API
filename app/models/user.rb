class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates_uniqueness_of :email
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  has_many :tasks, dependent: :destroy
  has_many :executive_tasks, class_name: 'Task',
                       foreign_key: :executor_id
  has_many :comments

  scope :updated_today, -> { where('updated_at > ?', Time.now.at_beginning_of_day) }
end
