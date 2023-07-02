#!/usr/bin/bash
clademap() {
	java -Xmx4096m -cp /home/max/Downloads/beast-mcmc/build/dist/beast.jar dr.app.tools.TreeSummary -clademap $*
}
export -f clademap 
do_cmap() {
  warmup=0
  file=$1
  stem=$(basename $file .trees)
clademap -burninTrees $warmup $file cladematrix_$stem.cmap > cladetable_$stem.txt
}
export -f do_cmap
parallel --nice 1 --max-procs 200 do_cmap ::: *.trees
