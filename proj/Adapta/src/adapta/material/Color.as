/**
 * Created by hlavko on 02.06.2014.
 */
package adapta.material {

public class Color {

    private var _R:Number;

    public function get R():Number {
        return _R;
    }

    public function set R(value:Number):void {
        _R = Math.max(0.0, Math.min(1.0, value));
    }

    private var _G:Number;

    public function get G():Number {
        return _G;
    }

    public function set G(value:Number):void {
        _G = Math.max(0.0, Math.min(1.0, value));;
    }

    private var _B:Number;

    public function get B():Number {
        return _B;
    }

    public function set B(value:Number):void {
        _B = Math.max(0.0, Math.min(1.0, value));;
    }

    private var _A:Number;

    public function get A():Number {
        return _A;
    }

    public function set A(value:Number):void {
        _A = Math.max(0.0, Math.min(1.0, value));;
    }

    public function Color(red:Number, green:Number, blue:Number, alpha:Number) {
        _R = red;
        _G = green;
        _B = blue;
        _A = alpha;
    }

    public function vectorize():Vector.<Number>{
        return Vector.<Number>([_R, _G, _B, _A]);
    }

}

}
