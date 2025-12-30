# HLS Transcoder

Transcodes audio/video files to HLS format with adaptive bitrate streaming using ffmpeg in a container.

## Usage

```bash
# Run from anywhere within the git repo
./transcode/launch-transcode.sh
```

Place source files in `transcode/staged/` before running.

## Track Naming Convention

Source files should use **kebab-case** naming (lowercase words separated by hyphens):

```
creeping-insolence.wav      -> "Creeping Insolence"
rude-introduction.wav       -> "Rude Introduction"
my-new-track.wav            -> "My New Track"
```

The folder name becomes the track identifier and is transformed to Title Case for display in the UI.

## Adding New Tracks

### Produced Tracks
1. Name source file in kebab-case: `my-track-name.wav`
2. Place in `transcode/staged/`
3. Run `./transcode/launch-transcode.sh`
4. Add folder name to `producedTracks` array in `site-root/js/camden-wander.js`

### DJ Mixes
1. Name source file in kebab-case: `my-mix-name.wav`
2. Place in `transcode/staged/`
3. Run `./transcode/launch-transcode.sh`
4. Move output from `site-root/hls/production/{name}/` to `site-root/hls/mixes/{name}/`
5. Add folder name to `djMixes` array in `site-root/js/camden-wander.js`

## Files

- `Dockerfile` - Alpine 3.19 container with ffmpeg
- `launch-transcode.sh` - Podman launch script (uses git root for paths)
- `generate-hls.sh` - Transcoding script that runs inside the container

## Output

HLS content is organized by category:

```
site-root/hls/
  production/           # Produced tracks
    {track}/
      master.m3u8
      64k/
        stream.m3u8
        seg_000.ts, ...
      128k/
        stream.m3u8
        seg_000.ts, ...
      192k/
        stream.m3u8
        seg_000.ts, ...
  mixes/                # DJ mixes
    {mix}/
      master.m3u8
      64k/ 128k/ 192k/
```

Track names are normalized to kebab-case (lowercase, hyphens).
