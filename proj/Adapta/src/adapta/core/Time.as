package adapta.core {

import flash.utils.getTimer;

/**
 * This static class handle time calculations on engine update cycles.
 *
 * @author hlavko
 */
public class Time {

    /**
     * Current time of application in milliseconds.
     */
    static private var _currentTimeMs:int;

    static private var _deltaTime:Number;

    /**
     * adapta.core.Time delta between current and last engine update cycle in seconds.
     */
    static public function get deltaTime():Number {
        return _deltaTime;
    }

    static private var _deltaTimeMs:int;

    /**
     * adapta.core.Time delta between current and last engine update cycle in milliseconds.
     */
    static public function get deltaTimeMs():int {
        return _deltaTimeMs;
    }

    /**
     * Save start time.
     */
    static public function start():void {
        _currentTimeMs = getTimer();
    }

    /**
     * Update delta times. Should be called on engine update cycle.
     */
    static public function update():void {
        // get current time in milliseconds
        var newTimeMs:int = getTimer();

        // calculate delta from last update in milliseconds
        _deltaTimeMs = newTimeMs - _currentTimeMs;

        // calculate delta in seconds
        _deltaTime = _deltaTimeMs / 1000;

        // update current time
        _currentTimeMs = newTimeMs;
    }

}

}