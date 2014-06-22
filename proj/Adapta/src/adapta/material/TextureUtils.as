/**
 * Created by hlavko on 26.05.2014.
 */
package adapta.material {

import adapta.components.Component;
import adapta.core.*;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.textures.Texture;
import flash.geom.Matrix;

public class TextureUtils extends Component {

    static public function createTextureFromBitmap(bmp:Bitmap, mipmap:Boolean, width:int, height:int):Texture {
        var texture:Texture = Adapta.context3D.createTexture(width, height, Context3DTextureFormat.BGRA, false);

        var ws:int = bmp.bitmapData.width;
        var hs:int = bmp.bitmapData.height;
        var level:int = 0;
        var tmp:BitmapData = new BitmapData(ws, hs, true, 0x00000000);
        var transform:Matrix = new Matrix();

        while (ws >= 1 && hs >= 1) {
            tmp.draw(bmp.bitmapData, transform, null, null);
            texture.uploadFromBitmapData(tmp, level);
            transform.scale(0.5, 0.5);
            level++;
            ws >>= 1;
            hs >>= 1;

            if (hs && ws) {
                tmp.dispose();
                tmp = new BitmapData(ws, hs, true, 0x00000000);
            }

            if (!mipmap)
                break;
        }

        tmp.dispose();

        return texture;
    }

}

}
