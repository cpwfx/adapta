/**
 * Created by hlavko on 18.06.2014.
 */
package adapta.components.cameras {

import adapta.core.Adapta;

import flash.display.Stage;
import flash.events.MouseEvent;
import flash.geom.Vector3D;

public class ArcBallCamera3D extends Camera {

    private const STARTING_RADIUS:int = 10;

    private var _radius:int;
    private var _lastMouseX:Number;
    private var _lastMouseY:Number;
    private var _stage:Stage;
    private var _shiftX:Number = 0;
    private var _shiftY:Number = 0;

    protected var _aspect:Number;
    protected var _vFOW:Number;
    protected var _near:Number;
    protected var _far:Number;

    private var _target:Vector3D;

    public function ArcBallCamera3D() {
    }

    override public function init():void {
        super.init();

        _radius = -STARTING_RADIUS;
        _stage = Adapta.main.stage;
        _target = new Vector3D();

        _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        _stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
    }

    override public function start():void {
        super.start();

        _near = 0.1;
        _far = 1000;
        _aspect = _stage.stageWidth / _stage.stageHeight;
        _vFOW = 45 * Math.PI / 180;

        entity.transform.position.z = _radius;

        _viewMatrix.appendTranslation(entity.transform.position.x, entity.transform.position.y, entity.transform.position.z);

        updateProjectionMatrix();
    }

    override public function update():void {
        updateViewMatrix();
        updateClipMatrix();
    }

    override public function dispose():void {
        super.dispose();
    }

    private function onMouseWheel(event:MouseEvent):void {
        var zoomSpeed = Math.max(_radius*.5, 1);
        _radius += -event.delta * zoomSpeed;
        entity.transform.position.z = -_radius;
        _viewMatrix.appendTranslation(0, 0, event.delta);
    }

    private function onMouseDown(event:MouseEvent):void {
        _stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

        _lastMouseX = _stage.mouseX;
        _lastMouseY = _stage.mouseY;
    }

    private function onMouseUp(event:MouseEvent):void {
        _stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        _stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    private function onMouseMove(event:MouseEvent):void {
        var dx:Number = _stage.mouseX - _lastMouseX;
        _shiftX = (dx / _stage.stageWidth) * 720;

        var dy:Number = _stage.mouseY - _lastMouseY;
        _shiftY = (dy / _stage.stageHeight) * 720;

        _lastMouseX = _stage.mouseX;
        _lastMouseY = _stage.mouseY;
    }

    protected function updateViewMatrix():void {
        if (_shiftX != 0) {
            _viewMatrix.prependRotation(_shiftX, Vector3D.Y_AXIS)
        }

        if (_shiftY != 0) {
            _viewMatrix.prependRotation(_shiftY, Vector3D.X_AXIS)
        }

        _viewMatrix.pointAt(entity.transform.position, _target);

        entity.transform.position.x = _viewMatrix.position.x;
        entity.transform.position.y = _viewMatrix.position.y;
        entity.transform.position.z = _viewMatrix.position.z;

        _shiftX = _shiftY = 0;
    }

    protected function updateProjectionMatrix():void {
        var f:Number = 1.0 / Math.tan(_vFOW / 2.0);
        // already transposed matrix
        _projectionMatrix.rawData = new <Number>[
                    f / _aspect, 0, 0, 0,
            0, f, 0, 0,
            0, 0, (_far / (_near - _far)), -1,
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
