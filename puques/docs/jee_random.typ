#import "@preview/tablem:0.2.0": tablem
#import "temp.typ": *
#let theme = "b"
#show: conf.with(
  theme: theme,
  cover: false,
  need_outline: false,
)

#set math.equation(numbering: "(1)")
#set figure(numbering: "1")
#counter(page).update(1)

#heading(numbering: none)[#text(size:.7em)[The Ideal Number of Questions to Attempt Randomly for Maximum Positive Marks] \ #text(size: .4em)[Author: _Kaju Burfi_]]

Consider you're writing an exam. It has only Multiple Choice (Single correct) Questions [MCQs]. What would be the best number of questions to _guess_? Obviously, this would depend upon the marking scheme.
 
If there were no negative marking, i.e. even if you get an answer wrong, you get zero marks. In this case, the best bet would be to attempt all questions.

If there *is* negative marking, things get complicated. Consider a common marking scheme:
- Correct answer: #text(fill: green)[*+4*]
- Wrong answer: #text(fill: red)[*-1*]
- Unanswered: $plus.minus$*0*

The questions each have 4 options, only one of them are correct. Hence, if we were to guess randomly, we have a 1 in 4 chance of getting it right(#text(fill:green)[*+4*]), or a 3 in 4 chance of getting it wrong(#text(fill:red)[*-1*]). Let $n$ be the number of questions we _guess_.

We can calculate the expected value, $mu$, as the product of the probability of getting a particular mark and the value of the mark we attain. 

For $n=1$, we have two possible cases(as discussed above). Hence, the expected value,
$
  mu_1 = ( -1 times 3/4 ) + ( 4 times 1/4 ) = 1/4
$ 

For $n=2$, we have three possible cases: 
- Both wrong #sym.arrow.r (-1) + (-1) = -2 #h(1fr)  Probability = $3/4 times 3/4 = 9/16$
- One correct, one wrong #sym.arrow.r (-1) + (4) = 3 #h(1fr) Probability = $3/4 times 1/4 = 6/16$
- Both correct #sym.arrow.r (4) + (4) = 8 #h(1fr) Probability = $1/4 times 1/4 = 1/16$
Calculating the expected value, we get:
$
  mu_2 = 1/2
$

This means that on average, if we were to _guess_ two questions, we would get half a mark. But we cannot get *half a mark* in an actual exam(of this format). 

@t1 gives the probabilities for some values of $n$:
#figure(
  tablem(align: center+horizon)[
    | $n$ | Possible marks & their probabilities | < | < | < | Expected value($mu$) |
    | --- | ------------------------------------ | < | < | < | -------------------- |
    |  1  |  -1   | <  |   4   |   <    | $1/4$ |
    |  ^   | (3/4)| <  | (1/4) |   <   |  ^    |
    |  2  |  -2   |   3   |   8    | < | $1/2$ |
    |  ^   |(9/16) | (6/16)| (1/16)| < |   ^    |
    | 3  |  -3  |  2  |  7  |  12 | $3/4$ |
    | ^ | (3/4$)^3$ | 3(3/4$)^2$(1/4) | 3(3/4)(1/4$)^2$ | (1/4$)^3$ | ^ |
    | $n$ | $-n$ | $4-(n-1)$ | $8-(n-2)$ ... | ... $4n$ |$n/4$|
    | ^ | $binom(n,0)(3/4)^n$ | $binom(n,1) (3/4)^(n-1) (1/4)$ | $binom(n,2)(3/4)^(n-2) (1/4)^2$ | $binom(n,n) (1/4)^n$ | ^ |
  ],
  caption: [Possible marks and their probabilities]
)<t1>

Let us denote the marks obtained, given we got $i$ correct, as $x_i$. Hence, if we get zero correct(or all wrong), we get $x_0 = -n$ marks, where $n$ is the number of questions attempted.

In general, 
$
  x_i = 4r - (n-r) = 5r-n #h(20pt)"for" 0 <= r <= n 
$

Here, $r$ is a dummy variable which we iterate over to get the total probability.

We would like to get non-negative marks, or
$
  &x_i >= 0 \
  <==> &r>=n/5
$

But, 
$
  r, n in ZZ => r>= ceil(n/5)
$

Where $ceil(dot)$ is the ceiling function. 

We want the probability of getting non-negative marks, i.e.
$
  "P"(x_i >= 0) &= sum_(r = ceil(n\/5))^n binom(n, r) (3/4)^(n-r) (1/4)^r \
  &= (3/4)^n sum_(r = ceil(n\/5))^n binom(n,r)/3^r
$

This is just a bernoulli's trials, with $p=1/4$ and $q=3/4$. 

Computing this for various values of $n$, we get the following:

#figure(
  tablem(align:center)[
    | n | $"P"(x_i>=0)$ |
    | - | ------------- |
    | 1 | 25% |
    | 2 | 43.75% |
    | 3 | 57.81% |
    | 4 | 68.35% |
    |5| 76.27% |
    |6| 46.60% |
    |7| 55.50% |
    |8| 63.20% |
    |9| 69.96% |
    |10| 75.59% |
    |11| 54.47%|
  ],
  caption: [Probability of getting non-negative marks]
)<t2>

Here we see that the best possible number of questions to attempt would be a multiple of 5. 
But this would be quite misleading. It is true, but misleading.

We considered $"P"(x_i>=0)$, which includes the cases where $x_i = 0$. This case occurs only when $n = 5k, k in NN$. 
In fact, when you calculate the probabilities, $"P"(x_i = 0)$ is very high. Some values are given in @t3:

#figure(
  tablem(align: center)[
    |$n$|$"P"(x_i = 0)$|
    |-|--------------|
    |5| 39.55%|
    |10|28.15%|
    |15|22.51%|
  ],
  caption: [Probability of getting zero marks]
)<t3>

Now, considering this as well, we can make the final table to get the probabilities of getting _positive_ marks.
 
#figure(
  tablem(align:center)[
    | n | $"P"(x_i>0)$ |
    | - | ------------- |
    | 1 | 25% |
    | 2 | 43.75% |
    | 3 | 57.81% |
    | 4 | 68.35% |
    |5| 36.72% |
    |6| 46.60% |
    |7| 55.50% |
    |8| 63.20% |
    |9| 69.96% |
    |10| 47.44% |
    |11| 54.47%|
  ],
  caption: [Probability of getting positive marks]
)<t4>

Some observations from @t4:
- Probability of getting a zero is more than that of getting positive marks if $n=5$. \
  $
    "P"&(x_i = 0) > "P"&&(x_i > 0) "when" n = 5 \
    &[39.55%] &&[36.72%]
  $
- Best number of questions $n$ to attempt is $5k-1, k in NN$, i.e. 4, 9, 14, etc.

#heading(numbering: none, level: 3)[Conclusion]

For an exam with a marking scheme as #text(fill: green)[+4] and #text(fill:red)[-1], the best possible number of questions to answer would be a one less than a multiple of 5, or $5k-1, k in NN$, with probabilities of getting postive marks as $68.35%$ for 4 questions and $69.96%$ for 9 questions. 

Note that this assumes completely random choice of options. In reality, you will generally have some idea, which reduces the probability of negatives. So, it is almost always better than $70%$ chance, given you attempt 4 or 9 questions. 

So, take #strike[risks] calculated risks!
