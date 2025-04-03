defmodule Mojo do
  alias Trie

  def create_dict, do: %Trie{}

  def update_dict(root, input) when is_list(input) do
    Enum.reduce(input, root, fn word, acc_trie ->
      Trie.insert(acc_trie, word)
    end)
  end

  def update_dict(root, input) when is_binary(input) do
    Trie.insert(root, input)
  end

  def in_dict?(root, word) do
    Trie.search(root, word)
  end

  def prefix_matches(root, prefix) do
    Trie.prefix_matches(root, prefix)
  end

  def parse(root, passage) do
    Enum.reduce(passage, %{}, fn word, errors ->
      case Mojo.in_dict?(root, word) do
        true -> errors
        false -> Map.put(errors, word, Mojo.prefix_matches(root, word))
      end
    end)
  end
end
