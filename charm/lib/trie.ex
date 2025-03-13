defmodule TrieNode do
  defstruct children: %{}, end_of_word?: false
end

defmodule Trie do
  defstruct root: %TrieNode{}

  def insert(%Trie{root: root} = trie, word) do
    new_root = _insert(root, String.graphemes(word))
    %Trie{trie | root: new_root}
  end

  defp _insert(node, []), do: %{node | end_of_word?: true}

  defp _insert(node, [char | rest]) do
    child = Map.get(node.children, char, %TrieNode{})
    updated_child = _insert(child, rest)
    updated_children = Map.put(node.children, char, updated_child)
    %{node | children: updated_children}
  end

  def search(%Trie{root: root}, word) do
    _search(root, String.graphemes(word))
  end

  defp _search(node, []), do: node.end_of_word?

  defp _search(node, [char | rest]) do
    case Map.fetch(node.children, char) do
      :error ->
        false

      {:ok, child} ->
        _search(child, rest)
    end
  end

  def matches(%Trie{root: root}, word) do
    prefix = longest_prefix(root, String.graphemes(word), "")

    case prefix do
      "" ->
        []

      _ ->
        case leaf_children(root, String.graphemes(prefix)) do
          nil ->
            []

          node ->
            collect_words(node, prefix)
        end
    end
  end

  defp longest_prefix(_node, [], prefix), do: prefix

  defp longest_prefix(node, [char | rest], prefix) do
    case Map.fetch(node.children, char) do
      :error ->
        prefix

      {:ok, child} ->
        longest_prefix(child, rest, prefix <> char)
    end
  end

  defp leaf_children(node, []), do: node

  defp leaf_children(node, [char | rest]) do
    case Map.fetch(node.children, char) do
      :error ->
        nil

      {:ok, child} ->
        leaf_children(child, rest)
    end
  end

  defp collect_words(node, prefix) do
    words =
      node.children
      |> Enum.flat_map(fn {char, child} -> collect_words(child, prefix <> char) end)

    if node.end_of_word?, do: [prefix | words], else: words
  end
end
