class Session
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :user
  field :token, type: String

  before_validation :set_token, on: :create

  validates :user, :token, presence: true

  private
  def set_token
    self.token = SecureRandom.hex(32)
  end
end
