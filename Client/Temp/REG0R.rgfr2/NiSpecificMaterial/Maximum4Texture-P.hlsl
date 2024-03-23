#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\Maximum4Texture-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Base;
sampler Base_Sampler;
float4x4 g_Proj;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void Maximum4Texture(sampler2D Texture,
    sampler Sampler,
    float2 TexCoord,
    float4x4 Projection,
    out float4 Output)
{
    float Width = Projection [3][0] * 0.5;
    float Height = Projection [3][1] * 0.5;
#ifdef D3D10
    Output = Texture.Sample (Sampler, TexCoord + float2 (-Width,  Height));
    Output = max (Texture.Sample (Sampler, TexCoord + float2 (-Width, -Height)), Output);
    Output = max (Texture.Sample (Sampler, TexCoord + float2 ( Width, -Height)), Output);
    Output = max (Texture.Sample (Sampler, TexCoord + float2 ( Width,  Height)), Output);
#else
    Output = tex2D (Texture, TexCoord + float2 (-Width,  Height));
    Output = max (tex2D (Texture, TexCoord + float2 (-Width, -Height)), Output);
    Output = max (tex2D (Texture, TexCoord + float2 ( Width, -Height)), Output);
    Output = max (tex2D (Texture, TexCoord + float2 ( Width,  Height)), Output);
#endif

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
    Maximum4Texture(Base, Base_Sampler, In.UVSet0, g_Proj, Out.Color);

    return Out;
}

