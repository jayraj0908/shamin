#!/bin/bash
# Downloads the Higgsfield-generated media into ./assets and points index.html at the local copies.
# Run from the shamin-site folder:  bash localize-assets.sh
set -e
cd "$(dirname "$0")"
mkdir -p assets
B="https://d8j0ntlcm91z4.cloudfront.net/user_3Hof7aTn3QCoQsRGnVYki5QQMyG"

declare -a names=(hero.mp4 ballroom.mp4 hotel1.png hotel2.png hotel3.png hotel4.png hotel5.png hotel6.png suite.png bus.png inn.png rooftop.png lobby.png elevator.png)
declare -a files=(
  hf_20260812_142659_427f2ff7-bc01-4210-90d4-6abc29b4d9de.mp4
  hf_20260812_142612_33872e80-d08e-493d-b588-6f6ea9c79401.mp4
  hf_20260812_142729_d512d84d-a500-4d45-8ed1-4e089138e415.png
  hf_20260812_142729_5ff758b9-0cd8-4799-9ee4-916a20dadcdb.png
  hf_20260812_142729_ae200731-552e-4762-a75e-5e81a85fa9d0.png
  hf_20260812_142729_4aff9f60-69ee-4798-ac13-d03b0203696a.png
  hf_20260812_142729_34c796bf-89c9-4b32-9311-021a41360cf6.png
  hf_20260812_142729_024e2c40-0c49-490e-8a1e-259a060c34cf.png
  hf_20260812_142729_9ce3a977-506c-417c-a536-32336d5b9985.png
  hf_20260812_142729_94b7723c-b0c8-460b-90fa-7f147f6310f6.png
  hf_20260812_142731_6d1ddd7e-f330-4ce0-bda3-9620b7690262.png
  hf_20260812_143125_5c36af34-74d9-4316-a63f-58db180f5184.png
  hf_20260812_145123_8e793dff-77c8-4d8d-9522-864741334ca6.png
  hf_20260812_145123_e67bc895-2d2f-49b3-b2d3-8a0c05432f89.png
)

for i in "${!names[@]}"; do
  echo "Downloading ${names[$i]} ..."
  curl -sf -o "assets/${names[$i]}" "$B/${files[$i]}"
done

# If ffmpeg is available, re-encode videos with dense keyframes for buttery scroll-scrubbing
if command -v ffmpeg >/dev/null 2>&1; then
  echo "Re-encoding videos for smooth scrubbing (all-keyframe) ..."
  ffmpeg -y -loglevel error -i assets/hero.mp4 -vf scale=1920:-2 -g 1 -crf 23 -movflags +faststart -an assets/hero_scrub.mp4 && mv assets/hero_scrub.mp4 assets/hero.mp4
  ffmpeg -y -loglevel error -i assets/ballroom.mp4 -vf scale=1920:-2 -g 1 -crf 23 -movflags +faststart -an assets/ballroom_scrub.mp4 && mv assets/ballroom_scrub.mp4 assets/ballroom.mp4
fi

# Point index.html at the local files
cp index.html index.remote-backup.html
for i in "${!names[@]}"; do
  sed -i '' "s|$B/${files[$i]}|assets/${names[$i]}|g" index.html
done

echo "Done. index.html now uses local assets (remote version saved as index.remote-backup.html)."
