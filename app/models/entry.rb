class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, index: true
  field :note, type: String
  field :hours, type: Float
  field :date, type: Date

  validates :note, :hours, :date, :user, presence: true

  validates :hours, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 24, allow_blank: true}
end
