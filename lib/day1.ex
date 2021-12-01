defmodule Day1 do
  def main do
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
end
