**Proof.** We apply the rational root test: suppose $r/s \in \mathbf{Q}$ is integral over $\mathbf{Z}$, where $r$ and $s$ are coprime integers. Then

$$
\left(\frac{r}{s}\right)^n + a_{n-1}\left(\frac{r}{s}\right)^{n-1} + \cdots a_1\left(\frac{r}{s}\right) + a_0 = 0
$$

for some $a_0, \ldots, a_{n-1} \in \mathbf{Z}$. Clearing denominators yields

$$
r^n + a_{n-1}sr^{n-1} + \cdots a_1s^{n-1}r + a_0s^n = 0,
$$

thus $r^n = -s(a_{n-1}r^{n-1} + \cdots a_1s^{n-2}r + a_0s^{n-1})$ is a multiple of $s$. But $r$ and $s$ are coprime, so $s = \pm 1$ and therefore $r/s \in \mathbf{Z}$.
