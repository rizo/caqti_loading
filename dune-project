(lang dune 3.16)
(name caqti_loading)
(generate_opam_files true)
(implicit_transitive_deps false)

(package
 (name caqti_loading)
 (depends
  ocaml
  dune
  ptime
  uri
  eio_main
  caqti
  caqti-eio
  caqti-driver-sqlite3))
