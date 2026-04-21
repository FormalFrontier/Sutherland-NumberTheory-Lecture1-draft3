**Definition 1.10.** A *valuation* on a field $k$ is a group homomorphism $v : k^\times \to \mathbf{R}$ such that for all $x, y \in k$ we have

$$
v(x + y) \ge \min(v(x), v(y)).
$$

We may extend $v$ to a map $k \to \mathbf{R} \cup \{\infty\}$ by defining $v(0) := \infty$. For any $0 < c < 1$, defining

$$
|x|_v := c^{v(x)}
$$

yields a nonarchimedean absolute value. The image of $v$ in $\mathbf{R}$ is the *value group* of $v$. We say that $v$ is a *discrete valuation* if its value group is equal to $\mathbf{Z}$ (every discrete subgroup of $\mathbf{R}$ is isomorphic to $\mathbf{Z}$, so we can always rescale a valuation with a discrete value group so that this holds). Given a field $k$ with valuation $v$, the set

$$
A := \{x \in k : v(x) \ge 0\},
$$

is the *valuation ring* of $k$ (with respect to $v$). A *discrete valuation ring* (DVR) is an integral domain that is the valuation ring of its fraction field with respect to a discrete valuation; such a ring $A$ cannot be a field, since $v(\operatorname{Frac} A) = \mathbf{Z} \ne \mathbf{Z}_{\ge 0} = v(A)$.

