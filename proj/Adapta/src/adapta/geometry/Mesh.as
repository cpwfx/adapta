/**
 * Created by hlavko on 26.05.2014.
 */
package adapta.geometry {

import adapta.components.Component;
import adapta.material.TextureUtils;

import flash.display3D.IndexBuffer3D;
import flash.display3D.VertexBuffer3D;

public class Mesh extends Component {

    private var _id:String;

    public function get id():String {
        return _id;
    }

    protected var _meshVertexData:Vector.<Number>;

    public function get meshVertexData():Vector.<Number> {
        return _meshVertexData;
    }

    protected var _meshIndexData:Vector.<uint>;

    public function get meshIndexData():Vector.<uint> {
        return _meshIndexData;
    }

    protected var _vertexBuffer:VertexBuffer3D;

    public function get vertexBuffer():VertexBuffer3D {
        return _vertexBuffer;
    }

    protected var _indexBuffer:IndexBuffer3D;

    public function get indexBuffer():IndexBuffer3D {
        return _indexBuffer;
    }

    public function Mesh(id:String) {
        _id = id;
    }


}

}
