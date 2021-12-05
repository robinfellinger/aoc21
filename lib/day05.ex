defmodule Day5 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("05") |> Aoc21.get_input_list() |> find_vents()
  end

  defp find_vents(input, grid \\ []) when grid === [] do
    grid = create_grid(1000)
    find_vents(input, grid)
  end

  defp find_vents(input, grid) when input === [] do
    vents = for n <- List.flatten(grid), n > 1, do: n
    Enum.count(vents)
  end

  defp find_vents([line | rest], grid) do
    grid = handle_input(line, grid)
    find_vents(rest, grid)
  end

  defp create_grid(size) do
    y = List.duplicate([], size)
    for n <- y, do: List.duplicate(0, size)
  end

  defp handle_input(line, grid) do
    [one | [two | _]] = String.split(line, " -> ")
    [x1 | [y1 | _]] = String.split(one, ",")
    [x2 | [y2 | _]] = String.split(two, ",")

    x1 = Aoc21.string_to_int(x1)
    y1 = Aoc21.string_to_int(y1)

    x2 = Aoc21.string_to_int(x2)
    y2 = Aoc21.string_to_int(y2)

    if is_relevant(x1, y1, x2, y2) do
      track_grid(grid, x1, y1, x2, y2)
    else
      grid
    end
  end

  defp is_relevant(x1, y1, x2, y2) do
    x1 === x2 or y1 == y2
  end

  defp track_grid(grid, x1, y1, x2, y2) do
    if x1 === x2 do
      track_col(grid, x1, y1, y2)
    else
      List.replace_at(grid, y1, track_row(Enum.at(grid, y1), x1, x2))
    end
  end

  defp track_row(row, x, x_max) do
    row = List.replace_at(row, x, Enum.at(row, x) + 1)

    if x === x_max do
      row
    else
      x = if x <= x_max - 1, do: x + 1, else: x - 1
      track_row(row, x, x_max)
    end
  end

  defp track_col(grid, x, y, y_max) do
    row = Enum.at(grid, y)
    row = List.replace_at(row, x, Enum.at(row, x) + 1)

    grid = List.replace_at(grid, y, row)

    if y === y_max do
      grid
    else
      y = if y <= y_max - 1, do: y + 1, else: y - 1
      track_col(grid, x, y, y_max)
    end
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("05") |> Aoc21.get_input_list() |> find_vents2()
  end

  defp find_vents2(input, grid \\ []) when grid === [] do
    grid = create_grid(1000)
    find_vents2(input, grid)
  end

  defp find_vents2(input, grid) when input === [] do
    vents = for n <- List.flatten(grid), n > 1, do: n
    Enum.count(vents)
  end

  defp find_vents2([line | rest], grid) do
    grid = handle_input2(line, grid)
    find_vents2(rest, grid)
  end

  # 0,9 -> 5,9
  # 8,0 -> 0,8

  defp handle_input2(line, grid) do
    [one | [two | _]] = String.split(line, " -> ")
    [x1 | [y1 | _]] = String.split(one, ",")
    [x2 | [y2 | _]] = String.split(two, ",")

    x1 = Aoc21.string_to_int(x1)
    y1 = Aoc21.string_to_int(y1)

    x2 = Aoc21.string_to_int(x2)
    y2 = Aoc21.string_to_int(y2)

    track_grid2(grid, x1, y1, x2, y2)
  end

  defp track_grid2(grid, x1, y1, x2, y2) do
    if x1 === x2 do
      track_col(grid, x1, y1, y2)
    else
      if y1 == y2 do
        List.replace_at(grid, y1, track_row(Enum.at(grid, y1), x1, x2))
      else
        track_vert(grid, x1, x2, y1, y2)
      end
    end
  end

  defp track_vert(grid, x, x_max, y, y_max) do
    row = Enum.at(grid, y)
    row = List.replace_at(row, x, Enum.at(row, x) + 1)

    grid = List.replace_at(grid, y, row)

    if x === x_max or y === y_max do
      grid
    else
      x = if x <= x_max - 1, do: x + 1, else: x - 1
      y = if y <= y_max - 1, do: y + 1, else: y - 1

      track_vert(grid, x, x_max, y, y_max)
    end
  end
end
