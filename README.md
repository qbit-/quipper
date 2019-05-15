# quipper
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
Unofficial fork of [The Quipper Language](https://www.mathstat.dal.ca/~selinger/quipper/). This repository exists for the purpose to provide a 
reproducible installation and usage of the Quipper program for other projects. The version of Qipper is 0.8.

## Installation

Official Quipper is not actively maintained at the time of this
writing and may not work with recent third party libraries. It is
recommended to first try the specified Haskell/library versions, and
then experiment with up-to-date versions.
The present Quipper code requires set-monad-0.1.0.0
For original installation instructions see README.original.

### Haskell installation

Add the following to your PATH
```
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
```

Download Haskell updater
```
( mkdir -p ~/.ghcup/bin && curl https://raw.githubusercontent.com/haskell/ghcup/master/ghcup > ~/.ghcup/bin/ghcup && chmod +x ~/.ghcup/bin/ghcup) && echo "Success"
```

Install Haskell compiler and make it active
```
ghcup install 8.0.2
ghcup set 8.0.2
```
Install Haskell package system
```
ghcup install-cabal
```
Update Haskell package system and install environment
```
cabal update
cabal new-install cabal-install
```

### Quipper compilation

Install all prerequisites
```
cabal v1-install random-1.1
cabal v1-install mtl-2.2
cabal v1-install primes-0.2.1.0
cabal v1-install Lattices-0.0.3
cabal v1-install easyrender-0.1.1.4
cabal v1-install fixedprec-0.2.2.2
cabal v1-install newsynth-0.3.0.5
cabal v1-install set-monad-0.3.0.0
cabal v1-install QuickCheck-2.13.1 
```

Start compilation of Quipper and hope for best
```
cd /path/to/quipper-0.8
make
```

Export PATH to expose quipper executables
```
export PATH="$PATH:/path/to/quipper-0.8/quipper/scripts"
```

