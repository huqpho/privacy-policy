# Privacy Policy Hub

This repository hosts privacy policy pages for multiple browser extensions using GitHub Pages.

## Structure

- `index.html` - Root navigation page (policy index)
- `prompt-keeper/index.html` - Prompt Keeper privacy policy page

## Add a new plugin policy

1. Create a new folder, for example: `my-plugin/`
2. Add `my-plugin/index.html`
3. Add a link entry in the root `index.html`

## GitHub Pages setup

1. Push this repository to GitHub.
2. Open repository **Settings -> Pages**.
3. Set source to **Deploy from a branch**.
4. Select branch **main** and folder **/(root)**.

Then your URLs will be:

- Root index: `https://<yourname>.github.io/privacy-policy/`
- Prompt Keeper policy: `https://<yourname>.github.io/privacy-policy/prompt-keeper/`
