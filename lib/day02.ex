defmodule Day2 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  def part1 do
    Aoc21.getInput("02") |> Aoc21.getInputList() |> Aoc21.listToKeyword() |> move()
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
    Aoc21.getInput("02") |> Aoc21.getInputList() |> Aoc21.listToKeyword() |> Day2.moveAim()
  end

  def moveAim(inputlist, x \\ 0, z \\ 0, a \\ 0)
  def moveAim([[command | [v | _]] | rest], x, z, a) when command === "forward" do
    moveAim(rest, x + v, z + a * v, a)
  end

  def moveAim([[command | [v | _]] | rest], x, z, a) when command === "up" do
    moveAim(rest, x, z, a - v)
  end

  def moveAim([[command | [v | _]] | rest], x, z, a) when command === "down" do
    moveAim(rest, x, z, a + v)
  end

  def moveAim(_, x, z, _a) do
    x * z
  end
end
