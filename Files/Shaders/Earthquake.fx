texture screenSource;
float gTime : TIME;

float earthQuakeStrength = 1;

sampler TextureSampler = sampler_state {
    Texture = <screenSource>;
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};


float4 PixelShaderFunction(float2 texCoords : TEXCOORD0) : COLOR0 {	
	
	float2 uv = texCoords;
	float shakeValue = (sin(cos(gTime * 380)) / 300) * earthQuakeStrength;
	uv.x -= shakeValue;
	
	float4 rawColor = tex2D(TextureSampler, uv);

	return rawColor;
}
 
 
technique ShaderTest
{
    pass P0
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}


// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}