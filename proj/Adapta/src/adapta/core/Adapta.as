package adapta.core {

import adapta.components.Stage3DRenderer;
import adapta.debug.Stats;
import adapta.entities.Entity;
import adapta.geometry.Mesh;
import adapta.material.Shader;

import flash.display.Sprite;
import flash.display.Stage3D;
import flash.display3D.Context3D;
import flash.display3D.textures.Texture;
import flash.events.Event;
import flash.utils.getQualifiedClassName;

/**
 * Main Adapta engine static class.
 * Engine is simply a collection of entities with game loop
 * that is updating game in the cycle.
 *
 * @author hlavko
 */
public class Adapta {

    /**
     * Application document object.
     */
    private static var _main:Sprite;

    public static function get main():Sprite {
        return _main;
    }

    static private var _startingSceneClass:Class;

    private static var _scene:Scene;

    public static function get scene():Scene {
        return _scene;
    }

    static private var _stats:Stats;

    /**
     * Stage3D API.
     */
    static private var _stage3D:Stage3D;

    /**
     * Context3D rendering surface.
     */
    private static var _context3D:Context3D;

    public static function get context3D():Context3D {
        return _context3D;
    }

    /**
     * Vector of all entities in the scene.
     */
    static private var _entities:Vector.<Entity>;

    /**
     * Add entity to the scene.
     * @param entity
     */
    static public function add(entity:Entity):void {
        _entities.push(entity);
    }

    static private function initStage3D(e:Event):void {
        _context3D = _stage3D.context3D;
        _context3D.enableErrorChecking = true;
        _context3D.configureBackBuffer(main.stage.stageWidth, main.stage.stageHeight, 0, true);
        //_context3D.setCulling(Context3DTriangleFace.BACK);

        _scene = new _startingSceneClass();
        _scene.start();

        _main.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
    }

    /**
     * Initialize engine.
     * @param main
     */
    static public function start(main:Sprite, startingSceneClass:Class, debugStats:Boolean = false):void {
        // main document
        _main = main;
        _main.stage.addEventListener(Event.RESIZE, onResize);

        _startingSceneClass = startingSceneClass;

        // entities
        _entities = new Vector.<Entity>();

        // stage3D
        _stage3D = _main.stage.stage3Ds[0];
        _stage3D.addEventListener(Event.CONTEXT3D_CREATE, initStage3D, false, 0, true);
        _stage3D.requestContext3D();

        if (debugStats) {
            _stats = new Stats();
            _main.addChild(_stats);
        }

        // input
        Input.start(_main);

        // timer
        Time.start();
    }

    static private function onResize(e:Event):void {
        trace("resize", _main.stage.stageWidth, _main.stage.stageHeight, _context3D);

        if (_context3D == null)
            return;

        _context3D.configureBackBuffer(main.stage.stageWidth, main.stage.stageHeight, 0, true);
    }

    /**
     * Update current game scene.
     * @param e
     */
    static private function update(e:Event = null):void {
        // update time
        Time.update();

        // loop over all entities in the scene and update them
        var entity:Entity;
        for (var i:int = 0; i < _entities.length; i++) {
            // get entity
            entity = _entities[i];

            // start() entity if it was not started yet
            if (!entity.started)
                entity.start();

            // update entity
            _entities[i].update();
        }

        // update camera
        _scene.camera.update();

        // render everything

        // the back buffer must be cleared before we start trying to draw new stuff on it
        _context3D.clear(0, 0, 0);

        var lastMesh:Mesh = null;
        var lastTexture:Texture = null;
        var lastShader:Shader = null;

        var renderer:Stage3DRenderer;
        for (i = 0; i < _entities.length; i++) {
            // get entity
            entity = _entities[i];

            if (entity.hasComponent(Stage3DRenderer)) {
                renderer = entity.getComponent(Stage3DRenderer) as Stage3DRenderer;

                // transform
                renderer.transform();

                // constants
                renderer.constants();

                // buffers
                if (getQualifiedClassName(renderer.mesh) != getQualifiedClassName(lastMesh)) {
                    renderer.buffers();
                    lastMesh = renderer.mesh;
                }

                // texture
                if (renderer.texture != lastTexture) {
                    renderer.textures();
                    lastTexture = renderer.texture;
                }

                // shader
                if (getQualifiedClassName(renderer.shader) != getQualifiedClassName(lastShader)) {
                    renderer.shaders();
                    lastShader = renderer.shader;
                }

                // draw
                renderer.triangles();
            }
        }

        _context3D.present();

        if (_stats != null)
            _stats.update();

    }


}

}