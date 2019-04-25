{
    allowUnfree = true; 
    allowBroken = true;
    packageOverrides = pkgs: with pkgs; {
       myPythonEnv = python37.withPackages (ps: with ps; [
            pylint
            numpy
            scipy
            ipython
            docopt
            psycopg2
            pytest
            # Theano
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
            pandas
            flake8
            ipdb
            pillow
            imageio
            scikitimage
            jupyter
            pyaml
            plumbum
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

                       hpack
                       megaparsec
                       regex-pcre
                       blaze-html
                       req
                       # req-oauth2
                       # oauthenticated
                       hakyll
                       ghcid
                       bloodhound

                       graphmod


                     ]);

                     myIHaskell = pkgs.ihaskell.override {
                       ghcWithPackages = haskell.packages.ghc822.ghcWithPackages;
                       packages = haskellPackages: with haskellPackages; [
                       mtl
                       containers
                       diagrams
                       arrows
                       async
                       cabal-install
                       shake
                       array
                       base
                       bytestring
                       containers
                       deepseq
                       directory
                       filepath
                       pretty
                       process
                       time
                       transformers

                       attoparsec
                       HTTP
                       network
                       parallel
                       regex-base
                       regex-compat
                       regex-posix
                       split
                       stm

                       text
                       unordered-containers
                       vector
                       random

                       scientific
                       integer-logarithms
                       hpack
                       megaparsec
                       regex-pcre
                       blaze-html
                       req
                       wreq
                       http-conduit
                       ihaskell-charts
                       Chart
                       diagrams
                       Chart-diagrams

                       bloodhound
                       
                       ];
                     };
                     # myIHaskell = haskell.packages.ghc822.ihaskell.override {
                     #   packages = haskellPackages: with haskellPackages; [lens];
                     # };
      };
}
