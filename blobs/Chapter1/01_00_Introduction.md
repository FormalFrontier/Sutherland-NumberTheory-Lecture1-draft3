# 18.785 Number theory I

Lecture #1

Fall 2025
9/4/2025

# 1 Absolute values and discrete valuations

## 1.1 Introduction

At its core, number theory starts with the ring $\mathbf{Z}$. By the fundamental theorem of arithmetic, every element of $\mathbf{Z}$ can be written uniquely as a product of primes (up to multiplication by a unit $\pm 1$), so it is natural to focus on the prime elements of $\mathbf{Z}$. If $p$ is a prime, the ideal $(p) := p\mathbf{Z}$ is a maximal ideal ($\mathbf{Z}$ has Krull dimension one), and the residue field $\mathbf{Z}/p\mathbf{Z}$ is the finite field $\mathbf{F}_p$ with $p$ elements. The fraction field of $\mathbf{Z}$ is the field $\mathbf{Q}$ of rational numbers. The field $\mathbf{Q}$ and the finite fields $\mathbf{F}_p$ together make up the prime fields: every field $k$ contains exactly one of them, according to its characteristic: $k$ has characteristic zero if and only if it contains $\mathbf{Q}$, and $k$ has characteristic $p$ if and only if $k$ contains $\mathbf{F}_p$.

One can also consider finite extensions of $\mathbf{Q}$, such as the field $\mathbf{Q}(i) := \mathbf{Q}[x]/(x^2 + 1)$. These are called *number fields*, and each can be constructed as the quotient of the polynomial ring $\mathbf{Q}[x]$ by one of its maximal ideals; the ring $\mathbf{Q}[x]$ is a principal ideal domain and its maximal ideals can all be written as $(f)$ for some monic irreducible $f \in \mathbf{Z}[x]$.

Number fields are one of two types of *global fields*; the others are *global function fields*. Let $\mathbf{F}_q$ denote the field with $q$ elements, where $q$ is any prime power. The polynomial ring $\mathbf{F}_q[t]$ has much in common with the integer ring $\mathbf{Z}$. Like $\mathbf{Z}$, it is a principal ideal domain of dimension one, and the residue fields $\mathbf{F}_q[t]/(f)$ one obtains by taking the quotient by a maximal ideal $(f)$, where $f \in \mathbf{F}_q[t]$ is any irreducible polynomial, are finite fields $\mathbf{F}_{q^d}$, where $d$ is the degree of $f$. In contrast to the situation with $\mathbf{Z}$, the residue fields of $\mathbf{F}_q[t]$ all have the same characteristic as its fraction field $\mathbf{F}_q(t)$, which plays a role analogous to $\mathbf{Q}$. Global function fields are finite extensions of $\mathbf{F}_q(t)$.

Associated to each global field $k$ is an infinite collection of *local fields* corresponding to the completions of $k$ with respect to its absolute values; when $k = \mathbf{Q}$, these completions are the field of real numbers $\mathbf{R}$ and the $p$-adic fields $\mathbf{Q}_p$ (as you will prove on Problem Set 1).

The ring $\mathbf{Z}$ is a principal ideal domain (PID), as is $\mathbf{F}_q[t]$, and in such fields every nonzero prime ideal is maximal and thus has an associated *residue field*. For both $\mathbf{Z}$ and $\mathbf{F}_q[t]$ these residue fields are finite, but the characteristics of the residue fields of $\mathbf{Z}$ are all different (and distinct from the characteristic of its fraction field), while those of $\mathbf{F}_q[t]$ are all the same.

