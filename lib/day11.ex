defmodule Day11 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("11")
    |> Aoc21.get_input_list()
    |> Enum.map(fn n ->
      String.split(n, "", trim: true) |> Aoc21.list_to_int_list() |> Aoc21.list_to_map()
    end)
    |> Aoc21.list_to_map()
    |> count()
  end

  defp count(map, step \\ 1, count \\ 0)
  defp count(map, step, count) when step > 100, do: count

  defp count(map, step, count) do
    map = map |> advance() |> blink()
    count = count + sum(map)
    count(map |> zeros(), step + 1, count)
  end

  defp advance(map, y \\ 0, x \\ 0)
  defp advance(map, y, x) when x > 9, do: advance(map, y + 1, 0)
  defp advance(map, y, x) when y > 9, do: map

  defp advance(map, y, x) do
    map =
      if map[y][x] === 9 do
        %{map | y => %{map[y] | x => -1}}
      else
        if map[y][x] === -1,
          do: %{map | y => %{map[y] | x => 1}},
          else: %{map | y => %{map[y] | x => map[y][x] + 1}}
      end

    advance(map, y, x + 1)
  end

  defp blink(map, y \\ 0, x \\ 0)
  defp blink(map, y, x) when x > 9, do: blink(map, y + 1, 0)
  defp blink(map, y, x) when y > 9, do: map

  defp blink(map, y, x),
    do:
      if(map[y][x] === -1, do: blink(map |> neighbors(x, y), y, x + 1), else: blink(map, y, x + 1))

  defp sum(map, y \\ 0, x \\ 0, c \\ 0)
  defp sum(map, y, x, c) when x > 9, do: sum(map, y + 1, 0, c)
  defp sum(map, y, x, c) when y > 9, do: c

  defp sum(map, y, x, c),
    do:
      if(map[y][x] === -1 or map[y][x] === -2,
        do: sum(map, y, x + 1, c + 1),
        else: sum(map, y, x + 1, c)
      )

  defp zeros(map, y \\ 0, x \\ 0)
  defp zeros(map, y, x) when x > 9, do: zeros(map, y + 1, 0)
  defp zeros(map, y, x) when y > 9, do: map

  defp zeros(map, y, x),
    do:
      if(map[y][x] === -1 or map[y][x] === -2,
        do: zeros(%{map | y => %{map[y] | x => 0}}, y, x + 1),
        else: zeros(map, y, x + 1)
      )

  defp neighbors(map, x, y) do
    map
    |> neighbor(x - 1, y)
    |> neighbor(x + 1, y)
    |> neighbor(x, y - 1)
    |> neighbor(x, y + 1)
    |> neighbor(x - 1, y - 1)
    |> neighbor(x - 1, y + 1)
    |> neighbor(x + 1, y - 1)
    |> neighbor(x + 1, y + 1)
  end

  defp neighbor(map, x, y) when x < 0 or x > 9 or y < 0 or y > 9, do: map

  defp neighbor(map, x, y) do
    if map[y][x] === 9 do
      %{map | y => %{map[y] | x => -2}} |> neighbors(x, y)
    else
      if map[y][x] in [-1, -2], do: map, else: %{map | y => %{map[y] | x => map[y][x] + 1}}
    end
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("11")
    |> Aoc21.get_input_list()
    |> Enum.map(fn n ->
      String.split(n, "", trim: true) |> Aoc21.list_to_int_list() |> Aoc21.list_to_map()
    end)
    |> Aoc21.list_to_map()
    |> sync()
  end

  defp sync(map, step \\ 1)

  defp sync(map, step) do
    map = map |> advance() |> blink() |> zeros()

    if map |> Map.values() |> Enum.uniq() |> Enum.count() === 1 do
      step
    else
      sync(map, step + 1)
    end
  end
end
