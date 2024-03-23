#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\BloomBrightness-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Base;
sampler Base_Sampler;
float g_BloomThreshold;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void BloomBrightness(sampler2D Texture,
    sampler Sampler,
    float2 TexCoord,
    float3 LumaTable,
    float BloomThreshold,
    out float4 Output)
{
#ifdef D3D10
    float3 TempColor = Texture.Sample (Sampler, TexCoord);
#else
    float3 TempColor = tex2D (Texture, TexCoord);
#endif
    float Mono = dot (TempColor, LumaTable);
    float Brightness = (Mono - BloomThreshold) / (1.0 - BloomThreshold);
    Output = float4 (TempColor * Brightness, 1.0);

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
    BloomBrightness(Base, Base_Sampler, In.UVSet0, 
        float3(0.212656, 0.715158, 0.072186), g_BloomThreshold, Out.Color);

    return Out;
}

