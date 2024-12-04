# Sample Usage

```
# Build the image
./build.sh

# Add alias to your shell config
echo 'alias latexc="docker run --rm -v $(pwd):/latex latex-min"' >> ~/.bashrc
source ~/.bashrc

# Use it
cd your-project

# Basic usage (creates output/main.pdf)
latexc main.tex

# Custom output name (creates output/abc.pdf)
latexc main.tex --name abc.pdf

# Different output directory (creates pdfs/main.pdf)
OUTPUT_DIR=pdfs latexc main.tex

# Both custom name and directory (creates pdfs/abc.pdf)
OUTPUT_DIR=pdfs latexc main.tex --name abc.pdf
```