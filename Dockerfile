FROM ocaml/opam AS base

RUN sudo apt-get install -y libsqlite3-dev pkgconf libgmp-dev

WORKDIR /home/opam/build

COPY caqti_loading.opam /home/opam/build
RUN opam install --deps-only -y .

COPY . /home/opam/build
RUN opam exec -- dune build --profile=release @install

ENV OCAMLRUNPARAM=b
ENV DB_URL=sqlite3:/tmp/db
RUN "/home/opam/build/_build/default/src/main.exe"

RUN opam exec -- dune install --prefix=/home/opam/export


FROM debian
RUN apt-get update && apt-get install -y libsqlite3-dev
COPY --from=base /home/opam/export /mnt/project
ENV DB_URL=sqlite3:/tmp/db
RUN "/mnt/project/bin/caqti_loading"

