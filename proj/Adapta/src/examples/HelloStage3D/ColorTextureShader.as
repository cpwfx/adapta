/**
 * Created by hlavko on 02.06.2014.
 */
package examples.HelloStage3D {

import adapta.material.Shader;

public class ColorTextureShader extends Shader {

    public function ColorTextureShader() {
        super();
    }

    override protected function vertexShader():String {
        return "m44 op, va0, vc0\n" +
            // tell fragment shader about XYZ
                "mov v0, va0\n" +
            // tell fragment shader about UV
                "mov v1, va1\n" +
            // tell fragment shader about normals
                "mov v2, va2\n" +
            // tell fragment shader about RGBA
                "mov v3, va3\n";
    }


    override protected function fragmentShader():String {
        return "tex ft0, v1, fs0 <2d,repeat,miplinear>\n" +
                "mul ft1, ft0, fc0\n" +
                "mov oc, ft1\n";
    }

}

}
