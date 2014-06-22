/**
 * Created by hlavko on 02.06.2014.
 */
package adapta.material {

import flash.display3D.textures.Texture;
import flash.utils.Dictionary;

public class TexturePool {

    static private var _pool:Dictionary = new Dictionary();

    static public function add(textureId:String, texture:Texture):void{
        _pool[textureId] = texture;
    }

    static public function acquire(textureId:String):Texture{
        if (!(textureId in _pool))
            throw new Error("TexturePool does not contain texture with id'" + textureId + ".");

        return _pool[textureId];
    }

}

}
