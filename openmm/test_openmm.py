# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

##############################################################################
#### Links

## https://parmed.github.io/ParmEd/html/omm_gromacs.html
## http://docs.openmm.org/latest/userguide/application/02_running_sims.html#charmm36

##############################################################################



from openmm.app import *
from openmm import *
from openmm.unit import *
from sys import stdout
import modeller

pdb = PDBFile("/Users/brian/books/chem430/openmm/mll_menin_fixed.pdb")
#pdb.addMissingAtoms()
# http://docs.openmm.org/latest/userguide/application/02_running_sims.html#charmm36
forcefield = ForceField('charmm36.xml', 'charmm36/water.xml')
#forcefield = ForceField('amber14-all.xml', 'amber14/tip3pfb.xml')
modeller = Modeller(pdb.topology, pdb.positions)
#modeller.addMissingAtoms()

modeller.deleteWater()
system = forcefield.createSystem(pdb.topology, nonbondedMethod=PME,
                    nonbondedCutoff=1*nanometer, constraints=HBonds)

pdb2 = gromacsgrofile.GromacsGroFile("/Users/brian/books/chem430/gromacs_tutorials/lysozyme/1AKI_newbox.gro")
system = forcefield.createSystem(pdb2.topology, nonbondedMethod=PME,
                    nonbondedCutoff=1*nanometer, contraints=HBonds)
forcefield.createSystem()

pdb = PDBFile("/Users/brian/books/chem430/openmm/input.pdb")
forcefield = ForceField('amber14-all.xml', 'amber14/tip3pfb.xml')
system = forcefield.createSystem(pdb.topology, nonbondedMethod=PME,
        nonbondedCutoff=1*nanometer, constraints=HBonds)