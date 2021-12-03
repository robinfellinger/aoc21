defmodule Day3 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  def part1 do
    Aoc21.get_input("03") |> Aoc21.get_input_list() |> Aoc21.string_list_to_atoms() |> get_power_usage()
  end

  defp get_binary_count(input, pos) do
    Enum.reduce(input, %{zero: 0, one: 0}, fn e, acc ->
      if Enum.at(e, pos) === "0" do
        %{zero: acc.zero + 1, one: acc.one}
      else
        %{zero: acc.zero, one: acc.one + 1}
      end
    end)
  end

  defp get_power_usage(input, pos \\ 0, g \\ "", e \\ "")

  defp get_power_usage(input, pos, g, e) do
    if Enum.at(input, 0) |> Enum.count() === pos do
      {g, _} = Integer.parse(g, 2)
      {e, _} = Integer.parse(e, 2)
      g * e
    else
      count = get_binary_count(input, pos)

      if count.one > count.zero do
        get_power_usage(input, pos + 1, g <> "1", e <> "0")
      else
        get_power_usage(input, pos + 1, g <> "0", e <> "1")
      end
    end
  end

  def part2 do
    Aoc21.get_input("03") |> Aoc21.get_input_list() |> Aoc21.string_list_to_atoms() |> getLifeSupport()
  end

  defp getLifeSupport(input) do
    get_rating(input) * get_rating(input, true)
  end

  defp get_rating(input, inverted \\ false, pos \\ 0)

  defp get_rating(input, inverted, pos) when pos <= 11 do
    count = get_binary_count(input, pos)

    is_one = if inverted, do: count.one < count.zero, else: count.one >= count.zero

    input = trim_input(input, pos, is_one)

    if input |> Enum.count() === 1 do
      [head | _] = input
      {result, _} = Integer.parse(Enum.join(head), 2)
      result
    else
      get_rating(input, inverted, pos + 1)
    end
  end

  defp trim_input(input, pos, one) do
    number = if one, do: "1", else: "0"
    for n <- input, Enum.at(n, pos) == number, do: n
  end
end
