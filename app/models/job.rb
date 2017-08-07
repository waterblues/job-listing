class Job < ApplicationRecord
  self.inheritance_column = :_type_disabled
  has_many :resumes
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: {greater_than: 0}
  validates :address, presence: true
  validates :description, presence: true
  validates :require_skill, presence: true
  validates :company, presence: true
  validates :contact_email, presence: true
  validates :many_kind, presence:true
  scope :published, -> {where(is_hidden: false)}
  scope :recent, -> {order('created_at DESC')}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
