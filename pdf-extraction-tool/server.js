import express from 'express';
import multer from 'multer';
import cors from 'cors';
import pdfParse from 'pdf-parse';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3030;

app.use(cors());
app.use(express.json());
app.use(express.static('public'));

const storage = multer.memoryStorage();
const upload = multer({
  storage: storage,
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB limit
  fileFilter: (req, file, cb) => {
    if (file.mimetype === 'application/pdf') {
      cb(null, true);
    } else {
      cb(new Error('Only PDF files are allowed'));
    }
  }
});

app.post('/api/extract', upload.single('pdf'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No PDF file uploaded' });
    }

    const data = await pdfParse(req.file.buffer);

    const result = {
      text: data.text,
      metadata: {
        pages: data.numpages,
        info: data.info,
        version: data.version,
        fileSize: req.file.size,
        fileName: req.file.originalname
      }
    };

    res.json(result);
  } catch (error) {
    console.error('Error extracting PDF:', error);
    res.status(500).json({ error: 'Failed to extract PDF content', details: error.message });
  }
});

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'PDF Extraction Tool is running' });
});

app.listen(PORT, () => {
  console.log(`PDF Extraction Tool running on port ${PORT}`);
  console.log(`Visit http://localhost:${PORT} to use the tool`);
});
