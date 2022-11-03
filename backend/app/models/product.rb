class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  field :volume, :type => Integer, default: -> { length * width * height }
  index({ volume: 1 }, { name: "volume" })

  before_save :update_volume

  validates_presence_of :name, :type, :length, :width, :height, :weight

  private

  def update_volume
    self.volume = length * width * height
  end
end
