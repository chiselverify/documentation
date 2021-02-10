# Verification of Digital Desing with Chisel
### Integrating Constraint Random Verification in Chisel
-------

- Thesis author: Enrico Tolotto
- Thesis supervisor: Martin Schoeberl

## Abstract

In recent years, the slow down of Moore's Law and the end of Dennard Scaling,
forced the chip industry to reduce reliance on the scaling of silicon-based
technologies and focus more on incorporating hardware accelerators into their
design to increase the hardware energy efficiency. Simultaneously, the time to
market for new hardware decreases each year, pressuring companies to adapt to
this fast delivery pace by moving away from a strict waterfall developing model
to more fluid, agile methodologies. To allow this shift in methodology, new
Hardware Description Languages (HDL) were developed. These HDLs enable designers
and architects to rapidly explore alternative system microarchitectures by
quickly wiring up different hardware accelerators together.

Even though the design process received a boost in productivity by using new
HDL, the manufacturing cycle continues to be hampered by the verification
process bottleneck. Most new HDLs lack a reliable verification environment which
forces verification engineers to use legacy tools, slowing down the overall
development process. For the verification of hardware models, Constrained Random
Verification (CRV) plays a significant role. CRV allows verification engineers
to automatically generate a set of random stimuli limited by a group of
constraints. Therefore, such stimuli are more likely to trigger device behavior
not envisioned by the verification engineer.

 This thesis presents Chisel-CRV, a constrained random verification environment
 for Chisel, a newly born hardware description language. At the time of writing
 this thesis, there is no such feature for Chisel. This project was developed in
 coordination with a DTU research project, resulting in "chiselverify," a novel
 verification framework for Chisel. The framework aims to lower the barrier
 between the design and the functional verification process by providing a set
 of tools and utilities inspired by traditional verification tools like UVM and
 SystemVerilog.

## Content

This document presents the following structure:
- **Chpater 1** : general introduciton.
- **Chapter 2** : provides some background regarding hardware
  description languages, from the traditional to the newer ones. Morover, it
  gives a general look at the technology that are currently used for hardware
  verification.
- **Chapter 3** : introduces the concept of
  functional verification and it compares this new type of verification with the
  traditional methodology.
- **Chapter 4** : takes a closer look at one of the
  branches of functional verification called Constrained Random Verification. In
  this chapter, the theory behind CRV and Constraint Satisfaction Problems is
  introduced together with standard solution algorithms to solve these problems.
- **Chpater 5** : presents F-CSP, a completely new library entirely
  developed in Scala that integrated Constraint Random Verification into Chisel
  but was then abandoned because of its lousy performance and low
  maintainability.
- **Chpater 6** : presents Chisel-CRV, a new library for
  Constraint Random Verification, born after F-CSP and based on the JaCoP Java
  library for constraint programming.
- **Chpater 7** : combines the technique described in
  chapters 5 and 6 and the Chisel-CRV library together with the chiselverify one
  to functionally verify the Leros ALU.
- **Chapter 8** : conclusion.

# License

All the content in `chapters`, `pictures` is distributed under the [Unlicense](https://unlicense.org/)
license.

While the latex template was copied and modified from
[Laursen's XeLaTeX thesis template](https://bitbucket.org/_laursen/laursens-xelatex-thesis-template/).
