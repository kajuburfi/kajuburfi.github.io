// A simple dark template
//
// Todo:

#import "@preview/hydra:0.5.2": hydra
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/whalogen:0.3.0": ce
#import emoji: suit
#import "@preview/eqalc:0.1.2": math-to-func
#import "@preview/cetz:0.3.2"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/physica:0.9.4": *
#import "@preview/equate:0.3.0": equate
#import "@preview/tiptoe:0.2.0" 

#let gettheme(theme) = {
  // `choose_text.lighten(95%).saturate(40%).lighten(10%)` is the highlight color. 
  /// Color Definitions ///
  let col_b = rgb("#243535") //Blue
  let col_g = rgb("#2D3524") //Green
  let col_r = rgb("#352424") //Red
  let col_p = rgb("#2D2435") //Purple

  let choose_col = col_r

  if theme == "b" { choose_col = col_b } else if theme == "g" {
    choose_col = col_g
  } else if theme == "r" { choose_col = col_r } else { choose_col = col_p }
 
  return choose_col
}

#let conf(
  course_name: "",
  course: "",
  theme: "r",
  author: "",
  subject: "",
  cover: true,
  need_outline: true,
  doc,
) = {
  let choose_col = gettheme(theme)
  let choose_text = choose_col.lighten(95%)

  // Document meta data
  set document(
    title: course_name,
    author: author,
    date: auto,
  )

  // Use codly
  show: codly-init.with()
  codly(
    zebra-fill: choose_col.saturate(10%).lighten(5%),
    stroke: .5pt + choose_text.saturate(40%).lighten(10%),
    lang-stroke: .5pt + choose_text.saturate(40%).lighten(10%),
    lang-fill: choose_col,
    lang-radius: 10pt,
  )

  if cover {
    /// Cover page ///
    let grad1 = gradient.radial(
      choose_text.saturate(100%),
      choose_col.saturate(100%),
    )

    // let pat = tiling(
    //   size: (10pt, 10pt),
    //   relative: "parent",
    //   place(
    //     dx: 1pt,
    //     dy: 1pt,
    //     rotate(
    //       45deg,
    //       square(
    //         size: 5pt,
    //         fill: grad1,
    //       ),
    //     ),
    //   ),
    // )

    set page(
      // fill: grad1.repeat(7, mirror: true),
      fill: grad1,
      margin: (x: 0pt, y: 0pt),
    )

    rect(
      width: 100%,
      height: 100%,
      // fill: pat,
      place(
        center + horizon,
        rect(
          fill: choose_col.saturate(100%).lighten(10%),
          inset: (x: 2em, y: 1.5em),
          stroke: choose_text.saturate(30%).lighten(10%).darken(50%),
          radius: 5pt,
          text(
            3em,
            fill: choose_text.saturate(80%).darken(10%),
          )[#text(.4em, fill: choose_text.saturate(100%))[#course] \ #smallcaps(course_name) \ #text(.7em, style: "italic")[#author]],
        ),
      ),
    )

  pagebreak()
  }

  ///
  ///
  ///
  /// Page settings ///
  counter(page).update(0) //To skip the cover and contents page
  set page(
    fill: choose_col,
    margin: auto,
    header: context {
      // matches -> all places where there is a chapter name.
      let matches = query(heading.where(level: 1))
      // has-title -> checks if the page contains a title or not.
      let has-title = matches.any(m => (
        counter(page).at(m.location()) == counter(page).get()
      ))
      // Adds a header iff the page has no title
      if not has-title {
        set text(
          8pt,
          choose_text.saturate(40%).transparentize(40%),
          weight: "regular",
        )
        smallcaps(hydra(1))
        h(1fr)
        emph(course_name)
        line(
          length: 100%,
          stroke: .5pt
            + gradient.linear(
              choose_col,
              choose_text.saturate(50%),
              choose_col,
            ),
        )
      }
    },
    footer: context {
      if counter(page).display() > "0" {
        set text(
          10pt,
          choose_text.saturate(40%).transparentize(40%),
          weight: "regular",
        )
        align(center)[--- #counter(page).display() ---]
      }
    },
  )
  set text(fill: choose_text, font: "Libertinus Serif")
  show link: underline.with(
    offset: 2pt,
    stroke: .8pt
      + gradient.linear(choose_col, choose_text.saturate(60%), choose_col),
    evade: false,
    background: true,
  )
  show ref: underline.with(
    offset: 2pt,
    stroke: .5pt
      + gradient.linear(choose_col, choose_text.saturate(60%), choose_col),
    evade: false,
    background: true,
  )

  // Heading variations
  set heading(numbering: "1.1")
  show heading: set text(
    choose_text.saturate(40%).lighten(20%),
    weight: "regular",
  )
  show heading.where(level: 1): it => {
    set align(center)    
    set text(size: 2em)
    set text(
        choose_text.saturate(60%).lighten(10%),
        weight: "regular",
      )
    pagebreak(weak: true) 
    line(
      length: 100%,
      stroke: 1pt
        + gradient.linear(
          choose_col,
          choose_text.saturate(60%),
          choose_col,
        ),
    )
    v(-30pt)
    smallcaps(it)
    v(-30pt)
    line(
      length: 100%,
      stroke: 1pt
        + gradient.linear(
          choose_col,
          choose_text.saturate(60%),
          choose_col,
        ),
    )
  }
  show heading.where(level: 2): set text(size: 1.7em, choose_text.saturate(50%))
  show heading.where(level: 2): smallcaps
  show heading.where(level: 3): set text(size: 1.5em)
  show heading.where(level: 3): smallcaps

  // Table variations
  show table.cell.where(y: 0): strong
  set table(
    stroke: 0.5pt + choose_text.darken(20%),
    fill: (x, y) => if y == 0 { choose_col.lighten(10%) },
  )

  // Footnote setup
  set footnote.entry(separator: line(stroke: choose_text + 0.5pt, length: 30%))

  // Quote variations: All quotes are block quotes.
  show quote: rect.with(
    stroke: (
      left: 1pt + choose_text.saturate(40%).lighten(10%),
      top: none,
      right: none,
      bottom: none,
    ),
    inset: (left: 1em),
    fill: choose_col.saturate(10%).lighten(10%),
    radius: (
      left: 2pt,
    ),
    width: 100%,
  )
  set quote(block: true)

  // To reset the math eq. counter when a new chapter begins.
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure).update(0) // To reset figure count when a new chapter begins
    it
  }
  set math.equation(
    numbering: n => {
      numbering("(1.1)", counter(heading).get().first(), n)
    },
  )
  show: equate.with(breakable: true, sub-numbering: true)

  // Figure counter
  set figure(
    numbering: n => {
      numbering(
        "1.1",
        counter(heading).get().first(),
        counter(figure).get().first(),
      )
    },
  )

  // To be able to box equations, without the whole width taken by the box.
  // Note: To box equations properly, use following syntax:
  //
  // $ #rect($<formula>$) $ <ref>
  show math.equation: it => {
    set math.equation(numbering: none)
    it
  }

  // All rects are now boxes
  set rect(
    stroke: choose_text.saturate(40%).lighten(10%),
    radius: 3pt,
  )

  ///
  ///
  ///
  /// Contents page ///
  show outline.entry.where(level: 1): it => {
    v(1.5em, weak: true)
    strong(it)
  }

  if need_outline {
    outline(
      indent: auto,
      depth: 2,
    )
  pagebreak()
  }

  /// Return doc ///
  doc
}

// Background setup for a chemical equation
#let chem_eqn(theme: "r", body) = {
  let choose_col = gettheme(theme)
  let choose_text = choose_col.lighten(95%)

  rect(
    fill: choose_col.saturate(10%).lighten(5%),
    stroke: none,
    radius: 3.5pt,
    [#body],
  )
}

// Simple function to draw chemical structures, downloads takes care of by `./check4struct.py`
#let cstr(name) = {image("docs/"+name+".svg")}

// Counter and style for a definition
// #let c = counter("defn")
// #show heading.where(level: 1): it => {
//   c.update(0)
//   it
// }
// #let defn(theme: "", phrase, body) = {
//   /// Color Definitions ///
//   let col_b = rgb("#243535") //Blue
//   let col_g = rgb("#2D3524") //Green
//   let col_r = rgb("#352424") //Red
//   let col_p = rgb("#2D2435") //Purple

//   let choose_col = col_r

//   if theme == "b" { choose_col = col_b } else if theme == "g" {
//     choose_col = col_g
//   } else if theme == "r" { choose_col = col_r } else { choose_col = col_p }

//   let choose_text = choose_col.lighten(95%)

//   c.step()
//   let defn_no = [#context(counter(heading).get().first()).#context(c.display())]

//   // To make sure that "[]" isn't added unnecessarily
//   if phrase != [] {
//     phrase = [[#phrase]]
//   }

//   rect(
//     fill: choose_col.saturate(10%).lighten(10%),
//     stroke: (
//       left: 1pt + choose_text.saturate(40%).lighten(10%),
//       top: none,
//       right: none,
//       bottom: none,
//     ),
//     radius: (left: 0pt),
//     width: 100%,
//     [*#text(fill: choose_text.saturate(40%).lighten(10%))[Definition #defn_no:]*
//       #text(
//         fill: choose_text.saturate(40%).lighten(5%),
//       )[#smallcaps(phrase)] #body],
//   )
// }
// // To be able to reference definitions.
// #let dlink(ref) = context {
//   let defn_no = [#counter(heading).get().first().#(c.at(ref).at(0) + 1)]
//   link(ref)[Definition #defn_no]
// }

// Remarks and Solutions for questions
#let remark(body) = [#smallcaps[Remark: ]#text(size: 0.9em)[#body] #align(right)[#suit.club]]
#let soln(body) = [#smallcaps([Solution]): #body #align(right)[#suit.spade]]

// Questions
#let qs_c = counter("qs_c")
#show heading.where(level: 1): it => {
  qs_c.update(0)
  it
}
#let qs(theme: "", phrase, body) = {
  let choose_col = gettheme(theme)
  let choose_text = choose_col.lighten(95%)

  // For counting with the chapter number.
  qs_c.step()
  let qs_no = [#context(counter(heading).get().first()).#context(qs_c.display())]
  // To make sure that "[]" isn't added unnecessarily
  if phrase != [] {
    phrase = [[#phrase]]
  }

  rect(
    fill: choose_col.saturate(10%).lighten(5%),
    stroke: (
      left: 1.5pt + choose_text.saturate(80%),
      top: none,
      right: none,
      bottom: none,
    ),
    radius: (left: 0pt),
    width: 100%,
    [*#text(fill: choose_text.saturate(80%).lighten(20%))[Question #qs_no:]*
      #text(
        fill: choose_text.saturate(40%).lighten(5%),
      )[#smallcaps(phrase)] #body],
  )
}
// To be able to reference questions
#let qlink(ref) = context {
  let qs_no = [#counter(heading).get().first().#(qs_c.at(ref).at(0) + 1)]
  link(ref)[Question #qs_no]
}

// General text_box for theorems, lemmas, etc
#let text_box(theme: "", sat: "", stroking: 1pt, title, subtitle, body) = {
  let choose_col = gettheme(theme)
  let choose_text = choose_col.lighten(95%)

  block(
    above: 2em,
    stroke: stroking + choose_text.saturate(sat).lighten(10%),
    width: 100%,
    inset: 14pt,
    radius: 3pt,
  )[
    #set text(fill: choose_text)
    #place(
      top,
      dy: -7pt - 16pt,
      dx: 7pt - 16pt,
      rect(fill: choose_col, stroke: none, inset: 4pt)[
        #text(
          size: 1.2em,
          fill: choose_text.saturate(sat).lighten(10%),
        )[#smallcaps(title)]
      ],
    )
    #place(
      top + right,
      dy: -7pt - 16pt,
      dx: 20pt - 16pt,
      rect(fill: choose_col, stroke: none, inset: 4pt)[
        #text(
          size: 1em,
          fill: choose_text.saturate(sat).lighten(50%),
        )[#smallcaps(subtitle)]
      ],
    )
    #body
  ]
}

#let c = counter("defn")
#show heading.where(level: 1): it => {
  c.update(0)
  it
}
#let defn(theme: "", phrase, body) = {
  c.step()
  let defn_no = [#context(counter(heading).get().first()).#context(c.display())]
  if phrase == [] {
    text_box(theme: theme, sat: 40%, stroking: .6pt)[Definition #defn_no][][#body]
  } else {
    text_box(theme: theme, sat: 40%, stroking: .6pt)[Definition #defn_no][#phrase][#body]
  }
}
// To be able to reference definitions.
#let dlink(ref) = context {
  let defn_no = [#counter(heading).get().first().#(c.at(ref).at(0) + 1)]
  link(ref)[Definition #defn_no]
}

// Counters, boxes and references for theorems.
#let thm_c = counter("thm_c")
#show heading.where(level: 1): it => {
  thm_c.update(0)
  it
}
#let thm_box(theme: "", subtitle, body) = {
  thm_c.step()
  let thm_no = [#context(counter(heading).get().first()).#context(thm_c.display())]
  if subtitle == [] {
    text_box(theme: theme, sat: 60%, stroking: 1pt)[Theorem #thm_no][][#body]
  } else {
    text_box(theme: theme, sat: 60%, stroking: 1pt)[Theorem #thm_no][#subtitle][#body]
  }
}
// To be able to reference theorems
#let tlink(ref) = context {
  let thm_no = [#counter(heading).get().first().#(thm_c.at(ref).at(0) + 1)]
  link(ref)[Theorem #thm_no]
}

#let plotthis(eqn, dom) = context {
  let mathcode = math-to-func(eqn)
  figure(
    cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        axis-style: "school-book",
        size: (dom.last() - dom.first(), dom.last() - dom.first()),
        x-tick-step: 1,
        y-tick-step: 1,
        mark-style: (stroke: white),
        {
          plot.add(domain: dom, mathcode)
        }
      )
    }),
    kind: "graph",
    supplement: "Graph",
    caption: [#eqn]
  )
}

// Cancel-to function, adapted from https://forum.typst.app/t/is-there-an-equivalent-to-latexs-cancelto-in-typst/536
#let cancelto(body, to) = {
  context {
    let m = measure(pad(3pt, body))
    let (w, h) = (m.width, m.height)
    let angle = calc.atan(h/w)
    let dx_len = 6pt * calc.cos(angle)
    let dy_len = 6pt * calc.sin(angle)
    // let arrow = rotate(-calc.atan(h/w), math.stretch($->$, size: (h/calc.sin(calc.atan(h/w)))*100%))
    set place(center + bottom)
    // block(height: h * 2.5, align(horizon, body)) // Add vertical margins.
    // body
    // place(dx: -w * 0.5, dy: -h * 0.15, arrow)
    $cancel(body)^(
      #place(tiptoe.line(toe: tiptoe.stealth, length: 0pt, stroke: .8pt + white, angle: -angle - 15deg), dx: 4pt)
      #place(to, dx: dx_len, dy: -dy_len)
    )$
    // place(dx: w * 0.1, dy: -h * 0.8, to)
  }
}

// Some math shorthands
#let int = math.op($integral$)
#let iint = math.op($integral.double$)
#let iiint = math.op($integral.triple$)
#let oint = math.op($integral.cont$)
#let oiint = math.op($integral.surf$)
#let oiiint = math.op($integral.vol$)
