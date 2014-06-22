/**
 * Created by hlavko on 26.05.2014.
 */
package examples.SimpleMouseBrightness.component {

import adapta.geometry.*;

import adapta.core.Adapta;

public class QuadMesh extends Mesh {

    public function QuadMesh(id:String) {
        super(id);
    }

    override public function init():void {
        _meshVertexData = new Vector.<Number>();
        _meshVertexData.push(
                -1, -1, 0, 0, 0,
                1, -1, 0, 1, 0,
                1, 1, 0, 1, 1,
                -1, 1, 0, 0, 1
        );

        _meshIndexData = new Vector.<uint>();
        _meshIndexData.push(
                0, 1, 2,
                0, 2, 3
        );

        _indexBuffer = Adapta.context3D.createIndexBuffer(_meshIndexData.length);
        _indexBuffer.uploadFromVector(_meshIndexData, 0, _meshIndexData.length);

        _vertexBuffer = Adapta.context3D.createVertexBuffer(4, 5);
        _vertexBuffer.uploadFromVector(_meshVertexData, 0, 4);
    }
}

}
