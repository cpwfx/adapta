/**
 * Created by hlavko on 02.06.2014.
 */
package adapta.geometry {

import flash.utils.Dictionary;

public class MeshPool {

    static private var _pool:Dictionary = new Dictionary();

    static public function add(mesh:Mesh):void{
        _pool[mesh.id] = mesh;
    }

    static public function acquire(meshId:String):Mesh{
        if (!(meshId in _pool))
            throw new Error("MeshPool does not contain mesh with id'" + meshId + ".");

        return _pool[meshId];
    }

}

}
