(lang dune 2.0)

(name demo)

(source
 (github tmattio/demo))

(license MIT)

(authors "Thibaut Mattio")

(maintainers "Thibaut Mattio")

(generate_opam_files true)

(package
 (name demo)
 (synopsis "Repro of a bug rendering SVG with Lwd")
 (description "Repro of a bug rendering SVG with Lwd")
 (depends
  (ocaml
   (>= 4.08.0))
  dune
  js_of_ocaml
  js_of_ocaml-ppx
  lwd
  tyxml-lwd))
