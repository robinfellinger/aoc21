defmodule Day8 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("08") |> Aoc21.get_input_list() |> Aoc21.split_list(" | ") |> handle_input()
  end

  defp handle_input(input) do
    input
    |> Enum.map(fn n ->
      n |> handle_line()
    end)
    |> Enum.reduce(&Map.merge(&1, &2, fn _, v1, v2 -> v1 + v2 end))
  end

  defp handle_line(line) do
    match(prepare_signals(line), prepare_output(line))
  end

  defp match(signals, output) do
    output
    |> Enum.reduce(%{1 => 0, 4 => 0, 7 => 0, 8 => 0}, fn n, acc ->
      match = Enum.find(signals, fn {_key, val} -> val == n end)

      match = if match !== nil, do: match |> elem(0)

      map = %{1 => acc[1], 4 => acc[4], 7 => acc[7], 8 => acc[8]}

      if Map.has_key?(map, match) do
        Map.update(map, match, acc[match], fn v -> v + 1 end)
      else
        map
      end
    end)
  end

  defp prepare_signals(line) do
    signals =
      Enum.at(line, 0)
      |> Aoc21.get_input_list(" ")
      |> Enum.map(fn n ->
        String.split(n, "", trim: true) |> Enum.sort()
      end)

    for n <- signals, Enum.member?([2, 4, 3, 7], Enum.count(n)), into: %{} do
      case Enum.count(n) do
        2 -> {1, n}
        4 -> {4, n}
        3 -> {7, n}
        7 -> {8, n}
        _ -> 0
      end
    end
  end

  defp prepare_output(line) do
    Enum.at(line, 1)
    |> Aoc21.get_input_list(" ")
    |> Enum.map(fn n ->
      String.split(n, "", trim: true) |> Enum.sort()
    end)
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("08") |> Aoc21.get_input_list() |> Aoc21.split_list(" | ") |> handle_input2()
  end

  defp handle_input2(input) do
    input
    |> Enum.map(fn n ->
      n |> match_all()
    end)
    |> Enum.map(fn n -> n |> Aoc21.string_to_int() end)
    |> Enum.sum()
  end

  defp match_all(line) do
    signals = prepare_all_signals(line)
    output = prepare_output(line)

    map =
      output
      |> Enum.reduce(%{number: ""}, fn n, acc ->
        match = Enum.find(signals, fn {_key, val} -> val == n end) |> elem(0)

        %{number: acc.number <> Integer.to_string(match)}
      end)

    map.number
  end

  defp prepare_all_signals(line) do
    signals =
      Enum.at(line, 0)
      |> Aoc21.get_input_list(" ")
      |> Enum.map(fn n ->
        String.split(n, "", trim: true) |> Enum.sort()
      end)

    s =
      for n <- signals, Enum.member?([2, 4, 3, 7], Enum.count(n)), into: %{} do
        case Enum.count(n) do
          2 -> {1, n}
          4 -> {4, n}
          3 -> {7, n}
          7 -> {8, n}
          _ -> 0
        end
      end

    signals = signals |> filter_signals(s)
    s = Map.merge(s, signals |> get_digit(Enum.uniq(s[4] ++ s[7]), 9))

    signals = signals |> filter_signals(s)
    s = Map.merge(s, signals |> get_digit(Enum.uniq(s[4] ++ s[7] ++ (s[8] -- s[9])), 0))

    signals = signals |> filter_signals(s)
    s = Map.merge(s, signals |> get_digit(s[7], 3))

    signals = signals |> filter_signals(s)
    s = Map.merge(s, signals |> get_digit(s[9], 5))

    signals = signals |> filter_signals(s)
    s = Map.merge(s, signals |> get_digit(0, 2))

    signals = signals |> filter_signals(s)
    Map.put(s, 6, Enum.at(signals, 0))
  end

  defp filter_signals(signals, map) do
    for n <- signals, Enum.find(map, fn {_key, val} -> val == n end) == nil, do: n
  end

  defp get_digit(signals, subtract, dig) do
    case dig do
      0 ->
        for n <- signals,
            Enum.count(n) == 6 and Enum.count(n -- subtract) === 1,
            into: %{},
            do: {dig, n}

      2 ->
        for n <- signals, Enum.count(n) == 5, into: %{}, do: {dig, n}

      3 ->
        for n <- signals,
            Enum.count(n) == 5 and Enum.count(n -- subtract) === 2,
            into: %{},
            do: {dig, n}

      5 ->
        for n <- signals,
            Enum.count(n) == 5 and Enum.count(subtract -- n) === 1,
            into: %{},
            do: {dig, n}

      9 ->
        for n <- signals,
            Enum.count(n) == 6 and Enum.count(n -- subtract) === 1,
            into: %{},
            do: {dig, n}
    end
  end
end
