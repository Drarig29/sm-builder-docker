# sm-builder

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/drarig29/sm-builder)
![Docker Image workflow](https://github.com/Drarig29/sm-builder-docker/actions/workflows/main.yml/badge.svg)

This repository generates a Docker image providing [sm-builder](https://github.com/splewis/sm-builder), which is a build/package tool to compile SourceMod plugins.

Thanks to this image, you don't have anymore to:

- Have the Dockerfile in your project.
- Have a `smbuild` file in your project.
- Have a `.gitmodules` file in your project.
- Build the image yourself.

Just go in your SourceMod plugin's root folder, and run the following:

```bash
docker run --rm -v $(pwd):/src -v $(pwd)/out:/out drarig29/sm-builder:latest
```

You will find the artefacts in the `./out` folder.

A common plugin structure is:

```
scripting/

  include/
      * get5.inc

  * your_plugin.sp

* LICENSE
* README.md
```

## Requirements

- Docker 😎

- If you don't have a `smbuild` file:

  - You need to have a single `.sp` file in the `scripting/` folder.
  - You need to have a `LICENSE` and a `README.md`.

## Thanks 💗

- To [@splewis](https://github.com/splewis) for his amazing build tool.
- To [@Apfelwurm](https://github.com/Apfelwurm) for his work on [#572](https://github.com/splewis/get5/pull/572) and [#587](https://github.com/splewis/get5/pull/587) to create the original version of the Dockerfile for [get5](https://github.com/splewis/get5).
