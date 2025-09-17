class Room < ApplicationRecord
  has_one_attached :roomimage
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :room_name, presence: true
  validates :room_details, presence: true
  validates :room_rate, numericality: { greater_than_or_equal_to: 1, message:"料金は1円以上を入力してください"}
  validates :facility_address, presence: true

  def attach_default_roomimage
    unless roomimage.attached?
      roomimage.attach(
        io: File.open(Rails.root.join("app/assets/images/default-myroom.png")),
        filename: "default-myroom.png",
        content_type: "image/png"
      )
    end
  end

end