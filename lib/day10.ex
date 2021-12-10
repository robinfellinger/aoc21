defmodule Day10 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("10")
    |> Aoc21.get_input_list()
    |> Enum.map(fn n -> String.split(n, "", trim: true) |> Aoc21.list_to_char_list() end)
    |> score()
  end

  defp score(list, score \\ 0)

  defp score(list, score) when list === [], do: score

  defp score([current | rest], score) do
    s = filter(current, closure(current)) |> get_score()
    score(rest, score + s)
  end

  defp closure(row) do
    hits =
      row
      |> Enum.reduce(%{last: nil, i: 0, hits: []}, fn e, acc ->
        case {acc.last, e} do
          {'(', ')'} -> %{last: e, i: acc.i + 1, hits: acc.hits ++ [acc.i - 1] ++ [acc.i]}
          {'<', '>'} -> %{last: e, i: acc.i + 1, hits: acc.hits ++ [acc.i - 1] ++ [acc.i]}
          {'{', '}'} -> %{last: e, i: acc.i + 1, hits: acc.hits ++ [acc.i - 1] ++ [acc.i]}
          {'[', ']'} -> %{last: e, i: acc.i + 1, hits: acc.hits ++ [acc.i - 1] ++ [acc.i]}
          _ -> %{last: e, i: acc.i + 1, hits: acc.hits}
        end
      end)

    hits.hits
  end

  defp filter(list, filter_list) when filter_list === [], do: list

  defp filter(list, filter_list) do
    list =
      for i <- 0..(Enum.count(list) - 1),
          not Enum.member?(filter_list, i) == true,
          do: Enum.at(list, i)

    filter(list, closure(list))
  end

  defp get_score(list, score \\ 0)

  defp get_score(list, score) when score !== 0 or list === [], do: score

  defp get_score([char | rest], _score) do
    score =
      case char do
        ')' -> 3
        ']' -> 57
        '}' -> 1197
        '>' -> 25137
        _ -> 0
      end

    get_score(rest, score)
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("10")
    |> Aoc21.get_input_list()
    |> Enum.map(fn n -> String.split(n, "", trim: true) |> Aoc21.list_to_char_list() end)
    |> auto_score()
  end

  defp auto_score(list, score \\ [])

  defp auto_score(list, score) when list === [] do
    Enum.at(Enum.sort(score), div(Enum.count(score) - 1, 2))
  end

  defp auto_score([current | rest], score) do
    current = filter(current, closure(current))

    if valid(current) do
      auto_score(rest, score ++ [get_auto_score(Enum.reverse(current))])
    else
      auto_score(rest, score)
    end
  end

  defp valid(list) do
    list = for n <- list, Enum.member?([')', ']', '}', '>'], n), do: n
    list === []
  end

  defp get_auto_score(list, score \\ 0)
  defp get_auto_score(list, score) when list === [], do: score

  defp get_auto_score([char | rest], score) do
    s =
      case char do
        '(' -> 1
        '[' -> 2
        '{' -> 3
        '<' -> 4
        _ -> 0
      end

    get_auto_score(rest, score * 5 + s)
  end
end
