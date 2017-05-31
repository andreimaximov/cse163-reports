# PA3 - Path Tracing

## Libraries

- [GLM](https://github.com/g-truc/glm)
- [tinyobjloader](https://github.com/syoyo/tinyobjloader)
- [std\_image\_write](https://github.com/nothings/stb/blob/master/stb_image_write.h)
- [json](https://github.com/nlohmann/json)
- [spdlog](https://github.com/gabime/spdlog)
- [args](https://github.com/Taywee/args)

## Usage

```
./pathtracer {OPTIONS} [scene] [materials] [config] [output]

raytracer

OPTIONS:

  -h, --help                        display this help menu
  scene                             the scene file
  materials                         the materials directory
  config                            the config file
  output                            the output file
  "--" can be used to terminate flag options and force all following
  arguments to be treated as positional options
```

The config file is expected to be in JSON format with the same fields as `config.hpp` in the source code. This included information such as camera position, sampling depth, debugging, multi-threading, etc.

## Binaries

The macOS binary can be found in the [bin directory](bin).

## Introduction

I enjoyed learning about and implementing ray tracing in CSE 167 so for my final CSE 163 project I decided to extend it by writing a path tracer with support for Monte Carlo global illumination, fresnel refractions, glossy surfaces, and caustics.

To ease the burden of creating scenes, I used the [tinyobjloader](https://github.com/syoyo/tinyobjloader) loader to load OBJ geometry and MTL material files available [here](http://graphics.cs.williams.edu/data/meshes.xml).

The output file is updated once a second so you can observe the render clean up with time as more and more samples are factored in.

## Features

The following are several key features of my path tracer.

- **Importance sampling** - The [cosine weighted hemisphere](http://www.rorydriscoll.com/2009/01/07/better-sampling/) is used for sampling diffuse surface and a "concentrated" version with clustering towards the top is used for importance sampling rough/glossy reflections.

- **Russian Roulette Path Termination** - To avoid the bias of having a finite recursion depth I used Russian Roulette to randomize my path termination and scale non-terminated paths by the inverse probability of the ray not being terminated. The probability is adaptively scaled based on the intensity of the material the ray has intersected with. Since rays bouncing off dark materials will contribute less to the overall cover of the scene we can perform shallower sampling - the opposite holds for materials with high intensities.

- **Direct Light Sampling** - To greatly speedup convergence objects emissive objects are stored in an additional list of lights. When estimating the color of a diffuse surface we (1) uniformly sample a random light and divide by `PDF = 1 / (# of lights)` and (2) importance sample the BRDF. One thing to be careful of is to not double count lights by ignoring them in the indirect lighting sample. This results in much faster convergence for scenes with lots of diffuse surfaces.

- **Bounding Volume Hierarchy** - Some scenes such as Rungholt from the [Williams graphics dataset ](http://graphics.cs.williams.edu/data/meshes.xml) have an extremely high vertex count (several million). I used a BVH to optimize ray intersection tests to ~O(log N). This was largely borrowed from my CSE 167 assignment but I made several optimizations to it such as handling the case of bad splits that can result from large overlap along the midpoint of the dimension with highest variance which is used as the main splitting heuristic.

- **Multi-Threaded** - Path tracing is [embarrassingly parallel](https://en.wikipedia.org/wiki/Embarrassingly_parallel) so of course multi-threading is supported. Different parts of the image however may have different loads due to varying geometry density. For example querying the BVH for the nearest intersection of a sky pixel in the Rungholt scene is many times faster than a pixel in the middle of the castle. To address this dynamic scheduling via a work queue is used to assign threads partitions to work on.

## Renders

The following are several [Cornell Box](https://en.wikipedia.org/wiki/Cornell_box) renders using modified materials from the [Williams graphics dataset ](http://graphics.cs.williams.edu/data/meshes.xml)  to demonstrate several different material types.


| Glossy - 300 Samples |
|:--------------------:|
|![](images/cornell-glossy.png)|

## Resources

The following is a list of resources I used to learn about path tracing and Monte Carlo sampling.

- [https://www.scratchapixel.com/lessons/3d-basic-rendering/global-illumination-path-tracing/global-illumination-path-tracing-practical-implementation](ttps://www.scratchapixel.com/lessons/3d-basic-rendering/global-illumination-path-tracing/global-illumination-path-tracing-practical-implementation)
- [https://www.scratchapixel.com/lessons/3d-basic-rendering/introduction-to-shading/reflection-refraction-fresnel](https://www.scratchapixel.com/lessons/3d-basic-rendering/introduction-to-shading/reflection-refraction-fresnel)
- [https://cseweb.ucsd.edu/classes/sp17/cse168-a/CSE168\_07\_Random.pdf](https://cseweb.ucsd.edu/classes/sp17/cse168-a/CSE168_07_Random.pdf)
- [https://cseweb.ucsd.edu/classes/sp17/cse168-a/CSE168\_08\_PathTracing.pdf](https://cseweb.ucsd.edu/classes/sp17/cse168-a/CSE168_08_PathTracing.pdf)
- [https://cseweb.ucsd.edu/classes/sp17/cse168-a/CSE168\_13\_PathTracing2.pdf](https://cseweb.ucsd.edu/classes/sp17/cse168-a/CSE168_13_PathTracing2.pdf)
- [https://inst.eecs.berkeley.edu/~cs283/sp13/lectures/283-lecture10.pdf](https://inst.eecs.berkeley.edu/~cs283/sp13/lectures/283-lecture10.pdf)
- [http://www.joesfer.com/?p=84](http://www.joesfer.com/?p=84)
- [https://en.wikipedia.org/wiki/Fresnel\_equations](https://en.wikipedia.org/wiki/Fresnel_equations)