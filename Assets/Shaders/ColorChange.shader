Shader "Unlit/ColorChange"
{
   Properties
    {
        _Color ("Color", Color) = (1, 0, 0, 1) 
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float4 color : COLOR;
            };

            uniform float4 _Color;

            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = _Color; 
                return o;
            }

            half4 frag(v2f i) : SV_Target
            {
                return i.color; 
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}