FROM daviddavo/ihaskell:latest

WORKDIR ihaskell

RUN stack install http-conduit Chart gtk2hs-buildtools cairo Chart-cairo
WORKDIR ihaskell-display/ihaskell-widgets/Examples
