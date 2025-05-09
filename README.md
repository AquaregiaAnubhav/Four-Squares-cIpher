# Four-Square Cipher

A command-line R implementation of the [Four-Square cipher](https://en.wikipedia.org/wiki/Four-square_cipher) for encrypting and decrypting text files using two keyword-generated squares.

## Overview

The Four-Square cipher is a classical manual encryption technique that uses four 5×5 letter squares (omitting “q”) arranged in a grid. Two of the squares are keyed by user-provided keywords. This tool provides a simple CLI interface to apply the cipher to any text file.

## Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/<your-username>/four-square-cipher.git
   cd four-square-cipher
   ```
2. **Install R (≥ 3.6.0)**  
3. **Install dependencies**  
   ```r
   install.packages("optparse")
   ```

## Usage

Make the script executable (once):

```bash
chmod +x four_square_cryptography.R
```

Then run from your terminal:

```bash
# Encrypt
./four_square_cryptography.R \
  --key1 KEYWORD1 \
  --key2 KEYWORD2 \
  --process encrypt \
  --input  path/to/input.txt \
  --output path/to/output.txt

# Decrypt
./four_square_cryptography.R \
  --key1 KEYWORD1 \
  --key2 KEYWORD2 \
  --process decrypt \
  --input  path/to/encrypted.txt \
  --output path/to/decrypted.txt
```

Or with `Rscript`:

```bash
Rscript four_square_cryptography.R \
  --key1 WORD1 \
  --key2 WORD2 \
  --process encrypt \
  --input  input.txt \
  --output encrypted.txt
```

### Example

```bash
./four_square_cryptography.R \
  --key1 LIFE \
  --key2 LOVE \
  --process encrypt \
  --input  input.txt \
  --output output.txt
```

## How It Works

1. **Matrix setup**  
   - **Top-left** and **bottom-right**: standard 5×5 alphabet (omitting “q”).  
   - **Top-right** and **bottom-left**: keyword squares created from `--key1` and `--key2`.  
2. **Preprocessing**  
   - Convert to lowercase.  
   - Remove all non-alphanumeric characters.  
3. **Encryption/Decryption**  
   - Process input two characters at a time, mapping through the four squares.  
   - Any “q” in the input is left unchanged.  

For an in-depth explanation see the [Wikipedia page](https://en.wikipedia.org/wiki/Four-square_cipher) or this [YouTube tutorial](https://www.youtube.com/watch?v=HwiQ7-rL2w0).

## Limitations

- **Non-alphanumeric stripping**  
  Spaces, punctuation, and special characters are removed before processing. Decrypted output will not retain original spacing or punctuation.  
- **Handling “q”**  
  Since each 5×5 square can hold only 25 letters, “q” is excluded from the squares and preserved verbatim in the output.

## Roadmap

- **Preserve formatting**: Investigate using NLP or machine-learning techniques (e.g. LLMs) to reconstruct original spaces and punctuation after decryption.  
- **Full alphabet support**: Explore a 6×6 grid or alternative schemes to include all 26 letters without special-case treatment.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
