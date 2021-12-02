defmodule Day1 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  def part1 do
    Aoc21.getInput("01") |> Aoc21.getInputList() |> Aoc21.listToIntList() |> Day1.getIncreased()
  end

  def getIncreased(inputList) do
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
    Aoc21.getInput("01")
    |> Aoc21.getInputList()
    |> Aoc21.listToIntList()
    |> Day1.getIncreased2()
  end

  def getIncreased2(inputlist, increase \\ 0)

  def getIncreased2([a, b, c, d | tail], increase) when a + b + c >= b + c + d do
    getIncreased2([b, c, d | tail], increase)
  end

  def getIncreased2([a, b, c, d | tail], increase) when a + b + c < b + c + d do
    getIncreased2([b, c, d | tail], increase + 1)
  end

  def getIncreased2(_, increase) do
    increase
  end
end
