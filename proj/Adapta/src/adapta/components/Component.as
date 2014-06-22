/**
 * Created by hlavko on 22.05.2014.
 */
package adapta.components {

import adapta.entities.Entity;
import adapta.core.ILoop;

/**
 * Component
 * TODO - docs
 *
 * @author hlavko
 */
public class Component implements ILoop {

    private var _entity:Entity;

    public function get entity():Entity {
        return _entity;
    }

    public function set entity(value:Entity):void {
        _entity = value;
    }

    public function Component() {
        init();
    }

    /*
     *  ILoop interface implementation.
     */

    public function init():void {
    }

    public function start():void {
    }

    public function update():void {
    }

    public function dispose():void {
    }
}

}
