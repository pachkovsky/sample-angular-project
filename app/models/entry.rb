class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  field :note, type: String
  field :hours, type: Float
  field :date, type: Date

  validates :note, :hours, :date, :user, presence: true
end
