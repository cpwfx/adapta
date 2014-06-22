/**
 * Created by hlavko on 02.06.2014.
 */
package adapta.material {

import adapta.core.Adapta;

import com.adobe.utils.AGALMiniAssembler;

import flash.display3D.Context3DProgramType;
import flash.display3D.Program3D;

public class Shader {

    private var _id:String;

    public function get id():String {
        return _id;
    }

    protected var _program:Program3D;

    public function get program():Program3D {
        return _program;
    }

    protected var _vertexShaderAssembler:AGALMiniAssembler;

    protected var _fragmentShaderAssembler:AGALMiniAssembler;

    public function Shader(id:String) {
        _id = id;

        preinit();
        postinit();
    }

    private function preinit():void{
        _vertexShaderAssembler = new AGALMiniAssembler();
        _fragmentShaderAssembler = new AGALMiniAssembler();

        _vertexShaderAssembler.assemble(Context3DProgramType.VERTEX, parse(vertexShader()));
        _fragmentShaderAssembler.assemble(Context3DProgramType.FRAGMENT, parse(fragmentShader()));
    }

    protected function parse(xml:XML):String{
        return xml.text().toXMLString().replace(/\[/g,'<').replace(/\]/g,'>');
    }

    protected function vertexShader():XML{
        throw new Error("Override me");
    }

    protected function fragmentShader():XML{
        throw new Error("Override me");
    }

    private function postinit():void {
        _program = Adapta.context3D.createProgram();
        _program.upload(_vertexShaderAssembler.agalcode, _fragmentShaderAssembler.agalcode);
    }

}

}
