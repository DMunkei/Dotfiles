from typing import Literal

type Style = Literal["italic", "bold", "underline"]

# Add parameter annotations `line: str, word: str, style: Style` and a return
# type annotation `-> str` to see if you can find the mistakes in this program.


def with_style(line: str, word: str, style: Style):
    if style == "italic":
        return line.replace(word, f"*{word}*")
    elif style == "bold":
        return line.replace(word, f"__{word}__")

    position = line.find(word)
    output = line + "\n"
    output += " " * position
    output += "-" * len(word)


print(with_style("ty is a fast type checker for Python.", "fast", "underlined"))  #
