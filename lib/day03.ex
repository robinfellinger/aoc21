defmodule Day3 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    # IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  def part1 do
    Aoc21.getInput("03") |> Aoc21.getInputList() |> Aoc21.stringListToAtoms() |> getPowerUsage()
  end

  def getPowerUsage(input, pos \\ 0, g \\ "", e \\ "")

  def getPowerUsage([head | tail], pos, g, e) when pos > 11 do
    {g, _} = Integer.parse(g, 2)
    {e, _} = Integer.parse(e, 2)

    g * e
  end

  def getPowerUsage(input, pos, g, e) do
    count =
      Enum.reduce(input, %{zero: 0, one: 0}, fn e, acc ->
        if Enum.at(e, pos) === "0" do
          %{zero: acc.zero + 1, one: acc.one}
        else
          %{zero: acc.zero, one: acc.one + 1}
        end
      end)

    if count.one > count.zero do
      getPowerUsage(input, pos + 1, g <> "1", e <> "0")
    else
      getPowerUsage(input, pos + 1, g <> "0", e <> "1")
    end
  end

  #   def part2 do
  #     Aoc21.getInput("02") |> Aoc21.getInputList() |> Aoc21.listToKeyword()
  #   end
end
