{
    allowUnfree = true;

    packageOverrides = pkgs: with pkgs; {
        myEnv = python36.withPackages (ps: with ps; [
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
            # json-rpc
            gunicorn
            pytz
            python-dateutil
            rethinkdb
            celery
        ]);
    };
}
