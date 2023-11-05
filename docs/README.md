# 3d-eval

This is a static site to help compare two approaches to viewing 3d object files, one using [OBJ] files with [virtex3D] and the other using [GLTF] files created from the OBJ files and viewed in Google's [model-viewer]. The purpose for doing this evaluation is to see if we can stop using virtex3d since it hasn't been updated in 5 years, and is no longer supported.

The static site is served from GitHub Pages at: https://sul-dlss-labs.github.io/3d-eval/

## Set Up

A report for all public 3D objects was run in Argo in October, 2023 and the resulting CSV was saved as `_data/items.csv`.  To fetch all the files for these objects from Stacks using their published Cocina metadata you can run:

```shell
$ rake fetch
```

In order to convert the fetched OBJ files to GLB (binary GLTF) you can run:

```shell
$ rake convert
```

Finally if you want to look at the files locally you can:

```shell
$ jekyll serve
```

and open your browser at http://localhost:4000/3d-eval/

## Publish

The site is published using GitHub pages. There are a lot of files, so it can take a bit of time to clone and push the respository, and for changes to take effect on the live site.

```shell
$ jekyll build
$ git commit -a -m "latest content"
$ git push
```

Then view the published site at http://sul-dlss-labs.github.io/3d-eval/

## Develop

The model-viewer JavaScript library is loaded from a CDN, but if you are going to change how the virtex3d viewer works in `js/virtex-viewer.js` you will need to install yarn, and then:

```shell
$ yarn install
$ rake build
```

Otherwise changes to the jekyll site are easy to change while running:

```shell
$ jekyll serve --watch
```

[OBJ]: https://en.wikipedia.org/wiki/Wavefront_.obj_file
[GLTF]: https://en.wikipedia.org/wiki/GlTF
[virtex3d]: https://github.com/edsilv/virtex
[model-viewer]: https://modelviewer.dev/
