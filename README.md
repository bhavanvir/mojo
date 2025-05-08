# Mojo

**Mojo** is an Elixir library for building and validating dictionaries using a Trie-based data structure. It offers an intuitive interface for creating custom dictionaries, checking word presence, finding prefix matches, and mapping unknown words to their closest matches.

## ✨ Features

* Create and manage custom dictionaries using Tries
* Insert single or multiple words
* Check if a word exists in the dictionary
* Retrieve all words with a given prefix
* Parse a passage to detect unknown words and suggest alternatives

## 🚀 Installation

Add `mojo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mojo, "~> 0.1.0"}
  ]
end
```

Then run:

```sh
mix deps.get
```

## 📦 Usage

```elixir
# Create a new dictionary
dict = Mojo.create_dict()

# Insert multiple words
dict = Mojo.update_dict(dict, ["apple", "application", "appetite"])

# Insert a single word
dict = Mojo.update_dict(dict, "approve")

# Check if a word exists
Mojo.in_dict?(dict, "apple")
# => true

Mojo.in_dict?(dict, "banana")
# => false

# Get all words with a prefix
Mojo.prefix_matches(dict, "app")
# => ["apple", "application", "appetite", "approve"]

# Parse a passage and suggest corrections for unknown words
Mojo.parse(dict, ["appl", "approv", "banana"])
# => %{
#      "appl" => ["apple", "application", "appetite"],
#      "approv" => ["approve"],
#      "banana" => []
#    }
```

## 📄 License

This project is licensed under the [MIT License](LICENSE).

## 🙌 Contributing

Pull requests and suggestions are welcome. Please open an issue first to discuss major changes.
