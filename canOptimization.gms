
* -------------------------------------------------
* Can Optimization Assignment
* Author: Fatih Şahinoğlu
* Course: CE538 – Optimization
* Tool: GAMS
* -------------------------------------------------

* Parameters (may be edited)
Scalar
    V0  "volume of one can"         / 1 /
    c1  "weight: can material"      / 1 /
    c2  "weight: box material"      / 1 /
    D0  "max box dimension"         / 10 /;

Positive Variables
    r   "can radius"
    h   "can height";

Variable
    z   "objective function";

Equations
    obj   "objective"
    vol   "volume constraint"
    dimR  "8r <= D0"
    dimH  "h  <= D0";

obj..  z =e= c1*(24*pi*r*(r + h)) + c2*(4*r*(24*r + 7*h));
vol..  pi*sqr(r)*h =e= V0;
dimR.. 8*r =l= D0;
dimH.. h   =l= D0;

Model CanDesign / obj, vol, dimR, dimH /;

* Starting point
r.l = min(D0/8, 0.5);
if (r.l <= 1e-6, r.l = 0.1);
h.l = V0/(pi*sqr(r.l));
if (h.l > D0, h.l = D0);

Solve CanDesign using NLP minimizing z;

Scalar ratio;
ratio = h.l / r.l;

Display "Optimal radius r", r.l,
        "Optimal height h", h.l,
        "Aspect ratio h/r", ratio,
        "Objective value", z.l;



