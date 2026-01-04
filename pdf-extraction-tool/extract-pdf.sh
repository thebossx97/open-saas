#!/bin/bash

# PDF Text Extraction Script
# Requires: pdftotext (from poppler-utils)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_help() {
    cat << EOF
PDF Extraction Tool - Command Line Version

Usage: $0 [OPTIONS] <pdf-file>

OPTIONS:
    -h, --help          Show this help message
    -o, --output FILE   Output file (default: <input>_extracted.txt)
    -m, --metadata      Show PDF metadata
    -v, --verbose       Verbose output

EXAMPLES:
    $0 document.pdf
    $0 -o output.txt document.pdf
    $0 -m document.pdf

REQUIREMENTS:
    - pdftotext (install: apt-get install poppler-utils)
    - pdfinfo (install: apt-get install poppler-utils)

EOF
}

check_dependencies() {
    local missing=0
    
    if ! command -v pdftotext &> /dev/null; then
        echo "Error: pdftotext not found. Install with: apt-get install poppler-utils"
        missing=1
    fi
    
    if ! command -v pdfinfo &> /dev/null; then
        echo "Error: pdfinfo not found. Install with: apt-get install poppler-utils"
        missing=1
    fi
    
    if [ $missing -eq 1 ]; then
        exit 1
    fi
}

extract_text() {
    local input_file="$1"
    local output_file="$2"
    
    echo "Extracting text from: $input_file"
    pdftotext "$input_file" "$output_file"
    
    if [ -f "$output_file" ]; then
        local size=$(wc -c < "$output_file")
        local lines=$(wc -l < "$output_file")
        echo "✓ Extraction complete"
        echo "  Output: $output_file"
        echo "  Size: $size bytes"
        echo "  Lines: $lines"
    else
        echo "✗ Extraction failed"
        exit 1
    fi
}

show_metadata() {
    local input_file="$1"
    
    echo "PDF Metadata:"
    echo "============================================"
    pdfinfo "$input_file"
    echo "============================================"
}

main() {
    local input_file=""
    local output_file=""
    local show_meta=0
    local verbose=0
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            -m|--metadata)
                show_meta=1
                shift
                ;;
            -v|--verbose)
                verbose=1
                shift
                ;;
            *)
                if [ -z "$input_file" ]; then
                    input_file="$1"
                else
                    echo "Error: Unknown option or multiple input files: $1"
                    show_help
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    if [ -z "$input_file" ]; then
        echo "Error: No input file specified"
        show_help
        exit 1
    fi
    
    if [ ! -f "$input_file" ]; then
        echo "Error: File not found: $input_file"
        exit 1
    fi
    
    if [ $verbose -eq 1 ]; then
        check_dependencies
    else
        check_dependencies 2>/dev/null || exit 1
    fi
    
    if [ -z "$output_file" ]; then
        output_file="${input_file%.pdf}_extracted.txt"
    fi
    
    if [ $show_meta -eq 1 ]; then
        show_metadata "$input_file"
        echo ""
    fi
    
    extract_text "$input_file" "$output_file"
}

main "$@"
