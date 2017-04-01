# number of processors to use in parallel, make sure no space after number! 
nproc = 4

# 0 folder variables 
Uinlet = 1
I = .05
Dh = .2

# build processor directories variable based on number of processors
nproc_0 = $(shell expr $(nproc) - 1)
pdirs = $(shell echo processor{0..$(nproc_0)})

# variables needed in 0 folder 
zvars = alphat epsilon k nut omega p p_rgh T U
zvars_noM4 = alphat nut omega p p_rgh T

.PHONY : all 
all : system/blockMeshDict 0/ $(addprefix 0/, $(zvars)) $(pdirs)

# make parallel directories 
$(pdirs) : system/decomposeParDict system/blockMeshDict.m4 
	decomposePar -force

# run blockMesh 
system/blockMeshDict : system/blockMeshDict.m4 
	m4 $< > $@
	blockMesh 

# make 0 folder 
0/ : 
	mkdir 0/ 

# generate velocity 
0/U : 0.orig/U.m4 
	m4 --define=Uinlet=$(Uinlet) 0.orig/U.m4 > 0/U 
	potentialFoam 
	rm 0/phi 

# generate k 
0/k : 0.orig/k.m4 
	m4 --define=I=$(I) --define=Uinlet=$(Uinlet) $< > $@ 

# generate epsilon 
0/epsilon : 0.orig/epsilon.m4 
	m4 --define=I=$(I) --define=Uinlet=$(Uinlet) --define=D=$(Dh) $< > $@

# non m4 variables, recopies all variables if one is changed 
$(addprefix 0/, $(zvars_noM4)) : $(addprefix 0.orig/, $(zvars_noM4))
	cp 0.orig/$(@F) $@

# remove files 
.PHONY : clean 
clean : 
	foamListTimes -rm 
	-rm -rf 0 
	-rm -rf constant/polyMesh
	-rm -f log* 
	-rm -rf postProcessing 
	-rm -rf processor*
	-rm -f system/blockMeshDict 
	-rm -f para.foam 