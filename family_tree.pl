% Assignment 8: Building a Family Tree in Prolog
% parent(Parent, Child). Names are lowercase atoms.
% This fictional family spans four generations.

male(john).
male(robert).
male(david).
male(james).
male(michael).
male(liam).

female(susan).
female(mary).
female(linda).
female(alice).
female(emma).
female(olivia).

parent(john, mary).
parent(susan, mary).
parent(john, robert).
parent(susan, robert).
parent(mary, alice).
parent(david, alice).
parent(mary, james).
parent(david, james).
parent(robert, emma).
parent(linda, emma).
parent(robert, michael).
parent(linda, michael).
parent(alice, olivia).
parent(james, liam).

% child(Child, Parent) reverses the arguments of parent/2.
child(Child, Parent) :-
    parent(Parent, Child).

% ancestor_at_depth(Ancestor, Descendant, Depth).
% Call with Depth bound to a positive integer.
% Base case: one parent link. Recursive case: reduce the depth.
ancestor_at_depth(X, Y, 1) :-
    parent(X, Y).
ancestor_at_depth(X, Y, N) :-
    N > 1,
    parent(X, Z),
    Next is N - 1,
    ancestor_at_depth(Z, Y, Next).

% Exactly two generations, using the recursive helper above.
grandparent(X, Y) :-
    ancestor_at_depth(X, Y, 2).

% Shared parent includes half-siblings. Bind names before testing inequality.
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% First cousins: their respective parents are siblings.
cousin(X, Y) :-
    parent(PX, X),
    parent(PY, Y),
    sibling(PX, PY),
    X \= Y.

% descendant(Descendant, Ancestor): one or more parent links.
% Termination assumes a finite family tree with no parent cycles.
descendant(D, A) :-
    parent(A, D).
descendant(D, A) :-
    parent(A, Child),
    descendant(D, Child).

% Raw queries can repeat answers when more than one proof exists.
% These convenience queries return sorted, duplicate-free lists.
% The person argument should be bound to a name.
children_of(Person, Children) :-
    findall(C, child(C, Person), Raw),
    sort(Raw, Children).

siblings_of(Person, Siblings) :-
    findall(S, sibling(Person, S), Raw),
    sort(Raw, Siblings).

descendants_of(Person, Descendants) :-
    findall(D, descendant(D, Person), Raw),
    sort(Raw, Descendants).

% Try: children_of(mary, Children).
% Try: siblings_of(alice, Siblings).
% Try: cousin(alice, emma).
% Try: grandparent(john, alice).
% Try: descendants_of(john, Descendants).
