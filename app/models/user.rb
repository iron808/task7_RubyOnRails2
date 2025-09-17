class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :user_name, presence:true, on: :create
  validates :email, presence: true, uniqueness:true, on: :create
  validates :password, presence: true, length: { in: 8..24 }, on: :create
  validates :password, confirmation: { message: "確認用パスワードが一致しません" }, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :user_name, presence: true, on: :update, allow_blank: true
  validates :email, presence: true, uniqueness: true, on: :update, allow_blank: true 
  validates :password, length: { in: 8..24 }, on: :update, allow_blank: true  
  validates :password_confirmation,presence: true, on: :update, allow_blank: true  

  def attach_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(Rails.root.join("./app/assets/images/default-myicon.png")),
        filename: "default-myicon.png",
        content_type: "image/png"
      )
    end
  end
end

