# PA1 - Image and Signal Processing

## Overview

The CLI is very similar to the reference binary with several minor differences
outlined in the CLI usage of each section. You can also click on thumbnails to
view the full resolution image.

**Usage:** `./image -<filter> args... < in.bmp > out.bmp`

BMP's are read from `stdin` and piped to `stdout`. **stb\_image** and
**stb\_image\_write** do not support read/writing to an arbitary `iostream` so
the `stdin` input is first written to a temporary binary file on disk, loaded,
the filter applied, written back to disk, and then piped to `stdout` in binary.

Pixel channels are represented as floating point in the [0, 1] range for
convenience and converted from/to 24-bit RGBA during the read/write phase.

## Libraries

- [stb\_image](https://github.com/nothings/stb)
- [stb\_image\_write](https://github.com/nothings/stb)
- [GLM](https://github.com/g-truc/glm)

**stb\_image** and **stb\_image\_write** were used only for loading and saving
images while **GLM** was used for the refraction calculation in my custom
filter.

## Binaries

Binaries for macOS and Linux can be found in the [bin directory](bin).

## 3.2 Basic Operations

### Brightness

**CLI:** `./image -brightness factor`

| Original | 0.0 | 0.5 | 1.0 | 1.5 | 2.0 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/brightness_0.0.bmp)|![](${s3}/brightness_0.5.bmp)|![](${s3}/brightness_1.0.bmp)|![](${s3}/brightness_1.5.bmp)|![](${s3}/brightness_2.0.bmp)|

### Contrast

**CLI:** `./image -contrast factor`

| Original | -0.5 | 0.0 | 0.5 | 1.0 | 1.7 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/contrast_-0.5.bmp)|![](${s3}/contrast_0.0.bmp)|![](${s3}/contrast_0.5.bmp)|![](${s3}/contrast_1.0.bmp)|![](${s3}/contrast_1.7.bmp)|

### Saturation

**CLI:** `./image -saturation factor`

| Original | -1.0 | 0.0 | 0.5 | 1.0 | 2.5 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/saturation_-1.0.bmp)|![](${s3}/saturation_0.0.bmp)|![](${s3}/saturation_0.5.bmp)|![](${s3}/saturation_1.0.bmp)|![](${s3}/saturation_2.5.bmp)|

### Gamma

**CLI:** `./image -gamma factor`

| Original | 0.0 | 0.5 | 1.0 | 1.5 | 2.0 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/gamma_0.0.bmp)|![](${s3}/gamma_0.5.bmp)|![](${s3}/gamma_1.0.bmp)|![](${s3}/gamma_1.5.bmp)|![](${s3}/gamma_2.0.bmp)|

### Crop

**CLI:** `./image -crop x y width height`

| Original | (100, 100, 200, 200) |
|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/crop.bmp)|

## 3.3 Quantization and Dithering

### Quantize

**CLI:** `./image -quantize bits`

| Original | 1 | 2 | 4 | 6 | 8 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/quantize_1.bmp)|![](${s3}/quantize_2.bmp)|![](${s3}/quantize_4.bmp)|![](${s3}/quantize_6.bmp)|![](${s3}/quantize_8.bmp)|

The standard quantization method described in the assignment was used for this
filter.

### Random Dither

**CLI:** `./image -random-dither bits` (Slightly different from reference
binary)

| Original | 1 | 2 | 4 | 6 | 8 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/random_dither_1.bmp)|![](${s3}/random_dither_2.bmp)|![](${s3}/random_dither_4.bmp)|![](${s3}/random_dither_6.bmp)|![](${s3}/random_dither_8.bmp)|

### Floyd Steinberg Dither

**CLI:** `./image -floyd-steinberg-dither bits` (Slightly different from
reference binary)

| Original | 1 | 2 | 4 | 6 | 8 |
|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/fsd_1.bmp)|![](${s3}/fsd_2.bmp)|![](${s3}/fsd_4.bmp)|![](${s3}/fsd_6.bmp)|![](${s3}/fsd_8.bmp)|

The error propagation constants (alpha, beta, gamma, delta) are normalized to
ensure that the multiplicative weight factor of the error propagating from each
pixel adds up to 1.0 at the edges and corners. This ensures edge brightness is
similar to that of the source image.

## 3.4 Basic Convolution and Edge Detection

### Blur

**CLI:** `./image -blur n`

| Original | 3 | 5 | 7 | 11 | 13 | 17 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/blur_3.bmp)|![](${s3}/blur_5.bmp)|![](${s3}/blur_7.bmp)|![](${s3}/blur_11.bmp)|![](${s3}/blur_13.bmp)|![](${s3}/blur_19.bmp)|

**Note:** Both the Gaussian blur filter was normalized to add up to 1.0 for
in-bounds pixels to ensure consistent brightness at the edges.

### Sharpen

**CLI:** `./image -sharpen`

| Original | 3 x 3 |
|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/sharpen.bmp)|

**Note:** Both the sharpen filter was normalized to add up to 1.0 for in-bounds
pixels to ensure consistent brightness at the edges.

### Edge Detect

**CLI:** `./image -edge-detect threshold`

| Original | 10 | 50 | 100 | 200 |
|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/edge_detect_flower_10.bmp)|![](${s3}/edge_detect_flower_50.bmp)|![](${s3}/edge_detect_flower_100.bmp)|![](${s3}/edge_detect_flower_200.bmp)|
|![](${s3}/checkerboard.bmp)|![](${s3}/edge_detect_checker_10.bmp)|![](${s3}/edge_detect_checker_50.bmp)|![](${s3}/edge_detect_checker_100.bmp)|![](${s3}/edge_detect_checker_200.bmp)|
|![](${s3}/wave.bmp)|![](${s3}/edge_detect_wave_10.bmp)|![](${s3}/edge_detect_wave_50.bmp)|![](${s3}/edge_detect_wave_100.bmp)|![](${s3}/edge_detect_wave_200.bmp)|

**Note:** Standard Sobel edge detector filters were convolved over the image
but **not** normalized because the weighted sum of each filter is 0.

## 3.5 Antialiased Scale and Shift

### Scale

**CLI:** `./image -size width height sampling`

| Sampling | Original | 128 x 128 | 200 x 400 | 900 x 600 | 768 x 768 |
|:---:|:---:|:---:|:---:|:---:|:---:|
| Nearest Neighbor (sampling = 1) |![](${s3}/checkerboard.bmp)|![](${s3}/scale-128-128-nn.bmp)|![](${s3}/scale-200-400-nn.bmp)|![](${s3}/scale-900-600-nn.bmp)|![](${s3}/scale-768-768-nn.bmp)|
| Hat (sampling = 2) |![](${s3}/checkerboard.bmp)|![](${s3}/scale-128-128-hat.bmp)|![](${s3}/scale-200-400-hat.bmp)|![](${s3}/scale-900-600-hat.bmp)|![](${s3}/scale-768-768-hat.bmp)|
| Mitchell (sampling = 3) |![](${s3}/checkerboard.bmp)|![](${s3}/scale-128-128-mitchell.bmp)|![](${s3}/scale-200-400-mitchell.bmp)|![](${s3}/scale-900-600-mitchell.bmp)|![](${s3}/scale-768-768-mitchell.bmp)|

### Shift

**CLI:** `./image -shift sx sy sampling`

| Sampling | Original | (-40, -40) | (-20.3, -20.7) | (40, 40) | (20.3, 20.7) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| Nearest Neighbor (sampling = 1) |![](${s3}/checkerboard.bmp)|![](${s3}/shift--40--40-nn.bmp)|![](${s3}/shift--20.3--20.7-nn.bmp)|![](${s3}/shift-40-40-nn.bmp)|![](${s3}/shift-20.3-20.7-nn.bmp)|
| Hat (sampling = 2) |![](${s3}/checkerboard.bmp)|![](${s3}/shift--40--40-hat.bmp)|![](${s3}/shift--20.3--20.7-hat.bmp)|![](${s3}/shift-40-40-hat.bmp)|![](${s3}/shift-20.3-20.7-hat.bmp)|
| Mitchell (sampling = 3) |![](${s3}/checkerboard.bmp)|![](${s3}/shift--40--40-mitchell.bmp)|![](${s3}/shift--20.3--20.7-mitchell.bmp)|![](${s3}/shift-40-40-mitchell.bmp)|![](${s3}/shift-20.3-20.7-mitchell.bmp)|

## 3.6 Fun

**CLI:** `./image -ripple depth frequency`

| Original | (25, 8) | (50, 16) | (75, 32) | (100, 64) |
|:---:|:---:|:---:|:---:|:---:|
|![](${s3}/flower.bmp)|![](${s3}/ripple-25-8.bmp)|![](${s3}/ripple-50-16.bmp)|![](${s3}/ripple-75-32.bmp)|![](${s3}/ripple-100-64.bmp)|

I implemented a water ripple effect for my custom filter. The idea behind the
filter is to simulate a cosine wave propagating from the center of the image.

Camera rays are projected perpendicularly into the image and refracted using
the normal of the cosine wave at that pixel. The refracted ray then travels
through the water to the underyling image. The distance the refracted ray
travels depends on the depth of the wave and the point of the wave that it hit.
Because of this, larger depth leads to more distortion in the x and y
directions. Once the refracted ray reaches the underlying image it simply
samples the nearest pixel.

Adjusting the frequency changes the density of the ripples in the image. Higher
frequencies result in more closely packed ripples.

