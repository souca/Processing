# Processing

## gifs
```java
int T = 120; // duración del loop

void draw() {
  float t = (frameCount % T) / (float)T;
  
  render(t); // tu animación
  
  saveFrame("frames/frame-####.png");
  
  if (frameCount >= T) {
    exit();
  }
}
```

- simple
`$> ffmpeg -i frames/frame-%04d.png -vf palettegen palette.png`
`$> ffmpeg -i frames/frame-%04d.png -i palette.png \
  -lavfi paletteuse -loop 0 output.gif`

- con fps y dithering
`$> ffmpeg -i frames/frame-%04d.png -vf "fps=30,scale=600:-1:flags=lanczos,palettegen" palette.png`
`$> ffmpeg -i frames/frame-%04d.png -i palette.png \
  -lavfi "fps=30,scale=600:-1:flags=lanczos,paletteuse=dither=bayer" \
  -loop 0 output.gif`

- en video
`$> ffmpeg -i frames/frame-%04d.png -c:v libx264 -pix_fmt yuv420p out.mp4`
`$> ffmpeg -i out.mp4 -vf "fps=30,scale=600:-1:flags=lanczos,palettegen" palette.png`
`$> ffmpeg -i out.mp4 -i palette.png -lavfi paletteuse output.gif`

