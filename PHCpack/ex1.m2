R = CC[a11,a12,a13,a21,a32];
m = {a11 - a12 - a13 - a32,
  a11*a12 + a11*a13 - a12*a13 + a12*a21 + a11*a32 - a13*a32,
  a11*a12*a13 + a12*a13*a21 + a11*a13*a32 + a13*a21*a32,
  a12 + a13 + a32, a12*a13 + a13*a32}
print m
