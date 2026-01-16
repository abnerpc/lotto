defmodule LottoWeb.NumberHelpers do
  def two_digits(n) when is_integer(n) do
    n
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end
