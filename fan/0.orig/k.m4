/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  4.x                                   |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       volScalarField;
    location    "0";
    object      k;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

changecom(//)
changequote([,]) dnl>

define(calc, [esyscmd(perl -e 'use Math::Trig; print ($1)')]) dnl>
changequote()

dimensions      [0 2 -2 0 0 0 0];

internalField      uniform calc(3/2*Uinlet**2*I**2); 

boundaryField
{
    defaultFaces
    {
        type empty; 
    }
    outlet 
    {
        type zeroGradient; 
    }

    inlet
    {
        type fixedValue; 
        value $internalField; 
    }
    sg
    {
        type            kqRWallFunction;
        value           $internalField;
    }
    shroud
    {
        type            kqRWallFunction;
        value           $internalField;
    }
    leftWedge
    {
        type wedge; 
    }

    rightWedge
    {
        type wedge; 
    }
}


// ************************************************************************* //
