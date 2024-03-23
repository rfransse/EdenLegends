#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\BloomAptLuminance-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Base;
sampler Base_Sampler;
sampler2D Shader;
sampler Shader_Sampler;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void BloomAptLuminance(sampler2D PreTexture,
    sampler PreSampler,
    sampler2D Texture,
    sampler Sampler,
    float2 TexCoord,
    float BloomSpeed,
    out float4 Output)
{
#ifdef D3D10
    float3 PreColor = PreTexture.Sample (PreSampler, TexCoord);
    float3 Color = Texture.Sample (Sampler, TexCoord);
#else
    float3 PreColor = tex2D (PreTexture, TexCoord);
    float3 Color = tex2D (Texture, TexCoord);
#endif
    Color = lerp (PreColor, Color, BloomSpeed);
    Output = float4 (clamp (Color, exp2 (-4.0), exp2 (4.0)), 1.0);

}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Input:
//---------------------------------------------------------------------------

struct Input
{
    float4 PosProjected : POSITION0;
    float2 UVSet0 : TEXCOORD0;

};

//---------------------------------------------------------------------------
// Output:
//---------------------------------------------------------------------------

struct Output
{
    float4 Color : COLOR0;

};

//---------------------------------------------------------------------------
// Main():
//---------------------------------------------------------------------------

Output Main(Input In)
{
    Output Out;
	// Function call #0
    BloomAptLuminance(Shader, Shader_Sampler, Base, Base_Sampler, In.UVSet0, 
        float(1.0 / 32.0), Out.Color);

    return Out;
}

