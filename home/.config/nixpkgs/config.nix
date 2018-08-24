{
    allowUnfree = true; 
    packageOverrides = pkgs: with pkgs; {
       myPythonEnv = python36.withPackages (ps: with ps; [
            pylint
            numpy
            scipy
            ipython
            docopt
            psycopg2
            pytest
            Theano
            regex
            colorama
            pyzmq
            redis
            flask
            gunicorn
            pytz
            python-dateutil
            rethinkdb
            celery
            mypy
       ]);

       myHaskellEnv = haskell.packages.ghc822.ghcWithHoogle
                     (haskellPackages: with haskellPackages; [
                       mtl
                       containers
                       diagrams

                       arrows
                       haskintex
#                       haddock
#                       stack

                       async
                       criterion

                       cabal-install
                       alex
                       happy
                       shake

                       Cabal
                       array
                       base
                       bytestring
                       containers
                       deepseq
                       directory
                       filepath
                       hpc
                       pretty
                       process
                       template-haskell
                       time
                       transformers
                       xhtml
                       binary
                       ghc-prim
                       haskeline
                       hoopl
                       integer-gmp
                       terminfo
                       alex
                       happy
                       hscolour
                       cabal-install
                       async
                       attoparsec
                       case-insensitive
                       fgl
                       GLUT
                       GLURaw
                       haskell-src
                       hashable
                       html
                       HTTP
                       HUnit
                       network
                       OpenGL
                       OpenGLRaw
                       parallel
                       parsec
                       regex-base
                       regex-compat
                       regex-posix
                       split
                       stm
                       syb
                       text
                       unordered-containers
                       vector
                       zlib
                       mtl
                       primitive
                       random
                       QuickCheck
                       tf-random
                       network-uri
                       scientific
                       integer-logarithms
                       ObjectName
                       StateVar
                       half
                       fixed
                       call-stack

                     ]);
    };
}