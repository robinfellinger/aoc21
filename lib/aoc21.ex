defmodule Aoc21 do
  def get_input(name) do
    filename = name <> ".txt"
    {:ok, body} = File.read("data/" <> filename)
    body
  end

  def get_input_list(input, delimiter \\ "\n") do
    String.split(input, delimiter)
  end

  def string_list_to_atoms(input) do
    for n <- input, do: String.split(n, "", trim: true)
  end

  def list_to_int_list(input) do
    for n <- input, do: String.to_integer(n)
  end

  def list_to_keyword(input) do
    input
    |> Enum.map(fn element ->
      [c | v] = String.split(element, " ")
      [c, String.to_integer(Enum.at(v, 0))]
    end)
  end

  def string_to_int(string) do
    {number, _} = Integer.parse(string)
    number
  end
end
