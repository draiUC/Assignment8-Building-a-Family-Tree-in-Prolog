ASSIGNMENT 8: BUILDING A FAMILY TREE IN PROLOG

Files
  family_tree.pl       Facts, relationship rules, and example queries
  sample_queries.txt   Queries, expected results, and running instructions

Design notes
  grandparent/2 calls a recursive helper with depth fixed at two.
  descendant(D, A) means D is a descendant of A, excluding A itself.
  sibling/2 includes half-siblings; cousin/2 represents first cousins.
  Facts must form a finite, acyclic parent graph.
  List helpers require the person's name as input and remove duplicates.
