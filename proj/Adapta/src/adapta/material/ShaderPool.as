/**
 * Created by hlavko on 03.06.2014.
 */
package adapta.material {

import flash.utils.Dictionary;

public class ShaderPool {

    static private var _pool:Dictionary = new Dictionary();

    static public function add(shader:Shader):void{
        _pool[shader.id] = shader;
    }

    static public function acquire(shaderId:String):Shader{
        if (!(shaderId in _pool))
            throw new Error("ShaderPool does not contain shader with id'" + shaderId + ".");

        return _pool[shaderId];
    }

}

}
