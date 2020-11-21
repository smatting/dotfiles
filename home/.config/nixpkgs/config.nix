{
    oraclejdk.accept_license = false;
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
            # rethinkdb
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
            netifaces
            # oauth2
            pglast
            google-auth-httplib2
            google-auth-oauthlib
            python-socketio
            flask
            flask-socketio
            graphene
            sqlalchemy
            cssselect
            reportlab
            altair
            dbus
            pygobject2
            snakeviz
            # etaprogress
       ]);

     myHaskellEnv = haskellPackages.ghcWithPackages
         (haskellPackages: with haskellPackages; [
           mtl
           base
           containers
           diagrams


           arrows
           async
           criterion
           turtle


           # Cabal
           # array
           # bytestring
           # containers
           # deepseq
           # directory
           # filepath
           # hpc
           # pretty
           # process
           # template-haskell
           # time
           # transformers
           # xhtml
           # binary
           # ghc-prim
           # haskeline
           # hoopl
           # integer-gmp
           # terminfo
           # alex
           # happy
           # hscolour
           # cabal-install
           # async
           # attoparsec
           # case-insensitive
           # fgl
           # GLUT
           # GLURaw
           # haskell-src
           # hashable
           # html
           # HTTP
           # HUnit
           # network
           # OpenGL
           # OpenGLRaw
           # parallel
           # parsec
           # regex-base
           # regex-compat
           # regex-posix
           # split
           # stm
           # syb
           # text
           # unordered-containers
           # vector
           # zlib
           # mtl
           # primitive
           # random
           # QuickCheck
           # tf-random
           # network-uri
           # scientific
           # integer-logarithms
           # ObjectName
           # StateVar
           # half
           # fixed
           # call-stack

           # hpack
           # megaparsec
           # regex-pcre
           # blaze-html
           # req
           # # req-oauth2
           # # oauthenticated
           # hakyll
           # ghcid
           # bloodhound

           # graphmod


         ]);

                   # myIHaskell = haskell.packages.ghc822.ihaskell.override {
                   #   packages = haskellPackages: with haskellPackages; [lens];
                   # };
      };
}
