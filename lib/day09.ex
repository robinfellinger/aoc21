defmodule Day9 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("09")
    |> Aoc21.get_input_list()
    |> Enum.map(fn n -> String.split(n, "", trim: true) |> Aoc21.list_to_int_list() end)
    |> sum_low_points()
  end

  defp sum_low_points(list, row \\ 0, sum \\ 0) do
    if(Enum.count(list) === row) do
      sum
    else
      # sum = sum + 1

      max_row = Enum.count(list) - 1
      max_col = list |> Enum.at(0) |> Enum.count()
      max_col = max_col - 1

      current_row = list |> Enum.at(row)

      y = row

      lows =
        for x <- 0..max_col do
          # right check
          val =
            if x + 1 > max_col or Enum.at(current_row, x) < Enum.at(current_row, x + 1) do
              # left check
              if x - 1 < 0 or Enum.at(current_row, x) < Enum.at(current_row, x - 1) do
                # up check
                if y - 1 < 0 or Enum.at(current_row, x) < Enum.at(Enum.at(list, y - 1), x) do
                  # down check
                  if y + 1 > max_row or Enum.at(current_row, x) < Enum.at(Enum.at(list, y + 1), x) do
                    Enum.at(current_row, x) + 1
                  end
                end
              end
            end

          if val, do: val, else: 0
        end

      sum = sum + Enum.sum(lows)
      sum_low_points(list, row + 1, sum)
    end
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("09") |> Aoc21.get_input_list()
  end
end
