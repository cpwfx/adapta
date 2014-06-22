/**
 * Created by hlavko on 03.06.2014.
 */
package adapta.components {

import adapta.core.Adapta;
import adapta.components.cameras.Camera;
import adapta.geometry.Mesh;
import adapta.material.Color;
import adapta.material.Shader;

import flash.display3D.Context3D;

import flash.display3D.textures.Texture;
import flash.geom.Matrix3D;

public class Stage3DRenderer extends Component {

    protected var _context3D:Context3D;

    protected var _camera:Camera;

    protected var _modelMatrix:Matrix3D;

    public function get modelMatrix():Matrix3D {
        return _modelMatrix;
    }

    public function set modelMatrix(value:Matrix3D):void {
        _modelMatrix = value;
    }

    protected var _modelViewProjection:Matrix3D;

    public function get modelViewProjection():Matrix3D {
        return _modelViewProjection;
    }

    public function set modelViewProjection(value:Matrix3D):void {
        _modelViewProjection = value;
    }

    private var _color:Color;

    public function get color():Color {
        return _color;
    }

    public function set color(value:Color):void {
        _color = value;
    }

    private var _mesh:Mesh;

    public function get mesh():Mesh {
        return _mesh;
    }

    public function set mesh(value:Mesh):void {
        _mesh = value;
    }

    private var _shader:Shader;

    public function get shader():Shader {
        return _shader;
    }

    public function set shader(value:Shader):void {
        _shader = value;
    }

    private var _texture:Texture;

    public function get texture():Texture {
        return _texture;
    }

    public function set texture(value:Texture):void {
        _texture = value;
    }

    public function Stage3DRenderer() {
        _context3D = Adapta.context3D;
        _camera = Adapta.scene.camera;

        _modelMatrix = new Matrix3D();
        _modelViewProjection = new Matrix3D();
    }

    public function transform():void {
        throw new Error("Override me.");
    }

    public function constants():void {
        throw new Error("Override me.");
    }

    public function buffers():void {
        throw new Error("Override me.");
    }

    public function textures():void {
        throw new Error("Override me.");
    }

    public function shaders():void {
        throw new Error("Override me.");
    }

    public function triangles():void{
        throw new Error("Override me.");
    }


}

}
