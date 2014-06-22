package adapta.entities {

import adapta.core.*;

import adapta.components.Component;
import adapta.components.Transform;

/**
 * Entity class.
 * TODO - entity
 *
 * @author hlavko
 */
public class Entity {

    private var _started:Boolean;

    public function get started():Boolean {
        return _started;
    }

    private var _components:Vector.<Component>

    private var _transform:Transform;

    public function get transform():Transform {
        return _transform;
    }

    public function Entity() {
        _init();
        init();
    }

    private function _init():void{
        // create components container
        _components = new Vector.<Component>();

        // transform is created by default
        _transform = addFromClass(Transform) as Transform;
    }

    public function addFromInstance(component:Component):Component{
        // save entity-component relation
        _components.push(component);
        component.entity = this;

        return component;
    }

    public function addFromClass(cl:Class):Component{
        // create new component from class
        var component:Component = new cl();

        // save entity-component relation
        return addFromInstance(component);
    }

    public function getComponent(cl:Class):Component{
        for (var i:int = 0; i < _components.length; i++)
            if (_components[i] is cl)
                return _components[i];

        throw new AdaptaError("No attached component of class " + cl + " to this entity.");
    }

    public function hasComponent(cl:Class):Boolean{
        for (var i:int = 0; i < _components.length; i++)
            if (_components[i] is cl)
                return true;

        return false;
    }

    /*
     *  ILoop interface implementation.
     */

    public function dispose():void {
        for (var i:int = 0; i < _components.length; i++) {
            _components[i].dispose();
            _components[i].entity = null;
        }

        _components = null;
    }

    public function init():void {
    }

    public function start():void {
        for (var i:int = 0; i < _components.length; i++) {
            _components[i].start();
        }

        _started = true;
    }

    public function update():void {
        for (var i:int = 0; i < _components.length; i++) {
            _components[i].update();
        }
    }

}

}
