Púxoseme esto na cabeza paseando con Raque e os nenos por Santa, camiño ao parque de tiago, un domingo de mediados de marzo, xa na primaveira. Non era así exactamente, pero quería deixar constancia de:
i) mapear variable cun campo Perlin (neste caso, a cor)
ii) facer un gif.

O método que empregabas antes, a librería importada GifMaker ou algo así, quedou deprecada. O meta agora é exportar n frames en png e por fóra empregar ffmpeg para facer o gif. 

<p align="center">
<img src="https://github.com/souca/Processing/raw/main/G001_brillan_diamantes/G001_brillan_diamantes.gif"   width="400" />
</p>

```java
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
