defmodule TrieNode do
  defstruct children: %{}, word_end?: false
end

defmodule Trie do
  defstruct root: %TrieNode{}

  def insert(%Trie{root: root} = trie, word) do
    new_root = do_insert(root, String.graphemes(word))
    %Trie{trie | root: new_root}
  end

  defp do_insert(node, []), do: %{node | word_end?: true}

  defp do_insert(node, [char | rest]) do
    child = Map.get(node.children, char, %TrieNode{})
    updated_child = do_insert(child, rest)
    updated_children = Map.put(node.children, char, updated_child)
    %{node | children: updated_children}
  end

  def search(%Trie{root: root} = _trie, word) do
    do_search(root, String.graphemes(word))
  end

  defp do_search(node, []), do: node.word_end?

  defp do_search(node, [char | rest]) do
    case Map.fetch(node.children, char) do
      :error ->
        false

      {:ok, child} ->
        do_search(child, rest)
    end
  end

  def starts_with?(%Trie{root: root} = _trie, word) do
    do_starts_with?(root, String.graphemes(word))
  end

  defp do_starts_with?(_node, []), do: true

  defp do_starts_with?(node, [char | rest]) do
    case Map.fetch(node.children, char) do
      :error ->
        false

      {:ok, child} ->
        do_starts_with?(child, rest)
    end
  end
end
