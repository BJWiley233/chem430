mkdir in # protein inputs
mkdir seq; mkdir int; # folders for .int and .seq files
mkdir proteins # initial dipeptide xyz files
mkdir energy_logs # confirm intial torsion angles
mkdir minimized # minimized structures hold torsions as close to original as possible
mkdir minimized_logs # energy logs to get final potentials


# create proteins analyze proteins
## need to start with under -180 since this will actaully make torsion angle of 180 as they are the "same"
## and even if really close to -180 like -179.99 can still go to 180 in the minimimzation
# phi_ang=-179.0
# psi_ang=-179.0
for phi_ang in $(seq -179.0 14.90 179.0); do
   for psi_ang in $(seq -179.0 14.90 179.0); do
      printf "charmm22cmap
\"charmm22cmap.GBSA ${phi_ang}_${psi_ang} command line\"
ace
ala ${phi_ang} ${psi_ang}
nme

N" > in/phi_${phi_ang}_psi_${psi_ang}.in
      protein < in/phi_${phi_ang}_psi_${psi_ang}.in && mv charmm22cmap.xyz proteins/phi_${phi_ang}_psi_${psi_ang}.xyz
      mv charmm22cmap.seq seq/phi_${phi_ang}_psi_${psi_ang}.seq
      mv charmm22cmap.int int/phi_${phi_ang}_psi_${psi_ang}.int
   done
done

# analyze initial proteins 
for phi_ang in $(seq -179.0 14.90 179.0); do
   for psi_ang in $(seq -179.0 14.90 179.0); do
      analyze proteins/phi_${phi_ang}_psi_${psi_ang}.xyz D -k charmm22cmap.key > energy_logs/phi_${phi_ang}_psi_${psi_ang}.log
   done
done

# check and confirm current dihedrals
for phi_ang in $(seq -179.0 14.90 179.0); do
   for psi_ang in $(seq -179.0 14.90 179.0); do
      _phi_ang=$(ggrep -P "Torsion\\s+2-C\\s+7-NH1\\s+8-CT1\\s+9-C" energy_logs/phi_${phi_ang}_psi_${psi_ang}.log | awk '{print $6}')
      _psi_ang=$(ggrep -P "Torsion\\s+7-NH1\\s+8-CT1\\s+9-C\\s+17-NH1" energy_logs/phi_${phi_ang}_psi_${psi_ang}.log | awk '{print $6}')
      energy=$(grep "Total Potential Energy" energy_logs/phi_${phi_ang}_psi_${psi_ang}.log | awk '{print $5}')
      printf "${_phi_ang} ${_psi_ang} $energy\n"
   done
done > current.dihedrals.txt


## minimize with "constrained" torsions
for phi_ang in $(seq -179.0 14.90 179.0); do
   for psi_ang in $(seq -179.0 14.90 179.0); do
      gsed "s/phi/${phi_ang}/" charmm22cmap.dummy.key > minimized/phi_${phi_ang}_psi_${psi_ang}.key; 
      gsed -i "s/psi/${psi_ang}/g" minimized/phi_${phi_ang}_psi_${psi_ang}.key; 
      minimize -k minimized/phi_${phi_ang}_psi_${psi_ang}.key proteins/phi_${phi_ang}_psi_${psi_ang}.xyz 0.01
      mv proteins/phi_${phi_ang}_psi_${psi_ang}.xyz_2 minimized 
      analyze minimized/phi_${phi_ang}_psi_${psi_ang}.xyz_2 D -k charmm22cmap.key > minimized_log/phi_${phi_ang}_psi_${psi_ang}.min.log
      old_phi_ang=$(ggrep -P "Torsion\\s+2-C\\s+7-NH1\\s+8-CT1\\s+9-C" energy_logs/phi_${phi_ang}_psi_${psi_ang}.log | awk '{print $6}')
      new_phi_ang=$(ggrep -P "Torsion\\s+2-C\\s+7-NH1\\s+8-CT1\\s+9-C" minimized_log/phi_${phi_ang}_psi_${psi_ang}.min.log | awk '{print $6}')
      old_psi_ang=$(ggrep -P "Torsion\\s+7-NH1\\s+8-CT1\\s+9-C\\s+17-NH1" energy_logs/phi_${phi_ang}_psi_${psi_ang}.log | awk '{print $6}')
      new_psi_ang=$(ggrep -P "Torsion\\s+7-NH1\\s+8-CT1\\s+9-C\\s+17-NH1" minimized_log/phi_${phi_ang}_psi_${psi_ang}.min.log | awk '{print $6}')
      printf "old_phi: ${old_phi_ang}, new_phi: ${new_phi_ang}, old_phi: ${old_psi_ang}, new_phi: ${new_psi_ang}\n"
done
done > results.txt
## make sure torsions haven't changed much
ggrep old_phi results.txt

# dihedrals of minimized structures and energy for map
for phi_ang in $(seq -179.0 14.90 179.0); do
   for psi_ang in $(seq -179.0 14.90 179.0); do
      new_phi_ang=$(ggrep -P "Torsion\\s+2-C\\s+7-NH1\\s+8-CT1\\s+9-C" minimized_log/phi_${phi_ang}_psi_${psi_ang}.min.log | awk '{print $6}')
      new_psi_ang=$(ggrep -P "Torsion\\s+7-NH1\\s+8-CT1\\s+9-C\\s+17-NH1" minimized_log/phi_${phi_ang}_psi_${psi_ang}.min.log | awk '{print $6}')
      energy=$(grep "Total Potential Energy" minimized_log/phi_${phi_ang}_psi_${psi_ang}.min.log | awk '{print $5}')
      printf "${new_phi_ang} ${new_psi_ang} $energy\n"
   done
   echo
done > updated.dihedrals.txt

# set thresold for max potential energy allowed
awk '{
if ($3 >= -18)
	$3=-18;
print $0}' updated.dihedrals.txt > minimized.dihedrals.txt
gnuplot torsion.gnu

