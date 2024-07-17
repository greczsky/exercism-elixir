defmodule LibraryFees do
  import NaiveDateTime

  def datetime_from_string(string) do
    from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      to_date(add(checkout_datetime, 28, :day))
    else
      to_date(add(checkout_datetime, 29, :day))
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_date_time = datetime_from_string(return)

    full_rate = days_late(return_date(datetime_from_string(checkout)), return_date_time) * rate

    if monday?(return_date_time) do
      trunc(full_rate * 0.5)
    else
      full_rate
    end
  end
end
