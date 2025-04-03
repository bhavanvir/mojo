defmodule Mojo do
  @moduledoc """
  Implements interface functions using the Trie module under-the-hood.
  """
  alias Trie

  @doc """
  Creates an empty dictionary.

  Returns a `%Trie{}`.

  ## Examples

    iex> Mojo.create_dict()
    %Trie{root: %TrieNode{children: %{}, is_terminal: false}}

  """
  def create_dict, do: %Trie{}

  @doc """
  Updates a dictionary given a list of words, or a single word.

  Returns an updated `%Trie{}`.

  ## Examples

    iex> dict = Mojo.create_dict()
    iex> updated_dict = Mojo.update_dict(dict, ["word1", "word2"])
    iex> updated_dict
    %Trie{
      root: %TrieNode{
        children: %{
          "w" => %TrieNode{
            children: %{
              "o" => %TrieNode{
                children: %{
                  "r" => %TrieNode{
                    children: %{
                      "d" => %TrieNode{
                        children: %{
                          "1" => %TrieNode{children: %{}, is_terminal: true},
                          "2" => %TrieNode{children: %{}, is_terminal: true}
                        },
                        is_terminal: false
                      }
                    },
                    is_terminal: false
                  }
                },
                is_terminal: false
              }
            },
            is_terminal: false
          }
        },
        is_terminal: false
      }
    }

    iex> dict = Mojo.create_dict()
    iex> updated_dict = Mojo.update_dict(dict, "word3")
    iex> updated_dict
    %Trie{
      root: %TrieNode{
        children: %{
          "w" => %TrieNode{
            children: %{
              "o" => %TrieNode{
                children: %{
                  "r" => %TrieNode{
                    children: %{
                      "d" => %TrieNode{
                        children: %{
                          "3" => %TrieNode{children: %{}, is_terminal: true}
                        },
                        is_terminal: false
                      }
                    },
                    is_terminal: false
                  }
                },
                is_terminal: false
              }
            },
            is_terminal: false
          }
        },
        is_terminal: false
      }
    }
  """
  def update_dict(root, input) when is_list(input) do
    Enum.reduce(input, root, fn word, acc_trie ->
      Trie.insert(acc_trie, word)
    end)
  end

  def update_dict(root, input) when is_binary(input) do
    Trie.insert(root, input)
  end

  @doc """
  Checks if a word exists in a dictionary.

  Returns an `Atom` representing `true`, or `false`.

  ## Examples

    iex> dict = Mojo.create_dict()
    iex> dict = Mojo.update_dict(dict, "word3")
    iex> Mojo.in_dict?(dict, "word3")
    true 
    iex> Mojo.in_dict?(dict, "word4")
    false
  """
  def in_dict?(root, word) do
    Trie.search(root, word)
  end

  @doc """
  Returns all words that match a given prefix.

  Returns a `List`.

  ## Examples
    
    iex> dict = Mojo.create_dict()
    iex> dict = Mojo.update_dict(dict, ["word1", "word2", "word3"])
    iex> Mojo.prefix_matches(dict, "word")
    ["word1", "word2", "word3"]
  """
  def prefix_matches(root, prefix) do
    Trie.prefix_matches(root, prefix)
  end

  @doc """
  Maps any error in a passage with their closest matches in the dictionary.

  Returns a `%{}`.

  ## Examples

    iex> dict = Mojo.create_dict()
    iex> dict = Mojo.update_dict(dict, ["word1", "word2", "word3"])
    iex> Mojo.parse(dict, ["werd"])
    %{"werd" => ["word1", "word2", "word3"]}
  """
  def parse(root, passage) do
    Enum.reduce(passage, %{}, fn word, errors ->
      case Mojo.in_dict?(root, word) do
        true -> errors
        false -> Map.put(errors, word, Mojo.prefix_matches(root, word))
      end
    end)
  end
end
