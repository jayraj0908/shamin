# Deploying to Railway

1. Push this `shamin-site` folder to a GitHub repo (or use `railway up` from the folder with the Railway CLI).
2. In Railway: New Project -> Deploy from GitHub repo (or CLI).
3. Railway auto-detects Node via `package.json` and runs `npm start`, which serves the static site on the assigned PORT.
4. Generate a domain under Settings -> Networking -> Generate Domain.

Notes
- Everything the site needs is in this folder (index.html + assets/). The two scrub videos total ~20MB; first load shows the loader while they buffer.
- Portfolio and news images are hotlinked from shaminhotels.com (their own official photos), and two renderings from richmondbizsense.com. For a client-facing demo this is fine; for production, download them into assets/ and update the paths.
- scene.html (3D experiment) and index-v1-chapters.html (earlier chaptered version) are optional extras; delete them if you want the deploy minimal.
