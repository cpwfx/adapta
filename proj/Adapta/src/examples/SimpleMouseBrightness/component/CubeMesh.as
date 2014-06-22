/**
 * Created by hlavko on 10.06.2014.
 */
package examples.SimpleMouseBrightness.component {

import adapta.core.Adapta;
import adapta.geometry.Mesh;

public class CubeMesh extends Mesh {

    public function CubeMesh(id:String) {
        super(id);
    }

    override public function init():void {
        _meshVertexData = new Vector.<Number>();
        _meshVertexData.push(
                -1,-1,-1, 0, 0, //front face
                -1,1,-1, 1, 0,
                1,1,-1, 1, 1,
                1,-1,-1, 0, 1,

                -1,-1,-1, 0, 0, //bottom face
                1,-1,-1, 1, 0,
                1,-1,1, 1, 1,
                -1,-1,1, 0, 1,

                -1,-1,1, 0, 0, //back face
                1,-1,1, 1, 0,
                1,1,1, 1, 1,
                -1,1,1, 0, 1,

                -1,1,1, 0, 0, //top face
                1,1,1, 1, 0,
                1,1,-1, 1, 1,
                -1,1,-1, 0, 1,

                -1,1,1, 0, 0, //left face
                -1,1,-1, 1, 0,
                -1,-1,-1, 1, 1,
                -1,-1,1, 0, 1,

                1,1,-1, 0, 0, //right face
                1,1,1, 1, 0,
                1,-1,1, 1, 1,
                1,-1,-1, 0, 1
        );

        _meshIndexData = new Vector.<uint>();
        _meshIndexData.push(
                2,1,0,      3,2,0,      //front face
                4,7,5,      7,6,5,      //bottom face
                8,11,9,     9,11,10,    //back face
                12,15,13,   13,15,14,   //top face
                16,19,17,   17,19,18,   //left face
                20,23,21,   21,23,22    //right face
        );

        _indexBuffer = Adapta.context3D.createIndexBuffer(_meshIndexData.length);
        _indexBuffer.uploadFromVector(_meshIndexData, 0, _meshIndexData.length);

        _vertexBuffer = Adapta.context3D.createVertexBuffer(24, 5);
        _vertexBuffer.uploadFromVector(_meshVertexData, 0, 24);
    }

}

}
