/**
 * Created by hlavko on 03.06.2014.
 */
package examples.SimpleMouseBrightness.component {

import examples.SimpleMouseBrightness.*;

import adapta.components.Stage3DRenderer;

import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DVertexBufferFormat;

import flash.geom.Vector3D;

public class CubeRenderer extends Stage3DRenderer {

    public function CubeRenderer() {
        super();
    }


    override public function transform():void {
        // mvp transformation matrix calculations
        _modelMatrix.identity();
        _modelMatrix.appendScale(entity.transform.scale.x, entity.transform.scale.y, entity.transform.scale.z);
        _modelMatrix.appendRotation(entity.transform.rotation.x, Vector3D.X_AXIS, entity.transform.pivot); // pitch
        _modelMatrix.appendRotation(entity.transform.rotation.y, Vector3D.Y_AXIS, entity.transform.pivot); // yaw
        _modelMatrix.appendRotation(entity.transform.rotation.z, Vector3D.Z_AXIS, entity.transform.pivot); // roll
        _modelMatrix.appendTranslation(entity.transform.position.x, entity.transform.position.y, entity.transform.position.z);

        // better pre-calculate constants in as3 then on the gpu for every vertex
        _modelViewProjection.identity();
        _modelViewProjection.append(_modelMatrix);
        _modelViewProjection.append(_camera.clipMatrix);
    }

    override public function constants():void {
        // model-view-projection
        _context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _modelViewProjection, true);

        var intensity:Number = MouseMask(entity.getComponent(MouseMask)).intensity;
        _context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, Vector.<Number>([intensity, 0.0, 0.0, 1.0]));

        //if (color)
        //    _context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, color.vectorize())
    }

    override public function buffers():void {
        _context3D.setVertexBufferAt(0, mesh.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
        _context3D.setVertexBufferAt(1, mesh.vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
    }

    override public function textures():void {
        _context3D.setTextureAt(0, texture);
    }

    override public function shaders():void {
        _context3D.setProgram(shader.program);
    }

    override public function triangles():void{
        _context3D.drawTriangles(mesh.indexBuffer, 0, mesh.meshIndexData.length / 3);
    }
}

}
