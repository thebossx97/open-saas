# PDF Extraction Tool

Extract text and metadata from PDF files using either a web interface or command line.

## Features

- 📄 Extract text content from PDF files
- 📊 View document metadata (pages, file size, author, etc.)
- 💾 Download extracted text as TXT file
- 📋 Copy extracted text to clipboard
- 🎨 Modern, responsive UI (web version)
- 🚀 Fast and efficient processing
- 🔒 Secure - files processed in memory, not stored
- 🖥️ Command-line interface available

## Two Versions Available

### 1. Web-Based Tool (Node.js)

**Installation:**

```bash
npm install
```

**Usage:**

```bash
npm start
```

The tool will be available at `http://localhost:3030`

### 2. Command-Line Tool (Bash)

**Installation:**

```bash
# Install required dependencies
sudo apt-get update
sudo apt-get install poppler-utils
```

**Usage:**

```bash
# Basic extraction
./extract-pdf.sh document.pdf

# Specify output file
./extract-pdf.sh -o output.txt document.pdf

# Show metadata
./extract-pdf.sh -m document.pdf

# Show help
./extract-pdf.sh --help
```

## API Endpoints

### POST /api/extract

Extract text and metadata from a PDF file.

**Request:**
- Method: POST
- Content-Type: multipart/form-data
- Body: PDF file with field name 'pdf'

**Response:**
```json
{
  "text": "Extracted text content...",
  "metadata": {
    "pages": 10,
    "fileSize": 1024000,
    "fileName": "document.pdf",
    "version": "1.4",
    "info": {
      "Title": "Document Title",
      "Author": "Author Name",
      "Creator": "Creator App",
      "Producer": "PDF Producer"
    }
  }
}
```

### GET /api/health

Check if the service is running.

**Response:**
```json
{
  "status": "ok",
  "message": "PDF Extraction Tool is running"
}
```

## Limitations

- Maximum file size: 10MB
- Only PDF files are supported
- Text extraction quality depends on PDF structure (scanned PDFs without OCR won't extract text)

## Quick Start

### Option 1: Web Interface (Recommended for GUI)

1. Install Node.js (v14 or higher)
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the server:
   ```bash
   npm start
   ```
4. Open your browser to `http://localhost:3030`
5. Upload a PDF and extract text

### Option 2: Command Line

1. Install dependencies:
   ```bash
   sudo apt-get install poppler-utils
   ```
2. Make the script executable:
   ```bash
   chmod +x extract-pdf.sh
   ```
3. Run extraction:
   ```bash
   ./extract-pdf.sh your-document.pdf
   ```

## Testing

Create a sample PDF for testing:

```bash
chmod +x create-sample-pdf.sh
./create-sample-pdf.sh
./extract-pdf.sh sample-document.pdf
```

## Technology Stack

**Web Version:**
- Node.js + Express
- pdf-parse for PDF processing
- Multer for file uploads
- Vanilla JavaScript frontend

**CLI Version:**
- Bash shell script
- poppler-utils (pdftotext, pdfinfo)

## Troubleshooting

**Web version won't start:**
- Ensure Node.js is installed: `node --version`
- Check if port 3030 is available
- Install dependencies: `npm install`

**CLI version errors:**
- Install poppler-utils: `sudo apt-get install poppler-utils`
- Make script executable: `chmod +x extract-pdf.sh`
- Check PDF file exists and is readable

**No text extracted:**
- Scanned PDFs require OCR (not included)
- Some PDFs have text as images
- Try opening the PDF in a viewer to verify it contains selectable text

## License

MIT
