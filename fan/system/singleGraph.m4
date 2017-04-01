/*--------------------------------*- C++ -*----------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Web:      www.OpenFOAM.org
     \\/     M anipulation  |
-------------------------------------------------------------------------------
Description
    Writes graph data for specified fields along a line, specified by start
    and end points.

\*---------------------------------------------------------------------------*/
changecom(//)changequote([,]) dnl>
define(calc, [esyscmd(perl -e 'use Math::Trig; print ($1)')]) dnl>

define(R, .2) 
define(theta, calc(deg2rad(3)))
define(H, 10)

start   (calc(R*sin(theta/2)) calc(R*cos(theta/2)) 0);
end     (calc(R*sin(theta/2)) calc(R*cos(theta/2)) H);
fields  (wallHeatFlux);

interpolationScheme cellPoint;

setFormat   raw;

setConfig
{
    // type    uniform;   // midPoint, midPointAndFace
    type midPoint; 
    axis    z;  // x, y, z, xyz
    // nPoints 100;
}

// Must be last entry
#includeEtc "caseDicts/postProcessing/graphs/graph.cfg"

// ************************************************************************* //
