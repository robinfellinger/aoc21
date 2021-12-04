defmodule Day4 do
  def main do
    IO.puts("Part 1: " <> Integer.to_string(part1()))
    IO.puts("Part 2: " <> Integer.to_string(part2()))
  end

  # 🎄------------------PART-1---------------------🎄
  def part1 do
    Aoc21.get_input("04") |> Aoc21.get_input_list("\n\n") |> prepare_bingo()
  end

  defp prepare_bingo([numbers | boards]) do
    boards = for n <- boards, do: String.split(n, "\n", trim: true) |> split_board_numbers()
    numbers = String.split(numbers, ",", trim: true)
    bingo(numbers, boards)
  end

  defp split_board_numbers(board) do
    for n <- board, do: String.split(n, " ", trim: true)
  end

  defp bingo(numbers, boards, won \\ 0, last \\ false)

  defp bingo(_numbers, _boards, won, _last) when won !== 0 do
    won
  end

  defp bingo(numbers, boards, won, last) do
    [number | numbers] = numbers

    boards = tick_number(boards, number)
    {number, _} = Integer.parse(number)

    if last and Enum.count(boards) === 1 do
      bingo(numbers, boards, calculate_won(boards) * number, last)
    else
      if last do
        boards = remove_won(boards)
        bingo(numbers, boards, won, last)
      else
        won = calculate_won(boards) * number
        bingo(numbers, boards, won, last)
      end
    end
  end

  defp tick_number(boards, number) do
    boards
    |> Enum.map(fn board ->
      board
      |> Enum.map(fn row ->
        row
        |> Enum.map(fn
          ^number -> "X"
          x -> x
        end)
      end)
    end)
  end

  defp calculate_won(boards) do
    x =
      Enum.reduce(boards, %{sum: 0}, fn board, acc ->
        %{sum: acc.sum + calculate_board_won(board)}
      end)

    x[:sum]
  end

  defp calculate_board_won(board) do
    if board |> board_won_horizontally() or board |> board_won_vertically() do
      board_add(board)
    else
      0
    end
  end

  defp board_won_horizontally(board) do
    result =
      board
      |> Enum.map(fn row ->
        if Enum.join(row, "") == "XXXXX" do
          true
        else
          false
        end
      end)

    Enum.member?(result, true)
  end

  defp board_won_vertically(board) do
    vertical =
      for col <- 0..4,
          Enum.at(Enum.at(board, 0), col) === "X" and check_columns(board, col),
          do: col

    vertical !== []
  end

  defp check_columns(board, col) do
    column = for r <- 1..4, Enum.at(Enum.at(board, r), col) === "X", do: r

    if Enum.count(column) === 4 do
      true
    else
      false
    end
  end

  defp board_add(board) do
    x =
      Enum.reduce(board, %{sum: 0}, fn row, acc ->
        x =
          Enum.reduce(row, %{sum: 0}, fn e, acc ->
            if e !== "X" do
              {number, _} = Integer.parse(e)
              %{sum: acc.sum + number}
            else
              %{sum: acc.sum}
            end
          end)

        %{sum: acc.sum + x[:sum]}
      end)

    x[:sum]
  end

  # 🎄------------------PART-2---------------------🎄
  def part2 do
    Aoc21.get_input("04") |> Aoc21.get_input_list("\n\n") |> prepare_bingo_last()
  end

  defp prepare_bingo_last([numbers | boards]) do
    boards = for n <- boards, do: String.split(n, "\n", trim: true) |> split_board_numbers()
    numbers = String.split(numbers, ",", trim: true)
    bingo(numbers, boards, 0, true)
  end

  defp remove_won(boards) do
    for n <- boards, calculate_board_won(n) === 0, do: n
  end
end
