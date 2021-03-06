# Copyright (c) 2015, Haldean Brown
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of nimage nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

from private/image import nil

export image.Image, image.`[]`, image.`[]=`, image.create_image
export image.NColor, image.`==`, image.`$`

from private/png import nil

export png.ColorType

from private/loadpng import nil

export loadpng.load_png

from private/savepng import nil

export savepng.save_png, savepng.PngEncoderOpts, savepng.new_opts, savepng.default_opts

# Manual documentation, to be removed when doc2 documents export properly
##[
Types
---------

.. code-block:: nimrod
  NColor* = distinct uint32

A color in RGBA format, 8 bits per sample. For example, 50% red, 100%
green, 0% blue, 100% alpha would be `NColor(0x80FF00FF)`.

.. code-block:: nimrod
  ImageObj* = object of RootObj
      width*: int
      height*: int
      data*: seq[NColor] # Data is stored in row-major format
  Image* = ref ImageObj

.. code-block:: nimrod  
  ColorType* = enum
    gray = 0
    rgb = 2
    palette = 3
    graya = 4
    rgba = 6

.. code-block:: nimrod
  PngEncoderOpts* = object
          colorType: ColorType

Procs
-----

.. code-block:: nimrod
  proc `[]`*(img: Image; row, col: int): NColor

.. code-block:: nimrod
  proc `[]=`*(img: Image; row, col: int; val: NColor)

.. code-block:: nimrod
  proc create_image*(width, height: int): Image

.. code-block:: nimrod
  proc `$`*(color: NColor): string 

.. code-block:: nimrod
  proc `==`*(c1, c2: NColor): bool 

.. code-block:: nimrod
  proc default_opts*(): PngEncoderOpts

.. code-block:: nimrod
  proc new_opts*(colorType: ColorType): PngEncoderOpts

Create an encoder options struct for a given color type. Note that for
grayscale color types, the value in the red channel is taken as the
gray value; green and blue channels are ignored, and the alpha channel is
ignored for gray (but not graya).

.. code-block:: nimrod
  proc save_png*(img: Image, buf: Stream, opts: PngEncoderOpts)

.. code-block:: nimrod
  proc save_png*(img: Image, buf: Stream)

.. code-block:: nimrod
  proc load_png*(buf: Stream): Image
]##