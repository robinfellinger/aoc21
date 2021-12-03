defmodule Aoc21 do
  def getInput(name) do
    filename = name <> ".txt"
    {:ok, body} = File.read("data/" <> filename)
    body
  end

  def getInputList(input) do
    String.split(input, "\n")
  end

  def stringListToAtoms(input) do
    for n <- input, do: String.split(n, "", trim: true)
  end

  def listToIntList(input) do
    for n <- input, do: String.to_integer(n)
  end

  def listToKeyword(input) do
    input
    |> Enum.map(fn element ->
      [c | v] = String.split(element, " ")
      [c, String.to_integer(Enum.at(v, 0))]
    end)
  end
end
