defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """

  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @header %{
    :en_US => "Date       | Description               | Change       \n",
    :nl_NL => "Datum      | Omschrijving              | Verandering  \n"
  }

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_, locale, []), do: @header[locale]

  def format_entries(currency, locale, entries) do
    @header[locale] <> get_entries(currency, locale, entries) <> "\n"
  end

  defp get_entries(currency, locale, entries) do
    entries
    |> Enum.sort(&evaluate?/2)
    |> Enum.map(&format_entry(currency, locale, &1))
    |> Enum.join("\n")
  end

  defp evaluate?(a, b) when a.date.day < b.date.day, do: true
  defp evaluate?(a, b) when a.description < b.description, do: true
  defp evaluate?(a, b) when a.amount_in_cents <= b.amount_in_cents, do: true
  defp evaluate?(_, _), do: false

  defp format_entry(currency, locale, entry) do
    year = entry.date.year |> to_string()
    month = entry.date.month |> to_string() |> String.pad_leading(2, "0")
    day = entry.date.day |> to_string() |> String.pad_leading(2, "0")

    date = get_date(locale, year, month, day)

    number = get_number(locale, entry.amount_in_cents)

    amount =
      get_amount(locale, currency, number, entry.amount_in_cents)
      |> String.pad_leading(14, " ")

    description = get_description(entry.description, String.length(entry.description))

    date <> "|" <> description <> " |" <> amount
  end

  defp get_date(:en_US, year, month, day), do: month <> "/" <> day <> "/" <> year <> " "
  defp get_date(_, year, month, day), do: day <> "-" <> month <> "-" <> year <> " "

  defp get_number(:en_US, amount),
    do: get_whole(abs(div(amount, 100)), ",") <> "." <> get_decimal(amount)

  defp get_number(_, amount),
    do: get_whole(abs(div(amount, 100)), ".") <> "," <> get_decimal(amount)

  defp get_decimal(amount),
    do: amount |> abs |> rem(100) |> to_string |> String.pad_leading(2, "0")

  defp get_whole(amount, _) when amount < 1000, do: to_string(amount)

  defp get_whole(amount, delimiter),
    do: to_string(div(amount, 1000)) <> delimiter <> to_string(rem(amount, 1000))

  defp get_symbol(:eur), do: "€"
  defp get_symbol(_), do: "$"

  defp get_amount(:en_US, currency, number, entry) when entry >= 0,
    do: "  #{get_symbol(currency)}#{number} "

  defp get_amount(_, currency, number, entry) when entry >= 0,
    do: "  #{get_symbol(currency)} #{number} "

  defp get_amount(:en_US, currency, number, _), do: " (#{get_symbol(currency)}#{number})"
  defp get_amount(_, currency, number, _), do: " #{get_symbol(currency)} -#{number} "

  defp get_description(description, length) when length > 26,
    do: " " <> String.slice(description, 0, 22) <> "..."

  defp get_description(description, _), do: " " <> String.pad_trailing(description, 25, " ")
end
