function k = menu_KD8071(xHeader, varargin)
 global Color_Menu
%=========================================================================
% Check input
%-------------------------------------------------------------------------
if nargin < 2,
    disp('MENU: No menu items to choose from.')
    k=0;
    return;
elseif nargin==2 && iscell(varargin{1}),
  ArgsIn = varargin{1}; % a cell array was passed in
else,
  ArgsIn = varargin;    % use the varargin cell array
end

%-------------------------------------------------------------------------
% Check computer type to see if we can use a GUI
%-------------------------------------------------------------------------
useGUI   = 1; % Assume we can use a GUI

if isunix,     % Unix?
    useGUI = length(getenv('DISPLAY')) > 0;
end % if

%-------------------------------------------------------------------------
% Create the appropriate menu
%-------------------------------------------------------------------------
if useGUI,
    % Create a GUI menu to aquire answer "k"
    k = local_GUImenu( xHeader, ArgsIn );
else,
    % Create an ascii menu to aquire answer "k"
    k = local_ASCIImenu( xHeader, ArgsIn );
end % if

%%#########################################################################
%   END   :  main function "menu"
%%#########################################################################

%%#########################################################################
%  BEGIN  :  local function local_ASCIImenu
%%#########################################################################
function k = local_ASCIImenu( xHeader, xcItems)

% local function to display an ascii-generated menu and return the user's
% selection from that menu as an index into the xcItems cell array

%-------------------------------------------------------------------------
% Calculate the number of items in the menu
%-------------------------------------------------------------------------
numItems = length(xcItems);

%-------------------------------------------------------------------------
% Continuous loop to redisplay menu until the user makes a valid choice
%-------------------------------------------------------------------------
while 1,
    % Display the header
    disp(' ')
    disp(['----- ',xHeader,' -----'])
    disp(' ')
    % Display items in a numbered list
    for n = 1 : numItems
        disp( [ '      ' int2str(n) ') ' xcItems{n} ] )
    end
    disp(' ')
    % Prompt for user input
    k = input('Select a menu number: ');
    % Check input:
    % 1) make sure k has a value
    if isempty(k), k = -1; end;
    % 2) make sure the value of k is valid
    if  (k < 1) || (k > numItems) ...
        || ~strcmp(class(k),'double') ...
        || ~isreal(k) || (isnan(k)) || isinf(k),
        % Failed a key test. Ask question again
        disp(' ')
        disp('Selection out of range. Try again.')
    else
        % Passed all tests, exit loop and return k
        return
    end % if k...
end % while 1

%%#########################################################################
%   END   :  local function local_ASCIImenu
%%#########################################################################

%%#########################################################################
%  BEGIN  :  local function local_GUImenu
%%#########################################################################
function k = local_GUImenu( xHeader, xcItems)
global Color_Menu
% local function to display a Handle Graphics menu and return the user's
% selection from that menu as an index into the xcItems cell array

%=========================================================================
% SET UP
%=========================================================================
% Set spacing and sizing parameters for the GUI elements
%-------------------------------------------------------------------------
MenuUnits   = 'points'; % units used for all HG objects
textPadding = [18 8];   % extra [Width Height] on uicontrols to pad text
uiGap       = 5;        % space between uicontrols
uiBorder    = 5;        % space between edge of figure and any uicontol
winTopGap   = 350;       % gap between top of screen and top of figure **
winLeftGap  = 25;       % gap between side of screen and side of figure **

% ** "figure" ==> viewable figure. You must allow space for the OS to add
% a title bar (aprx 42 points on Mac and Windows) and a window border
% (usu 2-6 points). Otherwise user cannot move the window.

%-------------------------------------------------------------------------
% Calculate the number of items in the menu
%-------------------------------------------------------------------------
numItems = length( xcItems );

%=========================================================================
% BUILD
%=========================================================================
% Create a generically-sized invisible figure window
%------------------------------------------------------------------------
menuFig = figure( 'Units'       ,MenuUnits, ...
                  'Visible'     ,'off', ...
                  'NumberTitle' ,'off', ...
                  'Name'        ,'', ...
                  'Resize'      ,'off', ...
                  'Colormap'    ,[], ...
                  'Menubar'     ,'none',...
                  'Toolbar' 	,'none',...
                  'WindowStyle' ,'modal',...
                  'CloseRequestFcn','set(gcbf,''userdata'',0)');

%------------------------------------------------------------------------
% Add generically-sized header text with same background color as figure
%------------------------------------------------------------------------
hText = uicontrol( ...
        'style'       ,'text', ...
        'string'      ,xHeader, ...
        'units'       ,MenuUnits, ...
        'Position'    ,[ 100 100 100 20 ], ...
        'Horizontal'  ,'center',...
        'BackGround'  ,get(menuFig,'Color'),...
        'FontSize'    ,12,...
        'FontName'    ,'Arial');

% Record extent of text string
maxsize = get( hText, 'Extent' );
textWide  = maxsize(3);
textHigh  = maxsize(4);

%------------------------------------------------------------------------
% Add generically-spaced buttons below the header text
%------------------------------------------------------------------------
% Loop to add buttons in reverse order (to automatically initialize numitems).
% Note that buttons may overlap, but are placed in correct position relative
% to each other. They will be resized and spaced evenly later on.

for idx = numItems : -1 : 1; % start from top of screen and go down
    n = numItems - idx + 1;  % start from 1st button and go to last
    % make a button
    hBtn(n) = uicontrol( ...
               'units'          ,MenuUnits, ...
               'position'       ,[uiBorder uiGap*idx textHigh textWide], ...
               'callback'       ,['set(gcf,''userdata'',',int2str(n),')'], ...
               'FontName'       ,'Arial',...
               'string'         ,xcItems{n} );
           
           if Color_Menu(n)==0
%             
             set(hBtn(n),'Foregroundcolor',[1 0 0]);
             set(hBtn(n),'FontWeight','bold');
           end
end % for

%=========================================================================
% TWEAK
%=========================================================================
% Calculate Optimal UIcontrol dimensions based on max text size
%------------------------------------------------------------------------
cAllExtents = get( hBtn, {'Extent'} );  % put all data in a cell array
AllExtents  = cat( 1, cAllExtents{:} ); % convert to an n x 3 matrix
maxsize     = max( AllExtents(:,3:4) ); % calculate the largest width & height
maxsize     = maxsize + textPadding;    % add some blank space around text
btnHigh     = maxsize(2);
btnWide     = maxsize(1);

%------------------------------------------------------------------------
% Retrieve screen dimensions (in correct units)
%------------------------------------------------------------------------
oldUnits = get(0,'Units');         % remember old units
set( 0, 'Units', MenuUnits );      % convert to desired units
screensize = get(0,'ScreenSize');  % record screensize
set( 0, 'Units',  oldUnits );      % convert back to old units

%------------------------------------------------------------------------
% How many rows and columns of buttons will fit in the screen?
% Note: vertical space for buttons is the critical dimension
% --window can't be moved up, but can be moved side-to-side
%------------------------------------------------------------------------
openSpace = screensize(4) - winTopGap - 2*uiBorder - textHigh;
numRows = min( floor( openSpace/(btnHigh + uiGap) ), numItems );
if numRows == 0; numRows = 1; end % Trivial case--but very safe to do
numCols = ceil( numItems/numRows );

%------------------------------------------------------------------------
% Resize figure to place it in top left of screen
%------------------------------------------------------------------------
% Calculate the window size needed to display all buttons
winHigh = numRows*(btnHigh + uiGap) + textHigh + 2*uiBorder;
winWide = numCols*(btnWide) + (numCols - 1)*uiGap + 2*uiBorder;

% Make sure the text header fits
if winWide < (2*uiBorder + textWide),
    winWide = 2*uiBorder + textWide;
end

% Determine final placement coordinates for bottom of figure window
bottom = screensize(4) - (winHigh + winTopGap);

% Set figure window position
set( menuFig, 'Position', [winLeftGap bottom winWide winHigh] );

%------------------------------------------------------------------------
% Size uicontrols to fit everyone in the window and see all text
%------------------------------------------------------------------------
% Calculate coordinates of bottom-left corner of all buttons
xPos = ( uiBorder + [0:numCols-1]'*( btnWide + uiGap )*ones(1,numRows) )';
xPos = xPos(1:numItems); % [ all 1st col; all 2nd col; ...; all nth col ]
yPos = ( uiBorder + [numRows-1:-1:0]'*( btnHigh + uiGap )*ones(1,numCols) );
yPos = yPos(1:numItems); % [ rows 1:m; rows 1:m; ...; rows 1:m ]

% Combine with desired button size to get a cell array of position vectors
allBtn   = ones(numItems,1);
uiPosMtx = [ xPos(:), yPos(:), btnWide*allBtn, btnHigh*allBtn ];
cUIPos   = num2cell( uiPosMtx( 1:numItems, : ), 2 );

% adjust all buttons
set( hBtn, {'Position'}, cUIPos );

%------------------------------------------------------------------------
% Align the Text and Buttons horizontally and distribute them vertically
%------------------------------------------------------------------------

% Calculate placement position of the Header
textWide = winWide - 2*uiBorder;

% Move Header text into correct position near the top of figure
set( hText, ...
     'Position', [ uiBorder winHigh-uiBorder-textHigh textWide textHigh ] );

%=========================================================================
% ACTIVATE
%=========================================================================
% Make figure visible
%------------------------------------------------------------------------
set( menuFig, 'Visible', 'on' );

%------------------------------------------------------------------------
% Wait for choice to be made (i.e UserData must be assigned)...
%------------------------------------------------------------------------
waitfor(gcf,'userdata')

%------------------------------------------------------------------------
% ...selection has been made. Assign k and delete the Menu figure
%------------------------------------------------------------------------
k = get(gcf,'userdata');
delete(menuFig)

%%#########################################################################
%   END   :  local function local_GUImenu
%%#########################################################################
