function x=randl(varargin)
%randl - Laplace distributed random numbers
%------------------------------------------------------------------------------
%SYNOPSIS       X=randl(N)
%                  Return an N-by-N matrix with entries drawn from a
%                  Laplace distribution with mean zero and variance one.
%
%               X=randl(M, N)  and  X=randl([M, N])
%                  Return an M-by-N matrix with entries drawn from a
%                  Laplace distribution with mean zero and variance one.
%
%               X=randl(M, N, P, ...)  and  X=randl([M, N, P, ...])
%                  Return a multidimensional matrix with entries drawn from a
%                  Laplace distribution with mean zero and variance one.
%
%               X=randl
%                  Return a scalar value drawn from a Laplace distribution
%                  with mean zero and variance one.
%
%
%SEE ALSO	rand, randn
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 2003 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: randl.m,v 1.2 2003/11/24 13:07:16 harna Exp $

if nargin==0
  y=rand;
  if y<0.5
    x=log(2*y)/sqrt(2);
  else
    x=-log(2-2*y)/sqrt(2);
  end
  return
end

arg=[];

for k=1:nargin
  arg=[arg varargin{k}];
end

y=rand(arg);
x=y;

x(y<0.5)=log(2*y(y<0.5))/sqrt(2);
x(y>=0.5)=-log(2-2*y(y>=0.5))/sqrt(2);