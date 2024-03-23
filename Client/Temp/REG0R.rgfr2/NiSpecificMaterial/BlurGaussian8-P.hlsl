#line 2 "D:\EdenClients\DepotContainer\EdenWorking-\Client\Temp\REG0R.rgfr2\NiSpecificMaterial\BlurGaussian8-P.hlsl"
#ifdef D3D10
#undef D3D10
#endif
//---------------------------------------------------------------------------
// Constant variables:
//---------------------------------------------------------------------------

sampler2D Base;
sampler Base_Sampler;
//---------------------------------------------------------------------------
// Functions:
//---------------------------------------------------------------------------

/*

*/

void BlurGaussian8PS(sampler2D Texture,
    sampler Sampler,
    float4 TexCoord0,
    float4 TexCoord1,
    float4 TexCoord2,
    float4 TexCoord3,
    out float4 Output)
{
#ifdef D3D10
    Output = Texture.Sample (Sampler, TexCoord0.xy) * (1.0 / 3.75);
    Output += Texture.Sample (Sampler, TexCoord0.wz) * (1.0 / 3.75);
    Output += Texture.Sample (Sampler, TexCoord1.xy) * (1.0 / 7.5);
    Output += Texture.Sample (Sampler, TexCoord1.wz) * (1.0 / 7.5);
    Output += Texture.Sample (Sampler, TexCoord2.xy) * (1.0 / 15.0);
    Output += Texture.Sample (Sampler, TexCoord2.wz) * (1.0 / 15.0);
    Output += Texture.Sample (Sampler, TexCoord3.xy) * (1.0 / 30.0);
    Output += Texture.Sample (Sampler, TexCoord3.wz) * (1.0 / 30.0);
#else
    Output = tex2D (Texture, TexCoord0.xy) * (1.0 / 3.75);
    Output += tex2D (Texture, TexCoord0.wz) * (1.0 / 3.75);
    Output += tex2D (Texture, TexCoord1.xy) * (1.0 / 7.5);
    Output += tex2D (Texture, TexCoord1.wz) * (1.0 / 7.5);
    Output += tex2D (Texture, TexCoord2.xy) * (1.0 / 15.0);
    Output += tex2D (Texture, TexCoord2.wz) * (1.0 / 15.0);
    Output += tex2D (Texture, TexCoord3.xy) * (1.0 / 30.0);
    Output += tex2D (Texture, TexCoord3.wz) * (1.0 / 30.0);
#endif

}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Input:
//---------------------------------------------------------------------------

struct Input
{
    float4 PosProjected : POSITION0;
    float4 UVSet0 : TEXCOORD0;
    float4 UVSet1 : TEXCOORD1;
    float4 UVSet2 : TEXCOORD2;
    float4 UVSet3 : TEXCOORD3;

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
    BlurGaussian8PS(Base, Base_Sampler, In.UVSet0, In.UVSet1, In.UVSet2, 
        In.UVSet3, Out.Color);

    return Out;
}

