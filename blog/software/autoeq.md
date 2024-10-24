# ==> [/](Blog) ==> Software ==> AutoEQ project

- (2023-08-01) Global optimiser is working significantly better than
  the greedy optimiser. Score computations have been ported to Cython
  for performance
- (2022-12-29) Automatic way to guess smoothness of curves
- (2022-05-26) Debug target again and try to decrease preamp changes.
- (2022-05-05) Corrected the rear reflections which are incorrect in the standard
- (2021-09-06) Added a second optimisation algorithm that gives better results :)
- (2021-04-10) Investigated how to find a target (or set of targets) that maximize the score. Use ray[tune] and random grid to find automatically optimum targets. That's different than for a given target, find the optimal EQ.
- (2021-01-30) Investigated why some speakers don't eq well. Not sure about the answer yet but mostly:
  - the target is critical and the system is not smart enough to guess it correctly each time.
  - zones where the crossovers or port resonance are generating large non linearity should be ignored.
- (2021-01-17) Build a script that compute all EQs :)
  - [Results](https://github.com/pierreaubert/spinorama/tree/develop/datas/eq) are in text files called iir-autoeq.txt (compatible with Equalizer APO).
  - The script around the algorithm has a fair number of knobs to play with.
- (2021-01-13) Found a working algorithm that generates EQ as good as made by hand :)
  - Greedy algorithm
  - Use simmulated annealing at each steps
  - Optimise for flat LW and smooth PIR
  - 2 min per speaker max on 1 core
  - 14 min for all eqs on all cores
  - Now things are easy :)
- (2021-01-09) Added local optimization with a gradient to see if I can get a better optimum.
  - answer is surprising and is NO.
  - I don't understand why yet.
- (2021-01-02) Optimised Listening Window with a series of PEQ. Tried various strategies:
  1. Greedy algorithm: start with the highest **peak** and optimised for this one. Iterate.
  2. Greedy algorithm: start with the highest **area** and optimised for this one. Iterate.
  3. Optimise for L2 norm or optimised for R**2 (from linear regression on LW)
  5. Same as above with a constraint on On Axis (need to stay flat)

