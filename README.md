nimage: pure-Nim image encoding and decoding
===

`nimage` is an attempt to provide a nice, Nim-ish API over the process of
encoding and decoding images. Right now, as far as I can tell, the only real
image decoding and encoding available for Nim are wrappers around C libraries
that are notorious for being difficult to use (looking at you, libpng). To that
end, this seeks to provide a nice API that takes advantage of Nim's sugary
goodness for image loading and saving.

Using nimage
---

`nimage` has an intentionally very simple API for encoding images. Image are
represented by `Image` objects in memory, and an `Image` object has a height, a
width, and data. The data is a sequence of `NColor` values, which are each a
32-bit encoding of an RGBA color; that's 8 bytes per sample, high byte is red
and low byte is alpha.

To load images, create a stream to read from and pass that stream to
`nimage.load_png`. To save images, call `img.save_png` with a stream to save it
to. Future releases will add support for providing options to `save_png`;
currently (as described below) the encoder is not configurable.

Images support indexing by row-column, to avoid users having to index into the
row-major data array. You can take a look at [the tests][3] to see how the
API looks in practice.

Unfortunately, `nim doc` doesn't like generating documentation for exported
symbols in a module yet; because of how `nimage` is structured, this means that
there's no autogenerated documentation for the project yet. Sorry!


Current status
---

### Decoding

`nimage` can currently read PNG images from streams. It only implements the
handling of critical chunks, which means that all ancillary chunks (containing
colorspace data, metadata, etc.) are lost in loading. Only PNG images with 8-bit
color depth are supported; in practice, this is most PNG images, but there are a
non-negligable number of PNG images that `nimage` just can't import right now.

### Encoding

`nimage` can currently write 8-bit RGBA PNG images. It doesn't support
interlacing, predictive filtering or paletting. The images that `nimage` writes
are going to be much larger than they need to be; if you're using `nimage` in an
environment in which the size of the output matters, you probably want to run
the output through [`pngcrush`][2] or similar.

To see what's coming up, check out the [Github issues][0] for this project.

License
---
`nimage` is provided under the new-BSD three-clause license. The text of this
license is included in [LICENSE][1] as well as at the top of every source
file.

Contributing
---
Contributions via pull request are much appreciated! I especially would like
help with things marked `help-wanted` in the [issues][0].

[0]: http://github.com/haldean/nimage/issues
[1]: https://github.com/haldean/nimage/blob/master/LICENSE
[2]: http://pmt.sourceforge.net/pngcrush/
[3]: https://github.com/haldean/nimage/blob/master/tests/simplesave.nim
