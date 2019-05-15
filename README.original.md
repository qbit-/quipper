This file is part of Quipper. Copyright (C) 2011-2016. Please see the
file COPYRIGHT for a list of authors, copyright holders, licensing,
and other details. All rights reserved.

======================================================================

This is Quipper.

Copyright, License, and Disclaimers
===================================

See the file COPYRIGHT.

Installing the necessary components 
===================================

For installing on Linux, Mac OS X, and other Unix-like systems: please
first see the instructions in INSTALLING, then continue to read below.

For installing on Windows: please first see the instructions in
INSTALLING.windows, then continue to read below.

Configuring the software environment
=====================================

Before you can compile Quipper, you have to install some Haskell
libraries:

 * random >= 1.0.1.1
 * mtl >= 2.1.2
 * primes >= 0.2.1.0
 * Lattices >= 0.0.1 (note: "Lattices" must be capitalized)
 * zlib >= 0.5.4.1
 * easyrender >= 0.1.0.0
 * fixedprec >= 0.2.1.0
 * newsynth >= 0.3.0.1
 * containers >= 0.5.2.1
 * set-monad >= 0.1.0.0
 * QuickCheck >= 2.6

This can be done using Cabal. On the command line, use the
following commands:

cabal update

then:

cabal install random
cabal install mtl
cabal install primes
cabal install Lattices
cabal install zlib
cabal install easyrender
cabal install fixedprec
cabal install newsynth
cabal install containers
cabal install set-monad
cabal install QuickCheck

Note: When upgrading from a previous version of Quipper, please ensure
that the fixedprec library is version 0.2.1.0 or newer; Quipper 0.6
will not work with earlier versions of fixedprec. Also ensure that the
newsynth library has been compiled against the same version of
fixedprec as Quipper. If you get strange error messages related to
fixedprec, try

cabal install fixedprec 
cabal install newsynth --reinstall

You now have all the necessary Haskell libraries.

Special note for GHC 7.4.2:
===========================

The combination of GHC 7.4.2 and Template Haskell 2.8.0.0 is not
possible, because it triggers a GHC bug. If you get a compilation
error of the form: "ghc: panic! (the 'impossible' happened)", follow
these steps:

# Remove Template Haskell 2.8.0.0:

ghc-pkg unregister --force template-haskell-2.8.0.0

# Reinstall QuickCheck (because of a broken dependency). This will
# also install template-haskell-2.7.0.0:

cabal install QuickCheck

Special note for GHC 7.10.*:
============================

Quipper will not work with ghc 7.10. Please use ghc 7.8 or earlier, or
ghc 8.0 or later.

Browsing the documentation and source code
==========================================

While it is possible the browse the Quipper source code in a text
editor, it is much nicer to browse the documented source by pointing
your web browser to doc/frames.html in this Quipper distribution. The
documented source is fully cross-referenced and indexed, with links to
color-coded raw source files.


Building the documentation
==========================

Please note: our documentation uses special mark-up and requires
custom tools to be built. Therefore it is not currently possible for
users to re-build the documentation.


Building the included algorithms and programs
=============================================

Compilation, and execution of generated code, are done from the command
line interface.

The code can be built with "make" from the main directory.  This will
build an executable file in each Algorithm subdirectory, which can be
run with various command line parameters to do different things. Run
each command with option --help to see a summary of the usage
information.

In the following, we describe the set of options for the algorithms
that were implemented.


Running the bwt program
=======================

Usage for Binary Welded Tree algorithm:
---------------------------------------

Usage: bwt [OPTION...]
  -h             --help                 print usage info and exit
  -C             --circuit              output the whole circuit (default)
  -O             --oracle               output only the oracle
  -K             --oraclec              output the "classical" oracle as a classical circuit
  -G             --graph                print colored graph computed from oracle
  -S             --simulate             run simulations of some circuit fragments for tree height n
  -f <format>    --format=<format>      output format for circuits (default: preview)
  -g <gatebase>  --gatebase=<gatebase>  type of gates to decompose into (default: logical)
  -o <oracle>                           select oracle to use (default: orthodox)
  -n <n>         --height=<n>           set tree height (positive; default 5)
  -c <c>         --color=<c>            color to use with --oracle (0..3, default 0)
  -s <s>         --repeats=<s>          set parameter s (iteration count; default 1)
  -l             --large                set large problem size: n=300, s=336960
  -t <dt>        --dt=<dt>              set parameter dt (simulation time step; default pi/180)
Possible values for format are: eps, pdf, ps, postscript, ascii, preview, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.
Possible values for oracle are: orthodox, simple, blackbox, classical, template, optimized.

Examples of command line options:
---------------------------------

* Show the complete circuit for the BWT algorithm using the
  "orthodox" (official GFI) oracle, with n=5 and s=1:

  ./bwt -C -o orthodox -n 5 -s 1

  (One can point out the different parts of the algorithm: 8 oracle
  calls, and 4 very short diffusion steps).

* Show the same, using the "Template Haskell" oracle: this oracle is
  much larger, but automatically generated from classical code (and
  completely unoptimized):

  ./bwt -C -o template -n 5 -s 1

  The "template oracle" is defined in BWT/Template.hs. See the
  documentation of the module Quipper/CircLifting for how it works.

* Show the graph of the BWT algorithm, which is obtained by
  simulating the orthodox oracle (and therefore offers some evidence
  for the correctness of the oracle implementation):

  ./bwt -G -o orthodox -n 5

* Show the orthodox oracle for n=300. Note that this will result in a
  big file. One has to zoom in substantially to see gates. 

  ./bwt -O -o orthodox -n 300

* Show the complete circuit for the BWT algorithm, but decompose
  everything into binary gates:

  ./bwt -C -o orthodox -n 5 -s 1 -g binary 

* Show the oracle from Figure 1a (alternate oracle).

  ./bwt -C -o figure1a

* The same, decomposed into binary+Toffoli gates, or binary gates
  only, respectively:

  ./bwt -C -o figure1a -g toffoli
  ./bwt -C -o figure1a -g binary

* Show gate counts for BWT algorithm with n=300 and s=1, using
  "orthodox" oracle:

  ./bwt -C -o orthodox -n 300 -s 1 -f gatecount

* Show gate counts for same, after decomposition to binary gates:

  ./bwt -C -o orthodox -n 300 -s 1 -f gatecount -g binary 

Obviously, most other combinations of command line options are also
possible, for example: decompose to toffoli gates and then simulate
and show the graph. Some other combinations are not legal: for
example, decomposing to binary gates and then simulating. (The
classical simulator will complain that the circuit is not boolean; it
contains "V" gates).

* Similarly, one can run demos for the triangle finding
  algorithm using various command line options. 

Note that the triangle finding algorithm is not a deliverable; it is a
work in progress. The only implemented algorithm that is officially a
deliverable is the "orthodox" BWT implementation in BWT.BWT.

Running the bf program
======================

Usage for the Boolean Formula algorithm:
----------------------------------------

Usage: bf [OPTION...]
  -C             --circuit              output the whole circuit (default)
  -D             --demo                 run a demo of the circuit
  -H             --hexboard             output a representation of the initial state of the given oracle, i.e. the game played so far
  -p <part>      --part=<part>          which part of the circuit to use (default: whole)
  -o <oracle>    --oracle=<oracle>      which oracle to use (default: small)
  -m <moves>     --moves=<moves>        which moves have already been made (default: [])
  -f <format>    --format=<format>      output format for circuits (default: _preview)
  -d             --dummy                set to only use a dummy HEX gate instead of the full hex circuit
  -h             --help                 print usage info and exit
  -g <gatebase>  --gatebase=<gatebase>  type of gates to decompose the output circuit into (default: logical)
Possible values for part are: whole, u, oracle, hex, checkwin_red, diffuse, walk, undo_oracle.
Possible values for oracle are: 9by7, small, custom x y t.
Possible values for format are: eps, pdf, ps, postscript, ascii, preview, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.

Running the cl program
======================

Usage for the Class Number algorithm:
-------------------------------------

Usage: cl [OPTION...]
  -h               --help                 print usage info and exit
  -f <format>      --format=<format>      output format for circuits        (default: ASCII)
  -g <gatebase>    --gatebase=<gatebase>  gates to decompose into           (default: Logical)
  -1                                      output the circuit for stage 1 of the algorithm (default)
  -4                                      output the circuit for stage 4 of the algorithm
  -S <subroutine>  --sub=<subroutine>     output the circuit for a specific subroutine
  -R               --regulator            classically, find the regulator, given Δ
  -F                                      classically, find the fundamental unit, given Δ
  -P                                      classically, find the fundamental solution of Pell’s equation, given Δ
  -d <N>           --delta=<N>            discriminant Δ (a.k.a. D)                 (default: 28)
  -s <N>           --ss=<N>               estimated bound on period S, for stage 1 (default: 2)
  -i <N>                                  estimated bound on log_2 S, for stage 1 (default: 1)
  -r <N>           --rr=<N>               approximate regulator R, for stage 4  (default: 12.345)
  -q <N>                                  The parameter q, for stage 4        (default: 4)
  -k <N>                                  The parameter k, for stage 4        (default: 3)
  -n <N>                                  The parameter n, for stage 4        (default: 3)
  -m <N>                                  The parameter m, for stage 4        (default: 5)
                   --seed=<N>             Random seed (0 for seed from time)(default: 1)
Possible values for format are: eps, pdf, ps, postscript, ascii, preview, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.
Possible values for subroutine are: rho, rhoinv, normalize, dotprod, starprod, fn.

Running the gse program
=======================

Usage for Ground State Estimation algorithm:
--------------------------------------------

Usage: gse [OPTION...]
  -h             --help                 print usage info and exit
  -C             --circuit              output the whole circuit (default)
  -T <indices>   --template=<indices>   output a particular circuit template
  -f <format>    --format=<format>      output format for circuits (default: Preview)
  -g <gatebase>  --gatebase=<gatebase>  gates to decompose into (default: Logical)
  -m <N>         --orbitals=<N>         number of orbitals (default: 4)
  -o <N>         --occupied=<N>         number of occupied orbitals (default: 2)
  -b <N>         --precision=<N>        number of precision qubits (default: 3)
  -D <energy>    --delta_e=<energy>     energy range (default: 6.5536)
  -E <energy>    --e_max=<energy>       maximum energy (default: -3876.941)
                 --n0=<N>               use N_k = n0 * 2^k (default: N_k = 1)
  -l             --large                set large problem size (m=208, o=84, b=12, n0=100)
  -x             --orthodox             use the Coulomb operator of Whitman et al.
                 --h1=<file>            filename for one-electron data (default: "h_1e_ascii")
                 --h2=<file>            filename for two-electron data (default: "h_2e_ascii")
  -d <file>      --datadir=<file>       directory for one- and two-electron data (default: current)
Possible values for format are: eps, pdf, ps, postscript, ascii, preview, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.
Indices can be specified as p,q or p,q,r,s (with no spaces)

Running the qls program
=======================

Usage for Quantum Linear Systems algorithm:
-------------------------------------------

Usage: qls [OPTION...]
  -h             --help                 print usage info and exit
  -C             --circuit              output the whole circuit (default)
  -O <name>      --oracle=<name>        output only the oracle <name> (default: r) 
  -f <format>    --format=<format>      output format for circuits (default: gatecount)
  -g <gatebase>  --gatebase=<gatebase>  type of gates to decompose into (default: logical)
  -o <oracle>                           select oracle implementation to use (default: blackbox)
  -p <param>     --param=<param>        choose a set of parameters (default: dummy).
  -P <n>         --peel=<n>             peel <n> layers of boxed subroutines (default: 0).
Possible values for format are: ascii, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.
Possible values for oracle implementation are: matlab, blackbox.
Possible values for param are: dummy, small, large.
Possible values for oracle are: r, b, A[band][t|f]. E.g. "-OA1t" asks for band 1 with boolean argument True. For all three oracles, the factors are set up to 1.0.

Running the tf program
======================

Usage for Triangle Finding algorithm:
-------------------------------------

Usage: tf [OPTION...]
  -h               --help                     print usage info and exit
  -f <format>      --format=<format>          output format for circuits (default: preview)
  -g <gatebase>    --gatebase=<gatebase>      type of gates to decompose into (default: logical)
  -l <l>           --l=<l>                    parameter l (default: 4)
  -n <n>           --n=<n>                    parameter n (default: 3)
  -r <r>           --r=<r>                    parameter r (default: 2)
  -C               --QWTFP                    output the whole circuit (default)
  -O               --oracle                   output only the oracle
  -s <subroutine>  --subroutine=<subroutine>  output the chosen subroutine (default: adder)
  -Q                                          use alternative qRAM implementation
  -o <oracle>                                 select oracle to use (default: blackbox)
  -A               --arith                    test/simulate the arithmetic routines
  -T               --oracletest               test/simulate the oracle
Possible values for format are: eps, pdf, ps, postscript, ascii, preview, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.
Possible values for oracle are: orthodox, blackbox.
Possible values for subroutine are: zero, initialize, hadamard, setup, qwsh, diffuse, fetcht, storet, fetchstoret, fetche, fetchstoree, update, swap, a15, a16, a17, a18, gcqwalk, gcqwstep, convertnode, testequal, pow17, mod3, sub, add, mult.

Running the usv program
=======================

Usage for Unique Shortest Vector algorithm:
-------------------------------------------

Usage: usv [OPTION...]
  -h             --help                 print usage info and exit
  -f <format>    --format=<format>      output format for circuits (default: eps)
  -g <gatebase>  --gatebase=<gatebase>  type of gates to decompose into (default: logical)
  -n <n>         --n=<n>                parameter n (default: 5)
  -b <b>         --b=<b>                parameter b (default: 5X5 with entries = 1)
  -s <s>         --s=<s>                Random number generator seed s (default: 1)
  -F                                    output subroutine f (depends on b).
  -G                                    output subroutine g (depends on b).
  -H                                    output subroutine h (depends on n).
  -U                                    output algorithm 1 (depends on b).
  -Q                                    output algorithm 2 (depends on b).
  -R                                    output algorithm 3 (depends on b).
  -T                                    output algorithm 4 (depends on n).
  -S                                    output sieving subroutine (depends on n).
  -D                                    output algorithm 5 (depends on n).
  -t                                    test subroutine h (depends on n).
Possible values for format are: eps, pdf, ps, postscript, ascii, preview, gatecount.
Possible values for gatebase are: logical, binary, toffoli, cliffordt_old, cliffordt, cliffordt_keepphase, standard, strict, approximate, approximate_keepphase, exact, trimcontrols.


Invoking the Quipper compiler
=============================

The Quipper compiler is called "quipper", and is located in the
directory quipper/scripts. The easiest way to use it is to add the
"scripts" directory to the environment variable PATH. If you move the
quipper script around, make sure to keep the other scripts in the same
directory as the quipper script, and to update QUIPPER_BASE in the
"quipper" and "quipperi" scripts to point to the directory where the
Quipper sources are located. On the Windows operating system, you
should use "quipper.bat"; on all other operating systems, just
"quipper" will do. 

In reality, the "quipper" script is a wrapper around the GHC Haskell
compiler, providing some pre-processing and setting required
compilation options. There is also a "quipperi" script for an
interactive version of the compiler, which is akin to "ghci".

To try this out, the directory "tests" contains various small
stand-alone programs that can be compiled with Quipper, and are useful
for demonstrating the basic Quipper idiom. Each program can be
compiled and run like this:

For example:

# to compile and run on Unix (or on Unix with the MSYS/bash):
quipper And_gate.hs
./And_gate

# to compile and run on Windows with cmd.exe:
quipper.bat And_gate.hs
And_gate

Note that there is also a Makefile, so "make" can be used to build the
programs as well.

If the previewer is working properly, the circuit should show up in
Acrobat Reader. If not, either change "Preview" to "EPS" in the file
(for PostScript output), or trouble-shoot the previewer installation
(if you are on Windows, see INSTALLING) and/or contact Benoit Valiron
<benoit.valiron@monoidal.net> or Peter Selinger
<selinger@mathstat.dal.ca> for help.

The naming of built-in gates and many operators can be found out by
looking at the documentation of the "Quipper" module (the main public
interface of the Quipper system).


Troubleshooting Guidelines
==========================

In case of problems, please contact

 * Benoit Valiron <benoit.valiron@monoidal.net>
 * Peter Selinger <selinger@mathstat.dal.ca>
