for ff in amber oplsaa; do
   analyze $ff.arc $(echo D) -k $ff.key >& $ff.analyze.log
   ## using sum of phi and psi torsion potentials instead of plotting total potential of molecule
	paste <(ggrep -P "Torsion\\s+2-C\\s+7-N\\s+8-CT\\s+9-C" $ff.analyze.log | awk '{print $6,$7}') <(ggrep -P "Torsion\\s+7-N\\s+8-CT\\s+9-C\\s+17-N" $ff.analyze.log | awk '{print $6,$7}') > $ff.rama.coords.txt

   analyze $ff.arc_2 $(echo D) -k $ff.GBSA.key >& $ff.analyze.GBSA.log
   paste <(ggrep -P "Torsion\\s+2-C\\s+7-N\\s+8-CT\\s+9-C" $ff.analyze.GBSA.log | awk '{print $6,$7}') <(ggrep -P "Torsion\\s+7-N\\s+8-CT\\s+9-C\\s+17-N" $ff.analyze.GBSA.log | awk '{print $6,$7}') > $ff.GBSA.rama.coords.txt
done

# NH1 instead of N, CT1 instead of CT
for ff in charmm22cmap; do
   analyze $ff.arc $(echo D) -k $ff.key >& $ff.analyze.log
   ## using sum of phi and psi torsion potentials instead of plotting total potential of molecule
	paste <(ggrep -P "Torsion\\s+2-C\\s+7-NH1\\s+8-CT1\\s+9-C" $ff.analyze.log | awk '{print $6,$7}') <(ggrep -P "Torsion\\s+7-NH1\\s+8-CT1\\s+9-C\\s+17-NH1" $ff.analyze.log | awk '{print $6,$7}') > $ff.rama.coords.txt

   analyze $ff.arc_2 $(echo D) -k $ff.GBSA.key >& $ff.analyze.GBSA.log
   paste <(ggrep -P "Torsion\\s+2-C\\s+7-NH1\\s+8-CT1\\s+9-C" $ff.analyze.GBSA.log | awk '{print $6,$7}') <(ggrep -P "Torsion\\s+7-NH1\\s+8-CT1\\s+9-C\\s+17-NH1" $ff.analyze.GBSA.log | awk '{print $6,$7}') > $ff.GBSA.rama.coords.txt
done
