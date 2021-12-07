defmodule Day7 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("07") |> Aoc21.commas_to_int() |> get_least_fuel()
  end

  def get_least_fuel(list, increasing \\ false) do
    list = for n <- 0..Enum.max(list), do: get_fuel(list, n, 0, increasing)
    list |> Enum.min()
  end

  def get_fuel(list, n, fuel \\ 0, increasing \\ false)

  def get_fuel([a | tail], n, fuel, increasing) do
    i = abs(a - n)

    if increasing,
      do: get_fuel(tail, n, fuel + move(i), increasing),
      else: get_fuel(tail, n, fuel + i, increasing)
  end

  def get_fuel(_, _n, fuel, _increasing) do
    fuel
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("07") |> Aoc21.commas_to_int() |> get_least_fuel(true)
  end

  def move(i, sum \\ 0, step \\ 1)

  def move(i, sum, _step) when i === 0 do
    sum
  end

  def move(i, sum, step) do
    move(i - 1, sum + step, step + 1)
  end
end
