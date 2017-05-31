# PA3 - Path Tracing

## Libraries

- [GLM](https://github.com/g-truc/glm)
- [tinyobjloader](https://github.com/syoyo/tinyobjloader)
- [std_image_write](https://github.com/nothings/stb/blob/master/stb_image_write.h)
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

## Binaries

The macOS binary can be found in the [bin directory](bin).
