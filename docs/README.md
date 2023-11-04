# 3d-eval

This is a static site to help compare two approaches to viewing 3d object files, one using [OBJ] files with [virtex3D] and the other using [GLTF] files created from the OBJ files and viewed in Google's [model-viewer]. The purpose for doing this evaluation is to see if we can stop using virtex3d since it has been updated in 5 years, and is no longer supported.

## Set Up

A report for all public 3D objects was run in Argo in October, 2023 and the resulting CSV was saved as `_data/items.csv`.  To fetch all the files for these objects using the published metadata you can run:

```
$ rake fetch
```

In order to convert the files from OBJ to GLB (binary GLTF) you can run:

```
$ rake convert
```

Finally if you want to look at the files locally you can:

```
$ jekyll serve
```

and open your browser at http://localhost:4000/3d-eval/


[OBJ]: https://en.wikipedia.org/wiki/Wavefront_.obj_file
[GLTF]: https://en.wikipedia.org/wiki/GlTF
[virtex3d]: https://github.com/edsilv/virtex
[model-viewer]: https://modelviewer.dev/
