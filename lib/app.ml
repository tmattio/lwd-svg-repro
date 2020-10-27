open Js_of_ocaml

module El = struct
  let make =
    let open Tyxml_lwd.Html in
    let a_svg_custom x y =
      Tyxml_lwd.Xml.string_attrib x (Lwd.pure y) |> Tyxml_lwd.Svg.to_attrib
    in
    div
      ~a:[ a_class (Lwd.pure [ "text-gray-500" ]) ]
      [ svg
          ~a:
            [ Tyxml_lwd.Svg.a_class (Lwd.pure [ "w-8 h-8" ])
            ; Tyxml_lwd.Svg.a_fill (Lwd.pure `None)
            ; Tyxml_lwd.Svg.a_stroke (Lwd.pure `CurrentColor)
            ; Tyxml_lwd.Svg.a_viewBox (Lwd.pure (0., 0., 24., 24.))
            ]
          [ Tyxml_lwd.Svg.path
              ~a:
                [ Tyxml_lwd.Svg.a_d (Lwd.pure "M6 18L18 6M6 6l12 12")
                ; a_svg_custom "stroke-linecap" "round"
                ; a_svg_custom "stroke-linejoin" "round"
                ; a_svg_custom "stroke-width" "2"
                ]
              []
          ]
      ]
end

let onload _ =
  let main =
    Js.Opt.get
      (Dom_html.window##.document##getElementById (Js.string "root"))
      (fun () -> assert false)
  in
  let root = Lwd.observe El.make in
  Lwd.set_on_invalidate root (fun _ ->
      ignore
        (Dom_html.window##requestAnimationFrame
           (Js.wrap_callback (fun _ -> ignore (Lwd.quick_sample root)))));
  List.iter
    (Dom.appendChild main)
    (Lwd_seq.to_list (Lwd.quick_sample root)
      : _ Tyxml_lwd.node list
      :> Tyxml_lwd.raw_node list);
  Js._false

let start () = Dom_html.window##.onload := Dom_html.handler onload
