#import "temp.typ": *
#let theme = "g"
#show: conf.with(
  theme: theme,
  cover: false,
  need_outline: false,
)

#set math.equation(numbering: "(1a)")
#set figure(numbering: "1")
#counter(page).update(1)
#set heading(numbering: none)
#let hcol = gettheme(theme).lighten(95%).saturate(40%).lighten(10%)

/* Text contents */
= Effects of Induced Magnetic Fields in a Typical Railgun Problem
#text(size: 1.1em, fill: hcol.saturate(20%))[#align(center)[Author: _Kaju Burfi_ \ Date: Mar 2025]]

#figure(
  cetz.canvas(length: 3cm, {
    import cetz.draw: *
    // Background magnetic field lines
    content((3, .5), text(fill: gettheme(theme).lighten(40%).saturate(30%))[$va(B_0)$])
    for i in range(1, 12) {
      for j in range(1,4) {
        content((i/4,j/4), text(fill: gettheme(theme).lighten(40%).saturate(30%))[#math.times.circle.big])
      }
    }

    // Make the rail
    set-style(stroke: 1.5pt + white)
    line((0,0), (0,1), name: "2")
    line((0,0), (3,0), name: "3")
    line((0,1), (3,1), name: "1")
    line((1.2,-.2), (1.2, 1.2), name: "rod", stroke: 1.5pt + hcol)

    content("1.start", [$die.one$], anchor: "south-west", padding: .1)
    content("2.start", [$die.two$], anchor: "south-east", padding: .1)
    content(("3.start", 10%, "3.end"), [$die.three$], anchor: "south", padding: .1)

    // Labels
    set-style(stroke: hcol)
    mark((0,.5), (0,0), symbol: "straight", anchor: "center", scale: 1.5)
    content(("2.start", 50%, "2.end"), padding: .1, anchor: "east", [$i$])
    mark((.6,0), (1.2,0), symbol: "straight", anchor: "center", scale: 1.5)
    content(("3.start", 20%, "3.end"), padding: .1, anchor: "south", [$i$])
    mark((1.2,.5), (1.2,1), symbol: "straight", anchor: "center", scale: 1.5)
    content(("rod.start", 50%, "rod.end"), padding: .1, anchor: "west", [$i$])
    mark((0.6,1), (0,1), symbol: "straight", anchor: "center", scale: 1.5)
    content(("1.start", 20%, "1.end"), padding: .1, anchor: "south", [$i$])
    
    set-style(stroke: 1pt + white)
    line((1.2, .3), (1.8, .3), mark: (end: "straight"), name: "v")
    content("v.end", [$va(v)$], anchor: "north")
    content("rod.end", text(fill:hcol)[$R, m, l$], anchor: "west", padding: .1)

    // Math labels
    line((0,-.1), (1.2, -.1), mark: (end: ">"), name: "x")
    content(("x.start", 50%, "x.end"), [$x$], anchor: "north", padding: .1)
    line((1.1, 0), (1.1, .7), mark: (end: ">"), name: "y")
    content(("y.start", 50%, "y.end"), [$y$], anchor: "east", padding: .1)
    line((1.2, .7), (1.2, .8), mark: (symbol: "|"), name: "dy")
    content(("dy.start", 50%, "dy.end"), text(size: .8em)[$dif y$], anchor: "east", padding: .1)
    content(("dy.start", 50%, "dy.end"), [P], anchor: "south-west", padding: .05)
  })
)

In these types of problems, also solved in my Questions page, we do not consider the fact that the conducting wires used here, i.e., $die.one , die.two , die.three$, carry current, and hence would create their own magnetic fields.
Here, we have a look at what would change if we *do* consider these magnetic fields, and whether or not they are truly negligible.

_Assumptions_: The conducting wires used have negligible resistance. Only the rod(highlighted) has a considerable resistance of $R$. The width of the setup, which is also the length of the rod, is $l$. The mass of the rod considered is $m$. It is initially pushed to the right with an initial velocity of $v_0$, which at a general moment, is $v$. Let the distance of the rod from the leftmost wire(Wire $die.two$) be $x$. Consider a general point $"P"$, at some distance $y$ from the lower wire(Wire $die.three$). A current $i$ will be generated due to electromagnetic induction. A constant magnetic field of magnitude $B_0$ is present with the direction being into the plane of the page.

By using Biot-Savart's law, we can get the magnetic fields due to wires $die.one, die.two, die.three$ at point P
$
  B_(die.one) = (mu_0 i)/(4pi (l-y)) [ x/ sqrt(x^2+(l-y)^2)] dot.circle \
  B_(die.two) = (mu_0 i)/(4pi x) [ y/sqrt(x^2+y^2) + (l-y)/sqrt(x^2+(l-y)^2)] dot.circle \
  B_(die.three) = (mu_0 i)/(4pi y) [ x/sqrt(x^2+y^2)] dot.circle
$

Where the $dot.circle$ represents that they all have the directions of the magnetic field out of the plane. 
Hence, the total field at any distance $x$, height $y$, at a point P is:
$
  cal(B) = B_0 - [ B_(die.one) + B_(die.two) + B_(die.three) ]
$ 
Which can be simplified to,
$
  va(cal(B)) = B_0 - (mu_0 i )/(4pi) [sqrt(1/x^2+1/y^2) + sqrt(1/x^2+1/(l-y)^2)] times.circle
$
With the direction of the vector pointing in to the plane.

Now, we can find the induced electromagnetic force:
$
  cal(E) = int_r^(l-r) va(v) cprod va(cal(B)) dprod dif va(y)
$

Note our limits of integration. They go from $r$(the radius of each conducting wire) to $l-r$. This is because the magnetic field of a line current tends to infinity as the distance from the wire goes to zero. Hence, we consider some small, but non-zero radius of the wire, $r$.

Since $va(v)$, $va(cal(B))$ and $dif va(y)$ are mutually perpendicular, the triple scalar product is simply the products of their magnitudes. 
Further, the velocity $va(v)$ is independent of height $y$. Therefore, it can be taken out of the integral. So,
$
  cal(E) &= v int_r^(l-r) cal(B) dif y \
  &= v B_0 l - (mu_0 i)/(4pi) int_r^(l-r) [sqrt(1/x^2+1/y^2) + sqrt(1/x^2+1/(l-y)^2)] dif y #<take_i_out> \
  &= v B_0 l - (mu_0 i)/(4pi) stretch(\[, size: #375%) 
    sqrt(1+(y/x)^2) - coth^(-1)(sqrt(1+(y/x)^2)) #<equate:revoke>\ 
   &"  " - sqrt(1+((l-y)/x)^2) + coth^(-1)(sqrt(1+((l-y)/x)^2)) stretch(\], size: #375%)
  stretch(\|, size: #375%)_r^(l-r)
$

In @take_i_out, we see that $i$, even though it varies with time, does #smallcaps[not] vary with $y$, and hence can be taken out of the integral.


Here, for simplicity, we shall define a function:
$
  Lambda_x (a) stretch(=)^"def" sqrt(1+(a/x)^2)
$

Hence, we get:
$
  cal(E) = v B_0 l - (mu_0 i)/(2pi) [
    Lambda_(x) (l-r) - Lambda_(x) (r)
    + coth^(-1)(Lambda_(x) (r)) - coth^(-1)(Lambda_(x) (l-r))
  ]
$

Further, since this is an only resistance circuit, Ohm's law is valid:
$
  cal(E) = i R
$
Substituting this, we can solve for the current $i$, and we get,
$
  i = (v B_0 l)/(R + mu_0/(2pi)[
    Lambda_x (l-r) - Lambda_x (r)
    + coth^(-1)(Lambda_x (r)) - coth^(-1)(Lambda_x (l-r))
  ])
$ <exact>

Compare this with what we would have gotten if we neglected the magnetic fields produced by the wires.
$
  i = v B_0 l
$ <approximate>

In @exact, we see that for the whole term in the bracket, there is a common factor of $mu_0/(2pi)$, which has a value of exactly#footnote[According to old standards, but it is approximately still the same.] $2 dot 10^(-7) "N" "A"^(-2)$, which is a _tiny_ quantity. Hence that term basically makes no difference to the net force on the rod. 

For a better view, here is the graph of both functions(@exact, and @approximate):

#figure(
  image("graph.png"),
  caption: [#link("https://www.desmos.com/calculator/9wqzdiasjl")[Interactive Plot]]
)

Here, for clarity, I have made the value of $mu_0/(2pi)$ quite large($approx 0.01$), so that one can see a clear distinction between the red(@exact) and the black(@approximate) curves. In the #link("https://www.desmos.com/calculator/9wqzdiasjl")[Interactive Plot], you can change a couple of values to see the difference. Try it out! 

In the graph, I have used different variable names for ease of typing the equation in the plotter. Note that here the X axis represents the distance $x$ from our discussions, and the Y axis represents current $i$ in the circuit at a given moment of time. This is only for us to note the nature of the graph, not the exact values. 

=== Conclusion

From the discussion above, we can safely say that the effect of the wires' magnetic fields are, in fact, _very_ negligible. This is mainly due to the fact that $mu_0$ is such a small quantity. Even then, in our expression, the coefficient of $mu_0\/2pi$ is also small. $Lambda_x (r)$ is incredibly small, given that $r$ is small, which was one of our considerations. $Lambda_x (l-r)$ is also small, since in both the equations, $x$ is in the denominator. So, with an increase in $x$, we simply see an overall decrease the that term. So, considering $i$ to be almost the same, the other equations derived in similar problems will also be _almost_ same. 

