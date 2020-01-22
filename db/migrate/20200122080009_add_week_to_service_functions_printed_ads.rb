class AddWeekToServiceFunctionsPrintedAds < ActiveRecord::Migration[5.2]
  def up
    add_column :service_functions_printed_ads, :week, :integer, default: 1
    add_column :service_functions_printed_ads, :year, :integer, default: 2020
    set_week
  end

  def down
    remove_column :service_functions_printed_ads, :week, :integer
    remove_column :service_functions_printed_ads, :year, :integer
  end

  private

  def set_week
    ServiceFunctions::PrintedAd.find_each do |printed_ad|
      if printed_ad.start_date
        y, m, d = printed_ad.start_date.strftime("%Y,%m,%e").split(",")
        week = Date.civil(y.to_i, m.to_i, d.to_i).cweek
        printed_ad.update(week: week, year: y.to_i)
      end
    end
  end
end
