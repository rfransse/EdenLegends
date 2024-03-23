#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\BloomMaxLuminance-P.hlsl"
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
sampler2D Shader1;
sampler Shader1_Sampler;
float g_BloomThreshold;
float g_BloomRatio;
float g_BloomExposure;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void BloomMaxLuminance(sampler2D Texture,
    sampler Sampler,
    float2 TexCoord,
    sampler2D BlurTexture,
    sampler BlurSampler,
    sampler2D LumaTexture,
    sampler LumaSampler,
    float Threshold,
    float Ratio,
    float Exposure,
    out float4 Output)
{
#ifdef D3D10
    float3 BaseColor = Texture.Sample (Sampler, TexCoord);
    float3 BlurColor = BlurTexture.Sample (BlurSampler, TexCoord);
    float MaxLuma = LumaTexture.Sample (LumaSampler, TexCoord).g;
#else
    float3 BaseColor = tex2D (Texture, TexCoord);
    float3 BlurColor = tex2D (BlurTexture, TexCoord);
    float MaxLuma = tex2D (LumaTexture, TexCoord).g;
#endif
    float3 Tone = BaseColor + BlurColor * Ratio;
    MaxLuma = MaxLuma * (1.0 + Ratio * (1.0 - Threshold));
    Output = float4 (Tone * Exposure * (Exposure / MaxLuma + 1.0) / (Exposure + 1.0), 1.0);

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
    BloomMaxLuminance(Base, Base_Sampler, In.UVSet0, Shader, Shader_Sampler, 
        Shader1, Shader1_Sampler, g_BloomThreshold, g_BloomRatio, 
        g_BloomExposure, Out.Color);

    return Out;
}

