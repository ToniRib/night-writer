# Night Writer
## Turing Module 1: Project 2 (Echo)

### Overview
This project contains executables to convert a file with English text into a new file with translated braille text, and back again the other direction.

This [text to braille dictionary](http://braillebug.afb.org/braille_print.asp) was used for the project. Throughout the project, the character '0' represents a raised dot while the character '.' represents an unraised space.

### Night Writer
The night writer portion takes a file containing English text as input and outputs a file containing that text translated into braille. If the braille text is longer than 80 characters it will be wrapped onto a new line. Each one line of English text corresponds to three lines of braille since each braille characters is 3 rows and 2 columns.

The output to the terminal will display the name of the braille file that was created and the number of braille characters in the file.

#### Example

contents of: text/hello_world.txt
```
Hello, Toni! How's it going? You're 26 today.
```

```
ruby lib/night_writer.rb text/hello_world.txt braille/hello_world_braille.txt
=> Created braille/hello_world_braille.txt containing 50 braille characters
```

contents of: braille/hello_world_braille.txt
```
..0.0.0.0.0........00.00.0......0.0..0...0...0.0..000..00000......000.0...0.0...
..00.00.0..00.....00.0.00.00....00.000..0...0.00..00.00..0000......0.0....00.0..
.0....0.0.0......00.0.0...0....0..0..00.0.....0.....0...0...00...0000.000.0.....
.00.00...00.000.00..
.00.0...00.0.0...000
00......0.0.....00.0
```

### Night Reader

#### Example

### Supported Characters

```
',-.? abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
```

### Test Suite

Each sort type has a corresponding testing file written with [minitest](https://github.com/seattlerb/minitest) which can be run from the terminal using mrspec:

```
$ mrspec spec/...

new example here
```

You can also run all the tests at the same time by running the `mrspec` command from the terminal in the project's base directory.

#### Dependencies

Must have the [mrspec gem](https://github.com/JoshCheek/mrspec) and [minitest gem](https://github.com/seattlerb/minitest) installed.

Alternatively, you could run the tests without using mrspec if you modify the first line of each test to be `require 'minitest/autorun'`.
