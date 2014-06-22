/**
 * Created by hlavko on 17.06.2014.
 */
package adapta.components.cameras {

import adapta.core.Adapta;
import adapta.core.Input;

import flash.geom.Matrix3D;
import flash.geom.Vector3D;
import flash.ui.Keyboard;

public class PerspectiveCamera3D extends Camera {

    // near clip distance
    protected var _near:Number;

    // far clip distance
    protected var _far:Number;

    // camera look at target
    protected var _target:Vector3D;

    public function get target():Vector3D {
        return _target;
    }

    // direction where is camera pointing
    protected var _direction:Vector3D;

    public function get direction():Vector3D {
        return _direction;
    }

    protected var _directionMagnitude:Number;

    // up direction
    protected var _up:Vector3D;

    // real up direction
    protected var _realUp:Vector3D;

    // right direction
    protected var _right:Vector3D;

    // aspect ratio
    protected var _aspect:Number;

    // vertical field of view
    protected var _vFOW:Number;

    // temporary matrix
    protected var _tempMatrix:Matrix3D;

    public function PerspectiveCamera3D() {
    }

    override public function init():void {
        super.init();

        _target = new Vector3D();
        _direction = new Vector3D();
        _right = new Vector3D();
        _realUp = new Vector3D();

        _tempMatrix = new Matrix3D();
    }

    override public function start():void {
        super.start();

        _up = new Vector3D(0, 1, 0);
        _up.normalize();

        _near = 0.01;
        _far = 100;
        _aspect = Adapta.main.stage.stageWidth / Adapta.main.stage.stageHeight;
        _vFOW = 45;
        //_vFOW = 40*(Math.PI/180);

        entity.transform.position.z = 10;

        updateProjectionMatrix();
    }

    override public function update():void {
        super.update();

        if (Input.testKey(Keyboard.W))
            moveForward(0.1);

        if (Input.testKey(Keyboard.S))
            moveBackward(0.1);

        if (Input.testKey(Keyboard.A))
            moveLeft(0.1);

        if (Input.testKey(Keyboard.D))
            moveRight(0.1);

        if (Input.testKey(Keyboard.Y))
            moveUp(0.1);

        if (Input.testKey(Keyboard.H))
            moveDown(0.1);

        if (Input.testKey(Keyboard.R))
            yaw(-1);

        if (Input.testKey(Keyboard.T))
            yaw(1);

        if (Input.testKey(Keyboard.F))
            pitch(-1);

        if (Input.testKey(Keyboard.G))
            pitch(1);

        if (Input.testKey(Keyboard.V))
            roll(-1);

        if (Input.testKey(Keyboard.B))
            roll(1);

        updateViewMatrix();
        updateClipMatrix();
    }

    override public function dispose():void {
        super.dispose();
    }

    public function moveForward(units:Number):void {
        moveAlongAxis(units, _direction);
    }

    public function moveBackward(units:Number):void {
        moveAlongAxis(-units, _direction);
    }

    public function moveRight(units:Number):void {
        moveAlongAxis(units, _right);
    }

    public function moveLeft(units:Number):void {
        moveAlongAxis(-units, _right);
    }

    public function moveUp(units:Number):void {
        moveAlongAxis(units, _up);
    }

    public function moveDown(units:Number):void {
        moveAlongAxis(-units, _up);
    }

    public function moveAlongAxis(units:Number, axis:Vector3D):void {
        // move camera towards the axis by delta distance
        var delta:Vector3D = axis.clone();
        delta.scaleBy(units);

        // add delta distance to current camera position
        var newPos:Vector3D = entity.transform.position.add(delta);
        entity.transform.position.x = newPos.x;
        entity.transform.position.y = newPos.y;
        entity.transform.position.z = newPos.z;

        // add delta distance to current camera target
        var newTarget:Vector3D = _target.add(delta);
        _target.x = newTarget.x;
        _target.y = newTarget.y;
        _target.z = newTarget.z;
    }

    public function yaw(degrees:Number):void {
        rotate(degrees, _realUp);
    }

    public function pitch(degrees:Number):void {
        rotate(degrees, _right);
    }

    public function roll(degrees:Number):void {
        if (isNaN(degrees))
            return;

        degrees = -degrees;

        var rotationMatrix:Matrix3D = new Matrix3D();
        rotationMatrix.appendRotation(degrees, _direction);

        _up = rotationMatrix.transformVector(_up);
        _up.normalize();
    }

    protected function rotate(degrees:Number, axis:Vector3D):void {
        if (isNaN(degrees))
            return;

        degrees = -degrees;

        var rotationMatrix:Matrix3D = new Matrix3D();
        rotationMatrix.appendRotation(degrees, axis);

        var rotatedViewDirection:Vector3D = rotationMatrix.transformVector(_direction);
        rotatedViewDirection.scaleBy(_directionMagnitude);

        var newTarget:Vector3D = entity.transform.position.add(rotatedViewDirection);
        _target.x = newTarget.x;
        _target.y = newTarget.y;
        _target.z = newTarget.z;
    }

    protected function updateViewMatrix():void {
        // viewDir = target - position
        _direction.x = _target.x - entity.transform.position.x;
        _direction.y = _target.y - entity.transform.position.y;
        _direction.z = _target.z - entity.transform.position.z;
        _directionMagnitude = _direction.normalize();

        // rightDir = viewDir X upPrime
        _right = _direction.crossProduct(_up);

        // realUpDir = rightDir X viewDir
        _realUp = _right.crossProduct(_direction);

        // Translation by -position
        _viewMatrix.identity();
        _viewMatrix.appendTranslation(-entity.transform.position.x, -entity.transform.position.y, -entity.transform.position.z);

        // Look At matrix. Some parts of this are constant.
        var rawData:Vector.<Number> = _tempMatrix.rawData;
        rawData[0] = _right.x;
        rawData[1] = _right.y;
        rawData[2] = _right.z;
        rawData[3] = 0;
        rawData[4] = _realUp.x;
        rawData[5] = _realUp.y;
        rawData[6] = _realUp.z;
        rawData[7] = 0;
        rawData[8] = -_direction.x;
        rawData[9] = -_direction.y;
        rawData[10] = -_direction.z;
        rawData[11] = 0;
        rawData[12] = 0;
        rawData[13] = 0;
        rawData[14] = 0;
        rawData[15] = 1;
        _tempMatrix.copyRawDataFrom(rawData, 0, true);

        _viewMatrix.append(_tempMatrix);
    }

    protected function updateProjectionMatrix():void {
        var f:Number = 1.0 / Math.tan(_vFOW / 2.0);
        // already transposed matrix
        _projectionMatrix.rawData = new <Number>[
                    f / _aspect, 0, 0, 0,
            0, f, 0, 0,
            0, 0, ((_far) / (_near - _far)), -1,
            0, 0, ((2 * _far * _near) / (_near - _far)), 0
        ];
    }

    protected function updateClipMatrix():void {
        _clipMatrix.identity();
        _clipMatrix.append(_viewMatrix);
        _clipMatrix.append(_projectionMatrix);

    }

}

}
