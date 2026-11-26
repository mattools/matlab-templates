function newTest(varargin)
% Create a new test case for existing function.
%
%   newTest(FUNNAME) opens the editor and pastes the content of a
%   user-defined template into the file test_FUNNAME.m.
%
%
%   References
%   Based on file 'tedit' from Peter Bodin.
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2011-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


% check number of input arguments
if nargin == 0
    edit
    warning('newTest:NoInputArgument', ...
        'newTest without argument is the same as edit')
    return;
end

if nargin > 1
    error('too many input arguments')
end

% extract the name and the path of the function to edit
fname = varargin{:};
[fpath, fname] = fileparts(fname);
if isempty(fpath)
    fpath = pwd;
end

% opens a new document in the editor
edit(fullfile(fpath, fname));

try
    % get editor active document
    editorObject = matlab.desktop.editor.getActive;

    % append template header
    text = parse(funName);
    editorObject.appendText(text);

catch ex
    rethrow(ex)
end

end

function out = parse(funName)

template = { ...
    'function tests = $filename'
    '% Test suite for the file $funname.'
    '%'
    '%   Test suite for the file $funname'
    '%'
    '%   Example'
    '%   $filename'
    '%'
    '%   See also'
    '%     $funname'
    ''
    '% ------'
    '% Author: $author'
    '% e-mail: $mail'
    ['% Created: $date,    using Matlab ' version]
    '% Copyright $year $company.'
    ''
    'tests = functiontests(localfunctions);'
    ''
    'function test_Simple(testCase) %#ok<*DEFNU>'
    '% Test call of function without argument.'
    '$funname();'
    'value = 10;'
    'assertEqual(testCase, value, 10);'
    ''
    ''};

repstr = {...
    '$filename'
    '$FILENAME'
    '$funname'
    '$date'
    '$year'
    '$author'
    '$mail'
    '$company'};

testName = ['test_' funName];

repwithstr = {...
    testName
    upper(testName)
    funName
    char(datetime('now', 'format', 'yyyy-MM-dd'))
    char(datetime('now', 'format', 'yyyy'))
    'David Legland'
    'david.legland@inrae.fr'
    'INRAE - BIA-BIBS'};

for k = 1:numel(repstr)
    template = strrep(template, repstr{k}, repwithstr{k});
end
out = sprintf('%s\n', template{:});
end
