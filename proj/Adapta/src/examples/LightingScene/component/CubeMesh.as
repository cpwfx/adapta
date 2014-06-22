/**
 * Created by hlavko on 10.06.2014.
 */
package examples.LightingScene.component {

import adapta.core.Adapta;
import adapta.geometry.Mesh;

import flash.geom.Vector3D;

public class CubeMesh extends Mesh {

    public function CubeMesh(id:String) {
        super(id);
    }

    override public function init():void {
        _meshVertexData = new Vector.<Number>();
        _meshVertexData.push(
                -1,-1,-1, 0, 0, 0, 0, 0, //front face
                -1,1,-1, 1, 0, 0, 0, 0,
                1,1,-1, 1, 1, 0, 0, 0,
                1,-1,-1, 0, 1, 0, 0, 0,

                -1,-1,-1, 0, 0, 0, 0, 0, //bottom face
                1,-1,-1, 1, 0, 0, 0, 0,
                1,-1,1, 1, 1, 0, 0, 0,
                -1,-1,1, 0, 1, 0, 0, 0,

                -1,-1,1, 0, 0, 0, 0, 0, //back face
                1,-1,1, 1, 0, 0, 0, 0,
                1,1,1, 1, 1, 0, 0, 0,
                -1,1,1, 0, 1, 0, 0, 0,

                -1,1,1, 0, 0, 0, 0, 0, //top face
                1,1,1, 1, 0, 0, 0, 0,
                1,1,-1, 1, 1, 0, 0, 0,
                -1,1,-1, 0, 1, 0, 0, 0,

                -1,1,1, 0, 0, 0, 0, 0, //left face
                -1,1,-1, 1, 0, 0, 0, 0,
                -1,-1,-1, 1, 1, 0, 0, 0,
                -1,-1,1, 0, 1, 0, 0, 0,

                1,1,-1, 0, 0, 0, 0, 0, //right face
                1,1,1, 1, 0, 0, 0, 0,
                1,-1,1, 1, 1, 0, 0, 0,
                1,-1,-1, 0, 1, 0, 0, 0
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

        // compute normals
        var a:Vector3D = new Vector3D();
        var b:Vector3D = new Vector3D();
        var c:Vector3D = new Vector3D();
        var v1:Vector3D, v2:Vector3D, normal:Vector3D;
        var index1:int, index2:int, index3:int;
        for (var i:int = 0; i < _meshIndexData.length / 3; i++){
            index1 = _meshIndexData[i * 3] * 8;
            a.setTo(_meshVertexData[index1], _meshVertexData[index1 + 1], _meshVertexData[index1 + 2]);

            index2 = _meshIndexData[i * 3 + 1] * 8;
            b.setTo(_meshVertexData[index2], _meshVertexData[index2 + 1], _meshVertexData[index2 + 2]);

            index3 = _meshIndexData[i * 3 + 2] * 8;
            c.setTo(_meshVertexData[index3], _meshVertexData[index3 + 1], _meshVertexData[index3 + 2]);

            v1 = a.subtract(b);
            v2 = b.subtract(c);
            normal = v2.crossProduct(v1);

            _meshVertexData[index1 + 5] = _meshVertexData[index2 + 5] = _meshVertexData[index3 + 5] = normal.x;
            _meshVertexData[index1 + 6] = _meshVertexData[index2 + 6] = _meshVertexData[index3 + 6] = normal.y;
            _meshVertexData[index1 + 7] = _meshVertexData[index2 + 7] = _meshVertexData[index3 + 7] = normal.z;
        }

        _indexBuffer = Adapta.context3D.createIndexBuffer(_meshIndexData.length);
        _indexBuffer.uploadFromVector(_meshIndexData, 0, _meshIndexData.length);

        _vertexBuffer = Adapta.context3D.createVertexBuffer(24, 8);
        _vertexBuffer.uploadFromVector(_meshVertexData, 0, 24);
    }

}

}
