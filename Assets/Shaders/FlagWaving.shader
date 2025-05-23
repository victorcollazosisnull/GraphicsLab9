Shader "Unlit/FlagWaving"
{
    Properties
    {
        _MainTex ("Flag Texture", 2D) = "white" {}
        _WindSpeed ("Wind Speed", Range(0, 10)) = 1
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

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _WindSpeed;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION; 
            };

            v2f vert(appdata_t v)
            {
                v2f o;

                float time = _Time.y * _WindSpeed;

                float waveX = sin(time + v.vertex.y * 10.0) * 0.1;
                float waveZ = cos(time + v.vertex.y * 5.0 + v.vertex.x * 2.0) * 0.05;

                float4 displaced = v.vertex;
                displaced.x += waveX;
                displaced.z += waveZ;

                o.pos = UnityObjectToClipPos(displaced);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}