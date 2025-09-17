class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :checkin_day, presence: true
  validates :checkout_day, presence: true
  validates :number_of_guests, presence: true, numericality: { greater_than_or_equal_to: 1, message: "宿泊日数を入力してください" }
  validate :comparison_checkin_day
  validate :comparison_checkin_day_to_checkout_day

  def comparison_checkin_day
    if checkin_day.present? && checkin_day < Date.today
      errors.add(:checkin_day, "チェックイン日は本日以降を選択してください")
    end
  end

  def comparison_checkin_day_to_checkout_day
    if checkin_day.present? && checkout_day.present?
      if checkout_day <= checkin_day
      errors.add(:checkout_day, "チェックアウト日はチェックイン日以降を選択してください")
      end
    end
  end

end
