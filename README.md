# TIRSAM Offers Website (Arabic-first)

A responsive, single-page website for presenting the eight vehicle offers supplied by the site owner, explaining the initial enquiry process, and preparing an enquiry message for WhatsApp.

## Open locally
1. Extract the ZIP file.
2. Keep `index.html` and the `assets` folder together.
3. Open `index.html` in Chrome, Edge, Firefox, or Safari.
4. The vehicle photos and Google Fonts require an internet connection.

## Contact settings
The current website is configured with:
- WhatsApp: `+213 549 838 067` (WhatsApp link format: `213549838067`)
- Email: `Chinautodz16@gmail.com`

Edit the constants near the beginning of the `<script>` section in `index.html` to change these later.

## Offers shown
The eight prices, 10% down payments, and 60-month monthly examples are entered exactly from the offer supplied by the site owner. They are presented as indicative information and should be checked against current written terms, vehicle availability, taxes, options, and the authorized seller before publication or accepting payment.

## Enquiry form and documents — important
This is a static frontend. It opens WhatsApp with the applicant's details and the names of selected files. It does **not** upload or store files, and WhatsApp will **not** attach selected files automatically. The applicant must attach documents manually inside the opened WhatsApp conversation.

For secure online document uploads, connect a backend or a trusted form service with authentication, access controls, retention rules, and a privacy notice before collecting identity or financial documents. Do not treat the current file picker as a secure upload system.

## Images and logo
- The TIRSAM logo supplied inside the original ZIP was retained and lightly cleaned for transparent display.
- Vehicle images are loaded from the source URLs documented in `ASSET_SOURCES.md`. They are not bundled as local image files in this version, so the site needs an internet connection and the source hosts must continue allowing image access.
- Confirm image-use permissions and replace any image with company-approved photos before public commercial use.

## Publish
Upload the extracted folder contents (the `index.html` file and `assets` folder) to a static host such as Netlify, Cloudflare Pages, or GitHub Pages. This package does not include a backend, database, staff dashboard, or secure file storage.

## Brand / authorization notice
The page uses the TIRSAM name and logo from the supplied archive. Use it publicly only if you have permission to use the trademark and represent the offer. The footer makes clear that this enquiry page is not a substitute for TIRSAM's official website or official channels and does not by itself prove authorized-dealer status.

## Download vehicle photos into the website folder (Windows)
The build environment used to prepare this ZIP could inspect the official/reference image URLs but could not fetch those remote files into the archive. To make a local copy on your Windows PC:
1. Extract the ZIP.
2. Right-click `download-images.ps1` and choose **Run with PowerShell**, or open PowerShell in the extracted folder and run:
   `powershell -ExecutionPolicy Bypass -File .\download-images.ps1`
3. Successfully downloaded images will be saved to `assets/vehicles/`, and the site will automatically switch those images to local paths. If any source blocks a download, that image will remain referenced remotely.
