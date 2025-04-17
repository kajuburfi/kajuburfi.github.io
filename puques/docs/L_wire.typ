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
= Self Inductance of a Straight Wire
#text(size: 1.1em, fill: hcol.saturate(20%))[#align(center)[Author: _Kaju Burfi_ \ Date: Feb 2025]]

#quote[#text(size: 1.1em)[Find the self inductance of a straight wire of length $l$ and radius $R$. Assume the current to be spread equally in the interior of the wire, i.e. current density($arrow(j)$) is constant.]]

To find this, we shall first split the inductances into an _internal_ inducatance($cal(L_1)$) and an _external_ inductance($cal(L)_2$).

===== To find _internal_ inductance($cal(L_1)$):

This would be the inductance formed within the wire itself. Note that the field inside the wire has a different expression to that outside the wire. To solve for $cal(L_1)$, we shall equate the energies.

Magnetic energy in a region, 
$
  U = 1/(2mu_0) int B^2 dif V
$

We shall compare this with the expression for energy in an inductor,
$
  U = 1/2 cal(L) i^2
$

#figure(
  cetz.canvas(length: 1.5cm, {
    import cetz.draw: *
    set-style(stroke: white)
    circle((0,0))
    line((-.5, calc.sqrt(3)/2), (1.5, calc.sqrt(3)/2 + 1))
    line((.5, -calc.sqrt(3)/2), (2.87, .55))
    arc((2.85,.5), start: -30deg, stop: 120deg)
    circle((0,0), radius: 0.5, stroke: (dash: "dashed", paint: white, thickness: .5pt), name: "smallcircle")
    line((0,0), (calc.sqrt(3)/4, .5/2), stroke: .5pt + hcol, name: "r", mark: (end: "straight"))
    content(("r.start", 50%, "r.end"), angle: "r.end", padding: .1, anchor: "south", text(fill:hcol)[$va(r)$])
    line((0,0), (0, -1), stroke: .7pt + white, name : "R")
    content(("R.start", 70%, "R.end"), angle: 0deg, padding: .1, anchor: "west", [$R$])
    line((-.5, calc.sqrt(3)/2+.2), (1.5, calc.sqrt(3)/2 + 1.2), name: "l")
    content(("l.start", 50%, "l.end"), angle: "l.end", padding: .1, anchor: "south", [$l$])
    content((-.75, 0), text(fill:hcol)[$times.circle va(j)$])
    line((element: "smallcircle", point: (.2,.7), solution: 2), (.2,.7), mark: (end: "straight"), stroke: 1pt+hcol, name: "B")
    content(("B.start", 100%, "B.end"), angle: "B.end", padding: 0, anchor: "south-east", text(fill:hcol)[$va(B)$])
  })
)

The magnetic field within a wire carrying current of current density $va(j)$,
$
  va(B) = mu_0/2 (va(j) cprod va(r))
$

Here, since $va(j)$ is constant in magnitude(into the plane of the page), which is always orthogonal to the radius vector $va(r)$, the cross product is simply the product of their magnitudes, and since $va(x) cprod va(x) = abs(va(x))^2$, we get:
$
  B^2 = (mu_0^2 i^2 r^2)/(4 pi^2 R^2)
$

We can now integral over the volume of the cylindrical wire to get the total energy _within_ the wire.
$
  U = 1/(2mu_0) (mu_0^2 i^2)/(4 pi^2 R^2) limits(iiint)_(0 0 0)^(l 2pi R) r^2 (r dif r dif theta dif z)
$

Here, $r$ varies from $0$ to $R$, $theta$ varies from $0$ to $2pi$, and $z$ varies from $0$ to $l$. We have used the infinitesimal cylindrical volume element.

Integrating, we get the simplified expression that is independent of $R$,
$
  U = underbrace((mu_0 i^2 l)/(16 pi) = 1/2 cal(L_1) i^2, "compare")
$

$
  => cal(L_1) = (mu_0 l)/(8pi)
$

#remark[Notice that the _internal_ self inductance here is independent of $R$. Further, the _internal_ inductance per unit length is a constant value:
$
  cal(L_1)/l = mu_0/(8pi)
$]

===== To find _external_ inductance($cal(L_2)$):

Here, we shall make use of the fact that the magnetic flux $Phi = cal(L_2)i$. We shall calculate the flux as $Phi = iint va(B) dprod dif va(A)$. Note that $dif A = dif x dif b$

#figure(
  cetz.canvas(length: 1.5cm, {
    import cetz.draw: *
    set-style(stroke: white)
    line((-.05,0), (-.05,3), name: "wire1")
    line((.05,0), (.05,3), name: "wire2")

    line((-.5, 0), (3, 0), stroke: (dash: "dashed", paint: white, thickness: .5pt))
    line((-.5, 3), (3, 3), stroke: (dash: "dashed", paint: white, thickness: .5pt))
    cetz.decorations.flat-brace((-.5, 0), (-.5, 3))
    content((-.9, 1.5), anchor: "east", [$l$])

    line((2,0), (2,3), stroke: 0.5pt+white)
    line((2.1,0), (2.1,3), stroke: 0.5pt+white)

    line((0,-.1), (2, -.1), name: "x", mark: (end: ">"))
    content(("x.start", 50%, "x.end"), anchor: "north", padding: 0.1, [$x$])
    line((2,-.1), (2.1, -.1), name: "dx", mark: (symbol: "|"))
    content(("dx.start", 50%, "dx.end"), anchor: "north", padding: .1, [$dif x$])

    line((-.15, 0), (-.15, 2), name: "y", mark: (end: ">"))
    content(("y.start", 50%, "y.end"), anchor: "east", padding: .1, [$y$])
    line((-.05, 2), (.05, 2), stroke: 0.5pt + white)
    line((-.05, 2.1), (.05, 2.1), stroke: 0.5pt + white)
    content((-.22, 2), padding: .1, anchor: "south",[$dif y$])

    line((2.2, 0), (2.2, 1.5), mark: (end: ">"), name: "b")
    content(("b.start", 50%, "b.end"), anchor: "west", padding: .1, [$b$])
    line((2, 1.5), (2.1, 1.5), stroke: .5pt+white)
    line((2, 1.6), (2.1, 1.6), stroke: .5pt+white)
    content((2.1, 1.5), padding: .1, anchor: "south-west",[$dif b$])
    content((2,1.5), padding: .1, anchor: "north-east", [P])

    line((0.05, 1.5), (2, 1.5), stroke: (dash: "dashed", paint: white, thickness: .5pt))
    line((0.05, 2), (2, 1.6), stroke: (dash: "dashed", paint: white, thickness: .5pt), name: "r")
    content(("r.start", 50%, "r.end"), anchor: "south", padding: .1, angle: "r.end", [$r$])
    cetz.angle.angle((0.05, 2), (0.05, 0), (2,1.6), label: $theta$, radius: 10pt, label-radius: 150%)
  })
)

We know that the magnetic field of a wire, here at point P is into the plane of the page. Hence, the dot product between the two is simply the product of their magnitudes.

By Biot-Savart's law, the magnetic field at point P, $B_"P"$ is given by,
$
  dif B_"P" = mu_0/(4pi)  (i dif y sin theta)/r^2
$

We can get the total magnetic field at point P by integrating $y$ along the length of the wire.
$
  B_"P" = (mu_0 i)/(4pi) int_0^l x/[(y-b)^2+x^2]^(3/2) dif y
$

Integrating and substituting limits, we get:
$
  B_"P" = (mu_0 i)/(4pi) cancel(x) [(l-b)/(x^cancel(2) sqrt((l-b)^2 + x^2)) + b/(x^cancel(2) sqrt(b^2+x^2))]
$

Now, $Phi = limits(iint)_(R  0)^(oo  l) B dif b dif x$. We shall first integrate with respect to $b$, then $x$.
$
  Phi &= (mu_0 i)/(4pi) int_R^oo 1/x int_0^l (l-b)/(sqrt((l-b)^2 + x^2)) + b/(sqrt(b^2+x^2)) dif b dif x\
  &= (mu_0 i)/(4pi) int_R^oo 1/x 2[sqrt(x^2+l^2) - x ]dif x \
  &= (mu_0 i)/(2pi) int_R^oo (sqrt(x^2+l^2 ) - x )/x dif x\
  &= (mu_0 i)/(2pi) evaluated([sqrt(x^2+l^2) -x - l sinh^(-1)(l/x)])_R^oo \
  &= (mu_0 i)/(2pi) [cancelto(sqrt(oo^2 + l^2) - oo, 0) - 0 - sqrt(R^2 + l^2) + R + l sinh^(-1)(l/R)] #<12e> \
  Phi &= (mu_0 i)/(2pi) [ R + l sinh^(-1)(l/R) - sqrt(R^2+l^2) ] 
$

Note that in @12e, the expression evaulating to zero goes to zero in the limit as x tends to infinity. 
And, $Phi = cal(L_2) i$. Comparing, 
$
  cal(L_2) = mu_0/(2pi) [ R(1 - sqrt(1-eta^2)) + l sinh^(-1)(eta)]
$

Where $eta stretch(=)^"def" l\/R$

Hence, total self inductance, $cal(L)$, 
$
  cal(L) &= cal(L_1) + cal(L_2) \
  cal(L) &= (mu_0)/(2pi) [
    R (1 - sqrt(1+eta^2)) +
    l sinh^(-1)(eta) + l/4
  ] #<14b>
$
  
$
  #rect($ cal(L) = (mu_0 R)/(2pi) [
    ( 1 - sqrt(1+eta^2)) +
    eta sinh^(-1)(eta) + 
    eta/4
  ] $)
$<exact>

@exact gives us the exact equation for the self inductance of a straight conductor. However, generally the length $l$ of the conductor is much larger than its radius $R$. So, $eta >> 1$. Using this approximation, we can re-write @exact in simpler terms.

First, approximation for $sinh^(-1)x$, when $x$ is large, i.e. $x>>1$
$
  sinh^(-1)x &= ln(x + sqrt(1+x^2)) \
  &= ln(x(1 + sqrt(1/x^2+1))) \
  &approx ln(x(1+sqrt(cancelto(1/x^2, 0) + 1))) #<using_approx> \
  therefore sinh^(-1)x &approx ln(2x) "for large" x 
$

Note that in @using_approx, we make use of the fact that $eta>>1$. 
Now, @exact can be approximated as(moving from @14b):
$
  cal(L) approx (mu_0 l)/(2pi) [
    1/eta - cancelto(sqrt(1/eta^2 + 1), 1) + sinh^(-1)(eta) + 1/4
  ] \
  approx (mu_0 l)/(2pi) [ln(2eta) + cancelto(1/eta, 0) - 3/4] \
  #rect($ cal(L) approx (mu_0 l)/(2pi)[ln(2eta) - 3/4] $) #<approx> 
$

@approx is the most commonly found answer for the self inductance of a finite conductor.

===== Some unanswered questions:
+ Why are the limits of $b$ from $0$ to $l$? As we are calculating flux, shouldn't we integrate over all of space?

=== References

+ #link("https://physics.stackexchange.com/a/21631/455810")[This] thread from the #link("https://physics.stackexchange.com")[Physics Stack Exchange].
+ The Self and Mutual Inductances of Linear Conductors, by Edward B. Rosa. \ Washington, September 15, 1907. #link("https://g3ynh.info/zdocs/refs/NBS/Rosa1908.pdf")[File].
+ Inductance Calculation Techniques -- Part II: Approximations. by Marc T. Thompson. \ Though not exactly a _Calculation Techniques_ paper, it possess the approximate equation, @approx, we derived. #link("https://www.thompsonrd.com/induct2.pdf")[File].
 
