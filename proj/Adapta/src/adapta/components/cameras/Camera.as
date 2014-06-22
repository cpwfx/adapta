/**
 * Created by hlavko on 03.06.2014.
 */
package adapta.components.cameras {

import adapta.components.Component;

import flash.geom.Matrix3D;

public class Camera extends Component {

    // camera projection matrix
    protected var _projectionMatrix:Matrix3D;

    public function get projectionMatrix():Matrix3D {
        return _projectionMatrix;
    }

    public function set projectionMatrix(value:Matrix3D):void {
        _projectionMatrix = value;
    }

    // camera in the world matrix
    protected var _viewMatrix:Matrix3D;

    public function get viewMatrix():Matrix3D {
        return _viewMatrix;
    }

    public function set viewMatrix(value:Matrix3D):void {
        _viewMatrix = value;
    }

    // clip matrix = view matrix * projection matrix
    protected var _clipMatrix:Matrix3D;

    public function get clipMatrix():Matrix3D {
        return _clipMatrix;
    }

    public function set clipMatrix(value:Matrix3D):void {
        _clipMatrix = value;
    }

    public function Camera() {
    }

    override public function init():void {
        _viewMatrix = new Matrix3D();
        _projectionMatrix = new Matrix3D();
        _clipMatrix = new Matrix3D();
    }

}

}
