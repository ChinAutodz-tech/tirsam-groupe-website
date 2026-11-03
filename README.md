# TIRSAM GROUPE website prototype

Responsive multilingual website prototype in French, Arabic (RTL), and English.

## Run locally
- Keep `index.html` and the `assets/` folder together.
- Open `index.html` in a modern browser, or serve the folder using a local web server.

## Before publishing
1. In `index.html`, set `WA_NUMBER` to the company's WhatsApp number in international format without `+` (for Algeria, begin with `213`).
2. Confirm product names, vehicle specifications, images, contact details, and legal copy with TIRSAM GROUPE. Product content in this prototype is illustrative and should not be treated as confirmed inventory or specifications.
3. Connect the enquiry form to a secure backend or CRM. Current submissions are stored only in the visitor's browser using `localStorage` and are not sent to the company automatically.
4. Replace the prototype admin panel with real server-side authentication and database access before production. The current panel is not secured and only reads local browser submissions.
5. Replace sample Unsplash images with approved company/product photos if required.

## Files
- `index.html` — full responsive site and frontend interactions
- `assets/tirsam-logo.png` — refreshed logo asset
