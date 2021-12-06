defmodule Day6 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("06") |> Aoc21.commas_to_int() |> get_count()
  end



  defp get_count(fishes, max_days \\ 80) do
    fishes = fishes
    |> Enum.reduce(%{count: 0}, fn fish, acc ->
      %{count: acc.count + calc_fish(fish, max_days).count + 1}
    end)
    fishes.count
  end

  defp calc_fish(fish, max_days, day \\ 0,  state \\ %{count: 0})

  defp calc_fish(fish, max_days, day, state) when fish + 1 > max_days - day, do: state

  defp calc_fish(fish, max_days, day, state) do
    day = day + fish + 1
    remaining = max_days - day

    # use count from state
    if Map.has_key?(state, remaining) do
      %{state | count: state.count + state[remaining]}
    else
      # add count
      state = %{state | count: state.count + 1}

      # add self
      state = merge_counts(calc_fish(6, max_days, day, %{state | count: 0}), state)

      # add offsprings
      state = merge_counts(calc_fish(8, max_days, day, %{state | count: 0}), state)

      # save count for remaining days
      Map.put(state, remaining, state.count)
    end
  end

  defp merge_counts(new_state, state) do
    Map.merge(new_state, %{state | count: state.count + new_state.count})
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    fishes = Aoc21.get_input("06") |> Aoc21.commas_to_int()
    get_count(fishes, 256)
  end


end
