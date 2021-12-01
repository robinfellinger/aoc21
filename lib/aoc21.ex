defmodule Aoc21 do
  def getInput(name) do
    filename = name <> ".txt"
    {:ok, body} = File.read("data/" <> filename)
    body
  end

  def getInputList(input) do
    String.split(input, "\n")
  end

  def listToIntList(input) do
    for n <- input, do: String.to_integer(n)
  end

  def hello do
    :world
  end
end
