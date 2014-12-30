# PixelPusher TwentySquared PGraphics Example

An example to make it easy to program PixelPusher TwentySquared LED Tiles.  This example shows a simple vector image being sent to all attached tiles.

Vector graphics are drawn to the `PGraphics` instance `tileBuffer`, and the tile's pixels are set using the `setTile(PGraphics img, Strip tile)` on an image and a tile to send the graphics buffer to the tile.  Anything drawn between `tileBuffer.beginGraphics()` and `tileBuffer.endGraphics()` will get sent to the TwentySquared.

# Credits
by morphogencc (nathan lachenmyer)

http://morphogen.cc/

2014 Dec
