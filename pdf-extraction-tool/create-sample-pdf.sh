#!/bin/bash

# Create a sample PDF for testing
# This script creates a simple text file and converts it to PDF

SAMPLE_TEXT="sample-document.txt"
SAMPLE_PDF="sample-document.pdf"

cat > "$SAMPLE_TEXT" << 'EOF'
PDF EXTRACTION TOOL - SAMPLE DOCUMENT
======================================

This is a sample PDF document created for testing the PDF extraction tool.

Key Features Demonstrated:
--------------------------
1. Text extraction from PDF files
2. Metadata retrieval
3. Multi-page support
4. Special characters: © ® ™ € £ ¥

Lorem Ipsum
-----------
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod 
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, 
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo 
consequat.

Technical Information
---------------------
- Document Type: Sample PDF
- Purpose: Testing PDF extraction
- Format: Portable Document Format
- Encoding: UTF-8

Code Example:
-------------
function extractPDF(file) {
    const data = await pdfParse(file);
    return {
        text: data.text,
        pages: data.numpages
    };
}

Mathematical Expressions:
-------------------------
E = mc²
a² + b² = c²
∑(i=1 to n) i = n(n+1)/2

Contact Information
-------------------
Email: test@example.com
Website: https://example.com
Phone: +1-555-0123

End of Sample Document
----------------------
This document was generated automatically for testing purposes.
EOF

echo "Sample text file created: $SAMPLE_TEXT"

# Check if tools are available
if command -v enscript &> /dev/null && command -v ps2pdf &> /dev/null; then
    echo "Converting to PDF using enscript + ps2pdf..."
    enscript -B -p - "$SAMPLE_TEXT" 2>/dev/null | ps2pdf - "$SAMPLE_PDF"
    echo "✓ Sample PDF created: $SAMPLE_PDF"
elif command -v pandoc &> /dev/null; then
    echo "Converting to PDF using pandoc..."
    pandoc "$SAMPLE_TEXT" -o "$SAMPLE_PDF"
    echo "✓ Sample PDF created: $SAMPLE_PDF"
else
    echo "⚠ PDF conversion tools not available (enscript+ps2pdf or pandoc)"
    echo "  Sample text file created: $SAMPLE_TEXT"
    echo ""
    echo "To create a PDF, install one of:"
    echo "  - enscript + ghostscript: apt-get install enscript ghostscript"
    echo "  - pandoc: apt-get install pandoc texlive-latex-base"
fi

echo ""
echo "You can now test the extraction tool with:"
echo "  ./extract-pdf.sh $SAMPLE_PDF"
