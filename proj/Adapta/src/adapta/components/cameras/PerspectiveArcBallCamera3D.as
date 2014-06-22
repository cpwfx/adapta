/**
 * Created by hlavko on 17.06.2014.
 */
package adapta.components.cameras {

import adapta.core.Adapta;

import flash.display.Stage;
import flash.events.MouseEvent;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;

public class PerspectiveArcBallCamera3D extends PerspectiveCamera3D {

    private const STARTING_RADIUS:int = 5;

    private var _radius:int;
    private var _lastMouseX:Number;
    private var _lastMouseY:Number;
    private var _stage:Stage;
    private var _shiftX:Number = 0;
    private var _shiftY:Number = 0;

    public function PerspectiveArcBallCamera3D() {
        super();
    }

    override public function init():void {
        super.init();

        _radius = STARTING_RADIUS;
        _stage = Adapta.main.stage;

        _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    }

    override public function start():void {
        super.start();

        entity.transform.position.z = STARTING_RADIUS;

        _viewMatrix.appendTranslation(entity.transform.position.x, entity.transform.position.y, entity.transform.position.z);
    }

    override public function update():void {
        updateViewMatrix();
        updateClipMatrix();
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

    override protected function updateViewMatrix():void {
        if (_shiftX != 0){
            _shiftX = -_shiftX;

            var rotationMatrix:Matrix3D = new Matrix3D();
            rotationMatrix.appendRotation(_shiftX, _realUp);

            _direction.x = - _target.x + entity.transform.position.x;
            _direction.y = - _target.y + entity.transform.position.y;
            _direction.z = - _target.z + entity.transform.position.z;

            var newPosition:Vector3D = rotationMatrix.transformVector(_direction).add(_target);

            entity.transform.position.x = newPosition.x;
            entity.transform.position.y = newPosition.y;
            entity.transform.position.z = newPosition.z;
        }

        if (_shiftY != 0){
            _shiftY = -_shiftY;

            var rotationMatrix:Matrix3D = new Matrix3D();
            rotationMatrix.appendRotation(_shiftY, _right);

            _direction.x = - _target.x + entity.transform.position.x;
            _direction.y = - _target.y + entity.transform.position.y;
            _direction.z = - _target.z + entity.transform.position.z;

            var newPosition:Vector3D = rotationMatrix.transformVector(_direction).add(_target);

            entity.transform.position.x = newPosition.x;
            entity.transform.position.y = newPosition.y;
            entity.transform.position.z = newPosition.z;
        }

        _shiftX = _shiftY = 0;

        super.updateViewMatrix();
    }

}

}
