FROM alpine:latest

# Install minimal TeX Live and required packages
RUN apk add --no-cache \
    texlive \
    texlive-full \
    perl \
    make \
    python3

WORKDIR /latex

# Create compilation script
RUN echo '#!/bin/sh' > /usr/local/bin/compile.sh && \
    echo 'OUTPUT_DIR=${OUTPUT_DIR:-output}' >> /usr/local/bin/compile.sh && \
    echo '' >> /usr/local/bin/compile.sh && \
    echo '# Parse arguments' >> /usr/local/bin/compile.sh && \
    echo 'INPUT_FILE=""' >> /usr/local/bin/compile.sh && \
    echo 'OUTPUT_NAME=""' >> /usr/local/bin/compile.sh && \
    echo '' >> /usr/local/bin/compile.sh && \
    echo 'while [ $# -gt 0 ]; do' >> /usr/local/bin/compile.sh && \
    echo '    case "$1" in' >> /usr/local/bin/compile.sh && \
    echo '        --name)' >> /usr/local/bin/compile.sh && \
    echo '            OUTPUT_NAME="$2"' >> /usr/local/bin/compile.sh && \
    echo '            shift 2' >> /usr/local/bin/compile.sh && \
    echo '            ;;' >> /usr/local/bin/compile.sh && \
    echo '        *)' >> /usr/local/bin/compile.sh && \
    echo '            INPUT_FILE="$1"' >> /usr/local/bin/compile.sh && \
    echo '            shift' >> /usr/local/bin/compile.sh && \
    echo '            ;;' >> /usr/local/bin/compile.sh && \
    echo '    esac' >> /usr/local/bin/compile.sh && \
    echo 'done' >> /usr/local/bin/compile.sh && \
    echo '' >> /usr/local/bin/compile.sh && \
    echo '# Create output directory' >> /usr/local/bin/compile.sh && \
    echo 'mkdir -p "$OUTPUT_DIR"' >> /usr/local/bin/compile.sh && \
    echo '' >> /usr/local/bin/compile.sh && \
    echo '# Set default output name if not specified' >> /usr/local/bin/compile.sh && \
    echo 'if [ -z "$OUTPUT_NAME" ]; then' >> /usr/local/bin/compile.sh && \
    echo '    OUTPUT_NAME="${INPUT_FILE%.tex}.pdf"' >> /usr/local/bin/compile.sh && \
    echo 'fi' >> /usr/local/bin/compile.sh && \
    echo '' >> /usr/local/bin/compile.sh && \
    echo '# Compile and move to output directory' >> /usr/local/bin/compile.sh && \
    echo 'pdflatex -interaction=nonstopmode "$INPUT_FILE" && \' >> /usr/local/bin/compile.sh && \
    echo 'mv "${INPUT_FILE%.tex}.pdf" "$OUTPUT_DIR/$OUTPUT_NAME"' >> /usr/local/bin/compile.sh && \
    chmod +x /usr/local/bin/compile.sh

ENTRYPOINT ["/usr/local/bin/compile.sh"]