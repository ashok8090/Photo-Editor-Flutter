# Photo Highlighter (Flutter)

A Flutter rewrite of the single-file HTML app **"Photo Merger & Highlighter"**,
with an iOS-style **liquid glass** UI and smooth animations throughout.
It runs on Android, iOS and the web.

## What it does

- **Add photos** from the Camera, the Gallery (several at once) or a **PDF**. For a PDF, you pick the pages to load, for example `1, 5, 9` or `1-5`.
- **Merge** the photos **horizontally**, **vertically** or in a **grid**. There are 77 grid layouts, plus *Auto Adjust*.
- **Quality presets:** Low, Medium, High, Super HD and Ultra. A live label shows the file size and pixel dimensions.
- **Border** on/off with a custom width, and a **file name** field.
- **Save & Album** saves the JPEG and stores it in the in-app album. Other exports:
  - **Merged PDF**: everything on one page.
  - **Separate Pages PDF**: one page per photo.
- **Per-photo actions:**
  - Reorder (← →, with a FLIP slide animation).
  - Remove (×, with an exit animation).
  - **Scan Photo**: a photocopy filter that cycles through 3 passes and restores the original on the 4th tap.
- **Scan editor:**
  - Automatic document **edge detection**.
  - **Perspective crop** with 8 handles and a magnifier.
  - Rotate 90°, No Crop, and Canvas Size (px / mm / cm, white fill).
- **Highlight editor:**
  - Shapes: rectangle, oval, freehand, straight line, text.
  - **Select & Transform**: resize, rotate, snapping guides, duplicate, delete.
  - Undo and redo; a layers panel; Multiply or Normal blend.
  - Colour palette and colour picker (grid and spectrum, hex and RGB).
  - **Transform Pad**: move, or resize one edge at a time.
  - **Photo Effects**: hue, saturation, brightness, contrast, colour scan, B&W scan.
  - Zoom & Pan.
  - **Text OCR** (Tesseract, English + Hindi; web only).
- **Album:**
  - Grid of saved images, a zoomable viewer, and Export All PDF.
  - **Edit** restores the full editable project, highlights included.
  - Share and Delete.
- **Themes:** dark and "Light Blue". The theme cross-fades when you switch, and it persists between sessions.

## Liquid glass UI

The glass widgets live in `lib/widgets/liquid_glass.dart` and `lib/widgets/glass.dart`.

(See full README in the project for more details.)
