/**
 * Created by hlavko on 03.06.2014.
 */
package examples.SimpleMouseBrightness.component {

import adapta.material.Shader;

public class MouseMaskShader extends Shader {

    public function MouseMaskShader() {
        super("MouseMaskShader");
    }

    override protected function vertexShader():XML {
        return <shader>
        m44 op, va0, vc0
        mov v0, va0
        mov v1, va1
        </shader>;
    }

    override protected function fragmentShader():XML {
        return <shader>
        tex ft0, v1, fs[2d,repeat,mip_linear]
        mul ft1, ft0, fc0
        mov oc, ft1
        </shader>;
    }

}

}
