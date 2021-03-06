{* 
PieriFirstSum

Implement the first sum in the quantum Pieri rule 
(basically the classical formula except partitions must
stay within bounding rectangle)

Format for monomials:
{coefficient, integer for power of q, partition as a list of integers}

Inputs:
1. a monomial whose partition has only one part
2. a monomial whose partition is arbitrary 
*}

{*
Ideas for future work: 

If memory is a problem, try iterating over
the solutions instead of recursing
*}

{* 
First try: use the Polyhedra package to enumerate
the possible mu's
*}


loadPackage("Polyhedra");

pieriFirstSum = (p,l,r,L) -> (
    M1:=matrix apply(r+1, i -> apply(r+1,j -> if i==j then 1 else 0));
    v1:=matrix apply(r+1, i -> if i==0 then {l} else if i<=#L then {L_(i-1)} else {0});
    M2:=matrix apply(r+1, i -> apply(r+1,j -> if i==j then -1 else 0));
    v2:=matrix apply(r+1, i -> if i<#L then {-1*(L_i)} else {0});
    M:=M1||M2;
    v:=v1||v2;
    N:=matrix {apply(r+1, i -> 1)};
    w:=matrix {{sum(L)+p}};
    P:=intersection(M,v,N,w);
    latticePoints(P)
);



{*
Examples: 
time pieriFirstSum(4,6,4,{4,2,2,1})
-- used 0.171507 seconds
{{5, 4, 2, 1, 1}, {6, 4, 2, 1, 0}, {6, 3, 2, 1, 1}, {5, 4, 2, 2, 0}, {6, 3, 2, 2, 0}, {4, 4, 2, 2, 1}, {5, 3, 2, 2, 1}, {6, 2, 2, 2, 1}}
time pieriFirstSum(10,20,10,{9,8,8,6,4,4,3,2})
--print toString apply(oo, i -> flatten entries i) << endl
-- used 6.08612 seconds
{{18, 8, 8, 6, 4, 4, 4, 2, 0, 0, 0}, {19, 8, 8, 6, 4, 4, 3, 2, 0, 0, 0}, {17, 8, 8, 6, 4, 4, 4, 2, 1, 0, 0}, {18, 8, 8, 6, 4, 4, 3, 2, 1, 0, 0}, {16, 8, 8, 6, 4, 4, 4, 2, 2, 0, 0}, {17, 8, 8, 6, 4, 4, 3, 2, 2, 0, 0}, {17, 8, 8, 7, 4, 4, 4, 2, 0, 0, 0}, {18, 8, 8, 7, 4, 4, 3, 2, 0, 0, 0}, {16, 8, 8, 7, 4, 4, 4, 2, 1, 0, 0}, {17, 8, 8, 7, 4, 4, 3, 2, 1, 0, 0}, {15, 8, 8, 7, 4, 4, 4, 2, 2, 0, 0}, {16, 8, 8, 7, 4, 4, 3, 2, 2, 0, 0}, {16, 8, 8, 8, 4, 4, 4, 2, 0, 0, 0}, {17, 8, 8, 8, 4, 4, 3, 2, 0, 0, 0}, {15, 8, 8, 8, 4, 4, 4, 2, 1, 0, 0}, {16, 8, 8, 8, 4, 4, 3, 2, 1, 0, 0}, {14, 8, 8, 8, 4, 4, 4, 2, 2, 0, 0}, {15, 8, 8, 8, 4, 4, 3, 2, 2, 0, 0}, {17, 8, 8, 6, 4, 4, 4, 3, 0, 0, 0}, {18, 8, 8, 6, 4, 4, 3, 3, 0, 0, 0}, {16, 8, 8, 6, 4, 4, 4, 3, 1, 0, 0}, {17, 8, 8, 6, 4, 4, 3, 3, 1, 0, 0}, {15, 8, 8, 6, 4, 4, 4, 3, 2, 0, 0}, {16, 8, 8, 6, 4, 4, 3, 3, 2, 0, 0}, {16, 8, 8, 7, 4, 4, 4, 3, 0, 0, 0}, {17, 8, 8, 7, 4, 4, 3, 3, 0, 0, 0}, {15, 8, 8, 7, 4, 4, 4, 3, 1, 0, 0}, {16, 8, 8, 7, 4, 4, 3, 3, 1, 0, 0}, {14, 8, 8, 7, 4, 4, 4, 3, 2, 0, 0}, {15, 8, 8, 7, 4, 4, 3, 3, 2, 0, 0}, {15, 8, 8, 8, 4, 4, 4, 3, 0, 0, 0}, {16, 8, 8, 8, 4, 4, 3, 3, 0, 0, 0}, {14, 8, 8, 8, 4, 4, 4, 3, 1, 0, 0}, {15, 8, 8, 8, 4, 4, 3, 3, 1, 0, 0}, {13, 8, 8, 8, 4, 4, 4, 3, 2, 0, 0}, {14, 8, 8, 8, 4, 4, 3, 3, 2, 0, 0}, {17, 8, 8, 6, 5, 4, 4, 2, 0, 0, 0}, {18, 8, 8, 6, 5, 4, 3, 2, 0, 0, 0}, {16, 8, 8, 6, 5, 4, 4, 2, 1, 0, 0}, {17, 8, 8, 6, 5, 4, 3, 2, 1, 0, 0}, {15, 8, 8, 6, 5, 4, 4, 2, 2, 0, 0}, {16, 8, 8, 6, 5, 4, 3, 2, 2, 0, 0}, {16, 8, 8, 7, 5, 4, 4, 2, 0, 0, 0}, {17, 8, 8, 7, 5, 4, 3, 2, 0, 0, 0}, {15, 8, 8, 7, 5, 4, 4, 2, 1, 0, 0}, {16, 8, 8, 7, 5, 4, 3, 2, 1, 0, 0}, {14, 8, 8, 7, 5, 4, 4, 2, 2, 0, 0}, {15, 8, 8, 7, 5, 4, 3, 2, 2, 0, 0}, {15, 8, 8, 8, 5, 4, 4, 2, 0, 0, 0}, {16, 8, 8, 8, 5, 4, 3, 2, 0, 0, 0}, {14, 8, 8, 8, 5, 4, 4, 2, 1, 0, 0}, {15, 8, 8, 8, 5, 4, 3, 2, 1, 0, 0}, {13, 8, 8, 8, 5, 4, 4, 2, 2, 0, 0}, {14, 8, 8, 8, 5, 4, 3, 2, 2, 0, 0}, {16, 8, 8, 6, 5, 4, 4, 3, 0, 0, 0}, {17, 8, 8, 6, 5, 4, 3, 3, 0, 0, 0}, {15, 8, 8, 6, 5, 4, 4, 3, 1, 0, 0}, {16, 8, 8, 6, 5, 4, 3, 3, 1, 0, 0}, {14, 8, 8, 6, 5, 4, 4, 3, 2, 0, 0}, {15, 8, 8, 6, 5, 4, 3, 3, 2, 0, 0}, {15, 8, 8, 7, 5, 4, 4, 3, 0, 0, 0}, {16, 8, 8, 7, 5, 4, 3, 3, 0, 0, 0}, {14, 8, 8, 7, 5, 4, 4, 3, 1, 0, 0}, {15, 8, 8, 7, 5, 4, 3, 3, 1, 0, 0}, {13, 8, 8, 7, 5, 4, 4, 3, 2, 0, 0}, {14, 8, 8, 7, 5, 4, 3, 3, 2, 0, 0}, {14, 8, 8, 8, 5, 4, 4, 3, 0, 0, 0}, {15, 8, 8, 8, 5, 4, 3, 3, 0, 0, 0}, {13, 8, 8, 8, 5, 4, 4, 3, 1, 0, 0}, {14, 8, 8, 8, 5, 4, 3, 3, 1, 0, 0}, {12, 8, 8, 8, 5, 4, 4, 3, 2, 0, 0}, {13, 8, 8, 8, 5, 4, 3, 3, 2, 0, 0}, {16, 8, 8, 6, 6, 4, 4, 2, 0, 0, 0}, {17, 8, 8, 6, 6, 4, 3, 2, 0, 0, 0}, {15, 8, 8, 6, 6, 4, 4, 2, 1, 0, 0}, {16, 8, 8, 6, 6, 4, 3, 2, 1, 0, 0}, {14, 8, 8, 6, 6, 4, 4, 2, 2, 0, 0}, {15, 8, 8, 6, 6, 4, 3, 2, 2, 0, 0}, {15, 8, 8, 7, 6, 4, 4, 2, 0, 0, 0}, {16, 8, 8, 7, 6, 4, 3, 2, 0, 0, 0}, {14, 8, 8, 7, 6, 4, 4, 2, 1, 0, 0}, {15, 8, 8, 7, 6, 4, 3, 2, 1, 0, 0}, {13, 8, 8, 7, 6, 4, 4, 2, 2, 0, 0}, {14, 8, 8, 7, 6, 4, 3, 2, 2, 0, 0}, {14, 8, 8, 8, 6, 4, 4, 2, 0, 0, 0}, {15, 8, 8, 8, 6, 4, 3, 2, 0, 0, 0}, {13, 8, 8, 8, 6, 4, 4, 2, 1, 0, 0}, {14, 8, 8, 8, 6, 4, 3, 2, 1, 0, 0}, {12, 8, 8, 8, 6, 4, 4, 2, 2, 0, 0}, {13, 8, 8, 8, 6, 4, 3, 2, 2, 0, 0}, {15, 8, 8, 6, 6, 4, 4, 3, 0, 0, 0}, {16, 8, 8, 6, 6, 4, 3, 3, 0, 0, 0}, {14, 8, 8, 6, 6, 4, 4, 3, 1, 0, 0}, {15, 8, 8, 6, 6, 4, 3, 3, 1, 0, 0}, {13, 8, 8, 6, 6, 4, 4, 3, 2, 0, 0}, {14, 8, 8, 6, 6, 4, 3, 3, 2, 0, 0}, {14, 8, 8, 7, 6, 4, 4, 3, 0, 0, 0}, {15, 8, 8, 7, 6, 4, 3, 3, 0, 0, 0}, {13, 8, 8, 7, 6, 4, 4, 3, 1, 0, 0}, {14, 8, 8, 7, 6, 4, 3, 3, 1, 0, 0}, {12, 8, 8, 7, 6, 4, 4, 3, 2, 0, 0}, {13, 8, 8, 7, 6, 4, 3, 3, 2, 0, 0}, {13, 8, 8, 8, 6, 4, 4, 3, 0, 0, 0}, {14, 8, 8, 8, 6, 4, 3, 3, 0, 0, 0}, {12, 8, 8, 8, 6, 4, 4, 3, 1, 0, 0}, {13, 8, 8, 8, 6, 4, 3, 3, 1, 0, 0}, {11, 8, 8, 8, 6, 4, 4, 3, 2, 0, 0}, {12, 8, 8, 8, 6, 4, 3, 3, 2, 0, 0}, {17, 9, 8, 6, 4, 4, 4, 2, 0, 0, 0}, {18, 9, 8, 6, 4, 4, 3, 2, 0, 0, 0}, {16, 9, 8, 6, 4, 4, 4, 2, 1, 0, 0}, {17, 9, 8, 6, 4, 4, 3, 2, 1, 0, 0}, {15, 9, 8, 6, 4, 4, 4, 2, 2, 0, 0}, {16, 9, 8, 6, 4, 4, 3, 2, 2, 0, 0}, {16, 9, 8, 7, 4, 4, 4, 2, 0, 0, 0}, {17, 9, 8, 7, 4, 4, 3, 2, 0, 0, 0}, {15, 9, 8, 7, 4, 4, 4, 2, 1, 0, 0}, {16, 9, 8, 7, 4, 4, 3, 2, 1, 0, 0}, {14, 9, 8, 7, 4, 4, 4, 2, 2, 0, 0}, {15, 9, 8, 7, 4, 4, 3, 2, 2, 0, 0}, {15, 9, 8, 8, 4, 4, 4, 2, 0, 0, 0}, {16, 9, 8, 8, 4, 4, 3, 2, 0, 0, 0}, {14, 9, 8, 8, 4, 4, 4, 2, 1, 0, 0}, {15, 9, 8, 8, 4, 4, 3, 2, 1, 0, 0}, {13, 9, 8, 8, 4, 4, 4, 2, 2, 0, 0}, {14, 9, 8, 8, 4, 4, 3, 2, 2, 0, 0}, {16, 9, 8, 6, 4, 4, 4, 3, 0, 0, 0}, {17, 9, 8, 6, 4, 4, 3, 3, 0, 0, 0}, {15, 9, 8, 6, 4, 4, 4, 3, 1, 0, 0}, {16, 9, 8, 6, 4, 4, 3, 3, 1, 0, 0}, {14, 9, 8, 6, 4, 4, 4, 3, 2, 0, 0}, {15, 9, 8, 6, 4, 4, 3, 3, 2, 0, 0}, {15, 9, 8, 7, 4, 4, 4, 3, 0, 0, 0}, {16, 9, 8, 7, 4, 4, 3, 3, 0, 0, 0}, {14, 9, 8, 7, 4, 4, 4, 3, 1, 0, 0}, {15, 9, 8, 7, 4, 4, 3, 3, 1, 0, 0}, {13, 9, 8, 7, 4, 4, 4, 3, 2, 0, 0}, {14, 9, 8, 7, 4, 4, 3, 3, 2, 0, 0}, {14, 9, 8, 8, 4, 4, 4, 3, 0, 0, 0}, {15, 9, 8, 8, 4, 4, 3, 3, 0, 0, 0}, {13, 9, 8, 8, 4, 4, 4, 3, 1, 0, 0}, {14, 9, 8, 8, 4, 4, 3, 3, 1, 0, 0}, {12, 9, 8, 8, 4, 4, 4, 3, 2, 0, 0}, {13, 9, 8, 8, 4, 4, 3, 3, 2, 0, 0}, {16, 9, 8, 6, 5, 4, 4, 2, 0, 0, 0}, {17, 9, 8, 6, 5, 4, 3, 2, 0, 0, 0}, {15, 9, 8, 6, 5, 4, 4, 2, 1, 0, 0}, {16, 9, 8, 6, 5, 4, 3, 2, 1, 0, 0}, {14, 9, 8, 6, 5, 4, 4, 2, 2, 0, 0}, {15, 9, 8, 6, 5, 4, 3, 2, 2, 0, 0}, {15, 9, 8, 7, 5, 4, 4, 2, 0, 0, 0}, {16, 9, 8, 7, 5, 4, 3, 2, 0, 0, 0}, {14, 9, 8, 7, 5, 4, 4, 2, 1, 0, 0}, {15, 9, 8, 7, 5, 4, 3, 2, 1, 0, 0}, {13, 9, 8, 7, 5, 4, 4, 2, 2, 0, 0}, {14, 9, 8, 7, 5, 4, 3, 2, 2, 0, 0}, {14, 9, 8, 8, 5, 4, 4, 2, 0, 0, 0}, {15, 9, 8, 8, 5, 4, 3, 2, 0, 0, 0}, {13, 9, 8, 8, 5, 4, 4, 2, 1, 0, 0}, {14, 9, 8, 8, 5, 4, 3, 2, 1, 0, 0}, {12, 9, 8, 8, 5, 4, 4, 2, 2, 0, 0}, {13, 9, 8, 8, 5, 4, 3, 2, 2, 0, 0}, {15, 9, 8, 6, 5, 4, 4, 3, 0, 0, 0}, {16, 9, 8, 6, 5, 4, 3, 3, 0, 0, 0}, {14, 9, 8, 6, 5, 4, 4, 3, 1, 0, 0}, {15, 9, 8, 6, 5, 4, 3, 3, 1, 0, 0}, {13, 9, 8, 6, 5, 4, 4, 3, 2, 0, 0}, {14, 9, 8, 6, 5, 4, 3, 3, 2, 0, 0}, {14, 9, 8, 7, 5, 4, 4, 3, 0, 0, 0}, {15, 9, 8, 7, 5, 4, 3, 3, 0, 0, 0}, {13, 9, 8, 7, 5, 4, 4, 3, 1, 0, 0}, {14, 9, 8, 7, 5, 4, 3, 3, 1, 0, 0}, {12, 9, 8, 7, 5, 4, 4, 3, 2, 0, 0}, {13, 9, 8, 7, 5, 4, 3, 3, 2, 0, 0}, {13, 9, 8, 8, 5, 4, 4, 3, 0, 0, 0}, {14, 9, 8, 8, 5, 4, 3, 3, 0, 0, 0}, {12, 9, 8, 8, 5, 4, 4, 3, 1, 0, 0}, {13, 9, 8, 8, 5, 4, 3, 3, 1, 0, 0}, {11, 9, 8, 8, 5, 4, 4, 3, 2, 0, 0}, {12, 9, 8, 8, 5, 4, 3, 3, 2, 0, 0}, {15, 9, 8, 6, 6, 4, 4, 2, 0, 0, 0}, {16, 9, 8, 6, 6, 4, 3, 2, 0, 0, 0}, {14, 9, 8, 6, 6, 4, 4, 2, 1, 0, 0}, {15, 9, 8, 6, 6, 4, 3, 2, 1, 0, 0}, {13, 9, 8, 6, 6, 4, 4, 2, 2, 0, 0}, {14, 9, 8, 6, 6, 4, 3, 2, 2, 0, 0}, {14, 9, 8, 7, 6, 4, 4, 2, 0, 0, 0}, {15, 9, 8, 7, 6, 4, 3, 2, 0, 0, 0}, {13, 9, 8, 7, 6, 4, 4, 2, 1, 0, 0}, {14, 9, 8, 7, 6, 4, 3, 2, 1, 0, 0}, {12, 9, 8, 7, 6, 4, 4, 2, 2, 0, 0}, {13, 9, 8, 7, 6, 4, 3, 2, 2, 0, 0}, {13, 9, 8, 8, 6, 4, 4, 2, 0, 0, 0}, {14, 9, 8, 8, 6, 4, 3, 2, 0, 0, 0}, {12, 9, 8, 8, 6, 4, 4, 2, 1, 0, 0}, {13, 9, 8, 8, 6, 4, 3, 2, 1, 0, 0}, {11, 9, 8, 8, 6, 4, 4, 2, 2, 0, 0}, {12, 9, 8, 8, 6, 4, 3, 2, 2, 0, 0}, {14, 9, 8, 6, 6, 4, 4, 3, 0, 0, 0}, {15, 9, 8, 6, 6, 4, 3, 3, 0, 0, 0}, {13, 9, 8, 6, 6, 4, 4, 3, 1, 0, 0}, {14, 9, 8, 6, 6, 4, 3, 3, 1, 0, 0}, {12, 9, 8, 6, 6, 4, 4, 3, 2, 0, 0}, {13, 9, 8, 6, 6, 4, 3, 3, 2, 0, 0}, {13, 9, 8, 7, 6, 4, 4, 3, 0, 0, 0}, {14, 9, 8, 7, 6, 4, 3, 3, 0, 0, 0}, {12, 9, 8, 7, 6, 4, 4, 3, 1, 0, 0}, {13, 9, 8, 7, 6, 4, 3, 3, 1, 0, 0}, {11, 9, 8, 7, 6, 4, 4, 3, 2, 0, 0}, {12, 9, 8, 7, 6, 4, 3, 3, 2, 0, 0}, {12, 9, 8, 8, 6, 4, 4, 3, 0, 0, 0}, {13, 9, 8, 8, 6, 4, 3, 3, 0, 0, 0}, {11, 9, 8, 8, 6, 4, 4, 3, 1, 0, 0}, {12, 9, 8, 8, 6, 4, 3, 3, 1, 0, 0}, {10, 9, 8, 8, 6, 4, 4, 3, 2, 0, 0}, {11, 9, 8, 8, 6, 4, 3, 3, 2, 0, 0}}

*}

removeTrailingZeroes = (L) -> (delete(0,L))



{*Second try: 

A recursive function for the first term in quantum Pieri
For each allowed of mu_1, compute the possible 
diagrams with the new bounding rectangle of width
lambda_1 and adding p-(mu_1-lambda_1) boxes
*}


pieritest = (p, l, r, yt) -> (
    --while #yt < r+1 do yt=append(yt,0);
    --<< "p,l,r,yt " << toString (p,l,r,yt) << endl;
    if #yt == 0 then (
	return {{p}}
    );
    if r == 0 then (
        return {{yt#0+p}}	
    );
    b:=0;
    if #yt==r+1 then b=yt#r;
    ilist := reverse(toList(max(0,p-yt#0+b)..min(p,l-yt#0)));
    --<< "our ilist: " << toString ilist << endl;
    sublist := apply(ilist, i -> (
        M :=  pieritest(p-i,yt#0,r-1,drop(yt,1));
	--<< "M : " << toString M << endl;
	apply(M,a -> prepend(yt#0+i,a))
	--<< "x : " << toString x << endl;
	--x
    ));
    return flatten sublist
)

{*
time pieritest(4,6,5,{4,2,2,1});
-- used 0.000229 seconds
time pieritest(10,20,10,{9,8,8,6,4,4,3,2,0});
-- used 0.004343 seconds

Additional test:
pieritest(1,2,1,{2,2}) should be {}
*}


