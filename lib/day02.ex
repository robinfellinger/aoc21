defmodule Day2 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  def part1 do
    Aoc21.get_input("02") |> Aoc21.get_input_list() |> Aoc21.list_to_keyword() |> move()
  end

  def move(inputlist, x \\ 0, z \\ 0)

  def move([[command | [v | _]] | rest], x, z) when command === "forward" do
    move(rest, x + v, z)
  end

  def move([[command | [v | _]] | rest], x, z) when command === "up" do
    move(rest, x, z - v)
  end

  def move([[command | [v | _]] | rest], x, z) when command === "down" do
    move(rest, x, z + v)
  end

  def move(_, x, z) do
    x * z
  end

  def part2 do
    Aoc21.get_input("02") |> Aoc21.get_input_list() |> Aoc21.list_to_keyword() |> Day2.move_aim()
  end

  def move_aim(inputlist, x \\ 0, z \\ 0, a \\ 0)

  def move_aim([[command | [v | _]] | rest], x, z, a) when command === "forward" do
    move_aim(rest, x + v, z + a * v, a)
  end

  def move_aim([[command | [v | _]] | rest], x, z, a) when command === "up" do
    move_aim(rest, x, z, a - v)
  end

  def move_aim([[command | [v | _]] | rest], x, z, a) when command === "down" do
    move_aim(rest, x, z, a + v)
  end

  def move_aim(_, x, z, _a) do
    x * z
  end
end
