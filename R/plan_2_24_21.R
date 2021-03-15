plan2 <- plan <- drake_plan(
  tree = read.tree("data/R_fragrantissima.tre"),
  str(tree),
  discrete.data = read.nexus.data("data/R_fragrantissima_align.nex"), #death to factors
  discrete.data2 = read.phyDat("data/R_fragrantissima_align.nex", format = "nexus", type = "DNA"),
  discrete.data.fram = as.data.frame(t(discrete.data)),
  tree_resolution = (ape::Nnode(tree)/(Ntip(tree) - 1)),
  tree_print = plot_tree(tree, file=file_out("results/R_fragrantissima.pdf")),
  mytree = ape::plot.phylo(tree, type="fan", cex=0.2),
  tree_info = print(paste("The tree has ", ape::Ntip(tree), " terminals and ",
                          Nnode(tree), " internal nodes out of ",ape::Ntip(tree)-2,
                          " possible, which means it is ",
                          round(100*(ape::Nnode(tree)-1)/(ape::Ntip(tree)-3), 2),
                          "% resolved", sep="")),
  Species.names = c(tree$tip.label),
  Location = c('British Columbia','Tennessee','North Carolina','North Carolina','Washington','China','China','Idaho','Italy','Denmark','Finland','Germany','Germany','Italy','Scotland','Scotland','New York','Tennessee','Florida','Italy','Sweden','Germany','Sweden','China','Sweden','Tennessee','Sweden'),
  discrete.data3 = data.frame(Species.names,Location),
  cleaning = CleanData(tree, discrete.data3),
  visulizing = VisualizeData(tree),
  cleaned.discrete.phyDat = phangorn::as.phyDat(discrete.data2), #phyDat is a data format used by phangorn
  anc.p = phangorn::ancestral.pars(tree, cleaned.discrete.phyDat),
  plotAnc(tree, anc.p, 1),
  corHMM(tree, discrete.data3, rate.cat = 1, fixed.nodes=TRUE), #hidden rates model
  )