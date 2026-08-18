# Audio and video conversion.
#
# Requires yt-dlp and ffmpeg. Both are provisioned by the repo: ffmpeg from the
# Brewfile, yt-dlp from mise.toml.

#   ytwa: download a YouTube video's audio and convert it to a WhatsApp
#   voice-message-compatible OGG/OPUS file.
#   Usage: ytwa <youtube-url> [output-directory]   (defaults to ~/Downloads)
ytwa() {
  local url="$1"
  local outdir="${2:-$HOME/Downloads}"
  local tmpdir tmpbase infile base safe out

  if [[ -z "$url" ]]; then
    echo "❌🚨 Usage: ytwa <youtube-url> [output-directory]" >&2
    return 1
  fi

  mkdir -p "$outdir"
  tmpdir=$(mktemp -d)
  tmpbase="$tmpdir/audio"

  echo "🎵⬇️ Grabbing audio from the tubes..."
  yt-dlp --no-playlist -f bestaudio -o "$tmpbase.%(ext)s" "$url" || {
    echo "❌💥 Download failed! The tubes are clogged." >&2
    rm -rf "$tmpdir"
    return 1
  }

  infile=$(ls "$tmpbase".* 2>/dev/null | head -1)
  if [[ -z "$infile" ]]; then
    echo "❌🤷‍♂️ No downloaded file found. Ghost audio?" >&2
    rm -rf "$tmpdir"
    return 1
  fi

  base=$(yt-dlp --no-playlist --print filename -o "%(title)s" "$url" 2>/dev/null)
  safe=$(echo "$base" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g; s/_\+/_/g; s/^_//; s/_$//')
  out="$outdir/${safe}.ogg"

  echo "🔄🎙️ Cooking it into a WhatsApp voice note..."
  ffmpeg -hide_banner -loglevel error -i "$infile" \
    -vn -c:a libopus -b:a 32k -ar 48000 -ac 1 \
    -af "loudnorm=I=-16:TP=-1.5:LRA=11" \
    -y "$out"

  rm -rf "$tmpdir"

  if [[ -f "$out" ]]; then
    echo "✅🎉 Boom! Your voice note is ready:"
    ls -lh "$out"
    echo "📤🎵 Drag and drop that bad boy into WhatsApp!"
  else
    echo "❌🔥 Conversion failed! The audio gods are angry." >&2
    return 1
  fi
}
