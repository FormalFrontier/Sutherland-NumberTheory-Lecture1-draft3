Let us now suppose that the integral domain $A$ is the valuation ring of its fraction field with respect to some discrete valuation $v$ (which we shall see is uniquely determined). Any element $\pi \in A$ for which $v(\pi) = 1$ is called a *uniformizer*. Uniformizers exist, since $v(A) = \mathbf{Z}_{\ge 0}$. If we fix a uniformizer $\pi$, every $x \in k^\times$ can be written uniquely as

$$
x = u\pi^n
$$

where $n = v(x)$ and $u = x/\pi^n \in A^\times$ is uniquely determined. It follows that $A$ is a unique factorization domain (UFD), and in fact $A$ is a principal ideal domain (PID). Indeed, every nonzero ideal of $A$ is equal to

$$
(\pi^n) = \{a \in A : v(a) \ge n\},
$$

for some integer $n \ge 0$. Moreover, the ideal $(\pi^n)$ depends only on $n$, not the choice of uniformizer $\pi$: if $\pi^\prime$ is any other uniformizer its unique representation $\pi^\prime = u\pi^1$ differs from $\pi$ only by a unit. The ideals of $A$ are thus totally ordered, and the ideal

$$
\mathfrak{m} = (\pi) = \{a \in A : v(a) > 0\}
$$

is the unique maximal ideal of $A$ (and also the only nonzero prime ideal of $A$).

*18.785 Fall 2025, Lecture #1, Page 3*
