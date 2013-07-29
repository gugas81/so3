function [alphas, betas, gammas, varargout] = so3_sampling(L, N, varargin)
% so3_sampling - Compute sample positions
%
% Computes sample positions on SO(3) for various sampling methods.
%
% Default usage is given by
%
%   [alphas, betas, gammas] = so3_sampling(L, N, <options>)
%
% where L is the harmonic band-limit, N is the orientational band-limit,
% and alphas, betas and gammas specify sample positions. 
%
% Options consist of parameter type and value pairs.  Valid options
% include:
%  'Grid'            = { false  [return alpha, beta and gamma vectors (default)],
%                        true   [return alpha, beta and gamma grids] }
% 
% May optionally return total number of samples n, and number of alpha, beta
% and gamma samples nalpha, nbeta and ngamma, respectively, through usage
%
%   [alphas, betas, gammas, n, nalpha, nbeta, ngamma] = so3_sampling(L, N, <options>)
%
% Author: Jason McEwen (www.jasonmcewen.org)

% SO3 package to perform Wigner transforms
% Copyright (C) 2013  Jason McEwen
% See LICENSE.txt for license details

% Parse arguments.
p = inputParser;
p.addRequired('L', @isnumeric);          
p.addRequired('N', @isnumeric);          
p.addParamValue('Grid', false, @islogical);
p.parse(L, N, varargin{:});
args = p.Results;

% Computing sampling points.
[n, nalpha, nbeta, ngamma, alphas, betas, gammas] = so3_sampling_mex(L, N);

% Compute grids if requested.
if args.Grid
  [alphas, betas, gammas] = ndgrid(alphas, betas, gammas);
end

% Set optional outputs.
if nargout >= 4
  varargout(1) = {n};
end
if nargout >= 5
  varargout(2) = {nalphas};
end
if nargout >= 6
  varargout(3) = {nbetas};
end
if nargout >= 7
  varargout(4) = {ngammas};
end
