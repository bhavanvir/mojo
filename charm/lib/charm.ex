defmodule Charm do
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

  def suggestions(root, word) do
    Trie.matches(root, word)
  end
end
