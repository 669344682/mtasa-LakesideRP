float red; 
float green; 
float blue; 
float alpha; 
  
technique simple 
{ 
    pass P0 
    { 
        MaterialAmbient = float4(red, green, blue, alpha); 
        MaterialDiffuse = float4(red, green, blue, alpha);
        MaterialEmissive = float4(red, green, blue, alpha);

        DiffuseMaterialSource = Material;
        EmissiveMaterialSource = Material;
        NormalizeNormals = TRUE;
        // FillMode = WIREFRAME;
        // AlphaBlendEnable = TRUE;
        

        ColorOp[0] = SELECTARG1;
        ColorArg1[0] = Diffuse;
        
        AlphaOp[0] = SELECTARG1;
        AlphaArg1[0] = Diffuse;
        
        Lighting = true;		
    } 
} 