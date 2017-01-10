%==============================================================================
% This code is part of the Matlab-based toolbox
%  FAIR - Flexible Algorithms for Image Registration. 
% For details see 
% - https://github.com/C4IR and
% - http://www.siam.org/books/fa06/
%==============================================================================
% function pos = FAIRposition(varargin)
%
% computes a nice default location (position) for a FAIR figure
%
%==============================================================================

function pos = FAIRposition(varargin)

persistent theScreen

if isempty(theScreen),
  theScreen   = get(0,'screensize'); 
  theScreen(4) = theScreen(4) - 95;
end;

fig       = getValue('fig',        1,varargin{:});
increment = getValue('increment', 20,varargin{:});
position  = getValue('position',  [],varargin{:});

if ~isnumeric(fig),
    fig = fig.Number;
end;

if isempty(position),
  dx     = (fig-1)*increment;
  dy     = (fig-1)*increment;
  
  width  = getValue('width', min(floor(theScreen(3)),1200), varargin{:});
  width  = max(10,min(theScreen(3),width));
  height = getValue('height',min(floor(theScreen(4)), 800), varargin{:});
  height = max(10,min(theScreen(4),height));
  
  left   = getValue('left',  min(dx,theScreen(3)-width)+1,  varargin{:});
  left   = min(max(1,left),floor(0.95*theScreen(3)));
  bottom = getValue('bottom',theScreen(4)-height+1-min(dx,height),varargin{:});
  bottom = min(max(1,bottom),floor(0.95*theScreen(3)));
  
  pos = [1+left,bottom,width,height];
  return;
end;

if ~isnumeric(position), 
  if strcmp(position,'default'),
    pos = FAIRposition('fig',fig,...
      'width', 1200,...
      'height',800);
    return;
  end;
  
  keyboard
end;
  
if length(position) == 1,
  pos = FAIRposition('fig',fig,'height',position);
  return;
elseif length(position) == 4,
  pos = FAIRposition('fig',fig,...
    'left',  position(1),...
    'bottom',position(2),...
    'width', position(3),...
    'height',position(4));
  return;
end;

position
keyboard

%------------------------------------------------------------------------------

function value = getValue(name,default,varargin)
value  = default;
j = strcmp(name,varargin);
if isempty(j), return; end;
if all(j==0),  return; end;
value = varargin{max(find(j))+1};
%==============================================================================