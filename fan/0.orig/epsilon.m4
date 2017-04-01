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
    object      epsilon;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

changecom(//)
changequote([,]) dnl>

define(calc, [esyscmd(perl -e 'use Math::Trig; print ($1)')]) dnl>
changequote()

define(k, calc(3/2 * (Uinlet*I)**2))

dimensions      [0 2 -3 0 0 0 0];

internalField       uniform calc(.09 * k**(3/2) / (.07 * D)); 

boundaryField
{
    defaultFaces
    {
        type empty; 
    }
    inlet 
    {
        type fixedValue; 
        value $internalField;  
    }

    outlet 
    {
        type zeroGradient; 
    }
    sg
    {
        type            epsilonWallFunction;
        value           $internalField;
    }
    shroud
    {
        type            epsilonWallFunction;
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
