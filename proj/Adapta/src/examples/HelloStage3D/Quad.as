/**
 * Created by hlavko on 26.05.2014.
 */
package examples.HelloStage3D {

import adapta.geometry.*;

import adapta.core.Adapta;

public class Quad extends Mesh {

    public function Quad(id:String) {
        super(id);
    }

    override public function init():void {
        _meshVertexData = new Vector.<Number>();
        _meshVertexData.push(
                // Position XYZ, texture coordinate UV, normal XYZ, colours ARGB
                -1, -1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0,
                1, -1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0,
                1, 1,0, 1, 1, 0, 0, 1, 1, 1, 0, 0,
                -1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0
        );

        _meshIndexData = new Vector.<uint>();
        _meshIndexData.push(
                0, 1, 2,
                0, 2, 3
        );

        _indexBuffer = Adapta.context3D.createIndexBuffer(_meshIndexData.length);
        _indexBuffer.uploadFromVector(_meshIndexData, 0, _meshIndexData.length);

        _vertexBuffer = Adapta.context3D.createVertexBuffer(4, 12);
        _vertexBuffer.uploadFromVector(_meshVertexData, 0, 4);
    }
}

}
