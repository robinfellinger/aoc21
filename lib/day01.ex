defmodule Day1 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  def part1 do
    Aoc21.get_input("01")
    |> Aoc21.get_input_list()
    |> Aoc21.list_to_int_list()
    |> Day1.get_increased()
  end

  def get_increased(inputList) do
    map =
      Enum.reduce(inputList, %{last: nil, increase: 0}, fn e, acc ->
        if acc.last < e do
          %{last: e, increase: acc.increase + 1}
        else
          %{last: e, increase: acc.increase}
        end
      end)

    map.increase
  end

  def part2 do
    Aoc21.get_input("01")
    |> Aoc21.get_input_list()
    |> Aoc21.list_to_int_list()
    |> Day1.get_increased2()
  end

  def get_increased2(inputlist, increase \\ 0)

  def get_increased2([a, b, c, d | tail], increase) when a + b + c >= b + c + d do
    get_increased2([b, c, d | tail], increase)
  end

  def get_increased2([a, b, c, d | tail], increase) when a + b + c < b + c + d do
    get_increased2([b, c, d | tail], increase + 1)
  end

  def get_increased2(_, increase) do
    increase
  end
end
