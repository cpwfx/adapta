/**
 * Created by hlavko on 17.06.2014.
 */
package adapta.components.cameras {

import adapta.core.Adapta;
import adapta.core.Input;

import flash.display.Stage;

import flash.events.MouseEvent;

import flash.geom.Matrix3D;
import flash.geom.Vector3D;
import flash.ui.Keyboard;

public class FreeLookCamera3D extends PerspectiveCamera3D {

    private const ZOOM_SPEED:int = 10;
    private const STARTING_RADIUS:int = 5;

    private var _radius:int;
    private var _lastMouseX:Number;
    private var _lastMouseY:Number;
    private var _stage:Stage;
    private var _shiftX:Number = 0;
    private var _shiftY:Number = 0;

    public function FreeLookCamera3D() {
    }

    override public function init():void {
        super.init();

        _radius = STARTING_RADIUS;
        _stage = Adapta.main.stage;

        _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        _stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
    }

    override public function start():void {
        super.start();
    }

    override public function update():void {
        super.update();

        var rotationMatrix:Matrix3D = new Matrix3D();

        if (_shiftX != 0){
            _shiftX = -_shiftX;
            rotationMatrix.appendRotation(_shiftX, _realUp);
        }

        if (_shiftY != 0) {
            _shiftY = -_shiftY;
            rotationMatrix.appendRotation(_shiftY, _right);
        }

        if (_shiftX != 0 || _shiftY != 0) {
            var rotatedViewDirection:Vector3D = rotationMatrix.transformVector(_direction);
            rotatedViewDirection.scaleBy(_directionMagnitude);

            var newTarget:Vector3D = entity.transform.position.add(rotatedViewDirection);
            _target.x = newTarget.x;
            _target.y = newTarget.y;
            _target.z = newTarget.z;

            _shiftX = _shiftY = 0;
        }
    }

    override public function dispose():void {
        super.dispose();
    }

    private function onMouseDown(event:MouseEvent):void{
        _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

        _lastMouseX = _stage.mouseX;
        _lastMouseY = _stage.mouseY;
    }

    private function onMouseUp(event:MouseEvent):void{
        _stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        _stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    private function onMouseMove(event:MouseEvent):void{
        var dx:Number = _stage.mouseX - _lastMouseX;
        _shiftX = (dx / _stage.stageWidth) * 720;

        var dy:Number = _stage.mouseY - _lastMouseY;
        _shiftY = (dy / _stage.stageHeight) * 720;

        _lastMouseX = _stage.mouseX;
        _lastMouseY = _stage.mouseY;
    }

    private function onMouseWheel(event:MouseEvent):void{
        //_radius += -1 * event.delta * ZOOM_SPEED;
        // TODO
    }

}

}
