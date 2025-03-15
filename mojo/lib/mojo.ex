defmodule Mojo do
  alias Trie

  def build_dict(dict) do
    trie = %Trie{}

    trie =
      Enum.reduce(dict, trie, fn word, acc_trie ->
        Trie.insert(acc_trie, word)
      end)

    trie
  end

  def in_dict?(root, word) do
    Trie.search(root, word)
  end

  def prefix_matches(root, word) do
    Trie.matches(root, word)
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
