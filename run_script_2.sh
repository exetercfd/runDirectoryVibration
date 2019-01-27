# Run script for OpenFOAM 5.0

rm -rf log.*

# Renumber
renumberMesh -overwrite > log.renumberMesh 2>&1

# Check the mesh
checkMesh > log.checkMesh 2>&1

# Set fields
rm -rf 0/alpha.particles
cp 0/alpha.particles.orig 0/alpha.particles
setFields > log.setFields 2>&1
cp 0/alpha.particles 0/alpha.particlesMean

touch foam.foam

# Decompose
decomposePar > log.decomposePar 2>&1

# Run
nohup mpirun -np 6 twoPhaseEulerDenseFoam -parallel > log.twoPhaseEulerDenseFoam 2>&1 &
