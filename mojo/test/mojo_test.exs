defmodule MojoTest do
  use ExUnit.Case
  doctest Mojo

  setup _context do
    root =
      Mojo.create_dict()
      |> Mojo.update_dict("word")

    %{root: root}
  end

  test "build a dictionary", %{root: root} do
    assert root ==
             %Trie{
               root: %TrieNode{
                 children: %{
                   "w" => %TrieNode{
                     children: %{
                       "o" => %TrieNode{
                         children: %{
                           "r" => %TrieNode{
                             children: %{"d" => %TrieNode{children: %{}, is_terminal: true}},
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
  end

  test "search for a valid word", %{root: root} do
    assert Mojo.in_dict?(root, "word") == true
  end

  test "search for an invalid word", %{root: root} do
    assert Mojo.in_dict?(root, "words") == false
  end

  test "find word with a valid prefix", %{root: root} do
    assert Mojo.prefix_matches(root, "wo") == ["word"]
  end

  test "find word with an invalid prefix", %{root: root} do
    assert Mojo.prefix_matches(root, "o") == []
  end

  test "find corrections for errors in passage", %{root: root} do
    assert Mojo.parse(root, ["woords"]) == %{"woords" => ["word"]}
  end
end
