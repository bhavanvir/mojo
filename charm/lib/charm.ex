defmodule Charm do
  alias Trie

  def hello do
    trie = %Trie{}
    dict = ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"]

    trie =
      Enum.reduce(dict, trie, fn word, acc_trie ->
        Trie.insert(acc_trie, word)
      end)

    IO.inspect(trie, pretty: true)
  end
end
