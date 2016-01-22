class User
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :role, type: String, default: 'regular'
  field :preferred_working_hours_per_day, type: Float

  has_many :entries, dependent: :destroy
  has_and_belongs_to_many :managed_users, class_name: 'User', inverse_of: nil

  validates :preferred_working_hours_per_day, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 24, allow_blank: true}
  validates :role, presence: true

  enumerize :role, in: %w(regular manager admin), predicates: true
end
