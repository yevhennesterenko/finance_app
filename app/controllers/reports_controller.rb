class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    start_date = params["start_date"]
    end_date = params["end_date"]
    odata = Operation.where("odate BETWEEN ? AND ?", start_date, end_date).group(:category_id).sum(:amount)
    cat_id = odata.map { |e| e[0]}
    @ocategories_name = []
      cat_id.each do |element|
        var = Category.where(id: element).pluck(:name)
        @ocategories_name = @ocategories_name + var
      end
    @oamounts = odata.map {|e| e[1]}
  end

  def report_by_dates
    start_date = params["start_date"]
    end_date = params["end_date"]
    category_id = params["category_id"]
    operations_between_dates = Operation.where("odate BETWEEN ? AND ?", start_date, end_date).where(category_id: category_id).order(:odate)
    data = operations_between_dates.map { |e| [e.odate.to_s, e.amount]}
    @dates = data.map { |e| e[0]}
    @amounts = data.map {|e| e[1]}
  end
end
