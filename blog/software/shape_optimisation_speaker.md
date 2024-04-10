# Shape Optimisation project (for speakers)

I used to to some shape optimisation long time ago for my PhD. This [post](https://www.audiosciencereview.com/forum/index.php?threads/simulation-overview-loudspeakers-design-via-shape-and-topology-optimization.23453/) motivated me to go back to it.

Comsol or Mathematica are too expensive for my taste esp. with a lot of cores. I decided to leverage awesome open source softwares and write an open source project to optimise horns to start with.

- (2021-07-23) More reading: how to precondition Helmhotz? also read about other optimisation (matric reduction and parametrisation)
- (2021-07-22) More reading: read the fireshape documentation and code, also had a peak at ROM.
- (2021-07-20) Same code is working in parallel. 2D is super fast on a core i9 9900K and 3D is slow but doable. Memory and memory bandwidth are an issue. It also works well on Threadripper pro, memory issues are gone.
- (2021-07-20) Did a lot of reading.
  - Code is now working to solve the state problem (Helmhotz) in 2D. I used features from my other project to generate spinorama and contour plots.
- (2021-06-05) That's me trying to remember things from the past.
  - Code is [here](https://github.com/pierreaubert/sh-op-horn).
  - I am following the tutorial from Mathematica but I implement it in Python with open source solutions (gmsh and firedrake).
  - Here is the mesh for a half horn (due to the symmetry the problem is computed in 2D and only half of it).
  - If I can solve it properly I will of course go 3D.

