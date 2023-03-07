class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: { greater_than: 0 }
  validates :odate, presence: true
  validates :description, presence: true  

  scope :report_by_dates, ->(start_date, end_date) { where("odate BETWEEN ? AND ?", start_date, end_date).group(:category_id).sum(:amount) }

end
