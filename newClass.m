function newClass(varargin)
% Creates a new file for editing a class.
%
%   newClass(NEWCLASSNAME) opens the editor and pastes the content of a
%   user-defined template into the file NEWCLASSNAME.m.
%
%
%   References
%     Based on file 'tedit' from Peter Bodin.
%
%   See also
%     newEnum, newTest
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2011-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% check number of input arguments
if nargin == 0
    edit
    warning('newClass:NoInputArgument', ...
        'newClass without argument is the same as edit')
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
    text = parse(fname);
    editorObject.appendText(text);

catch ex
    rethrow(ex)
end

end

function out = parse(func)

template = { ...
    'classdef $filename < handle'
    '% One-line description here, please.'
    '%'
    '%   Class $filename'
    '%'
    '%   Example'
    '%   $filename'
    '%'
    '%   See also'
    '%'
    ''
    '% ------'
    '% Author: $author'
    '% e-mail: $mail'
    ['% Created: $date,    using Matlab ' version]
    '% Copyright $year $company.'
    ''
    ''
    '%% Properties'
    'properties'
    'end % end properties'
    ''
    ''
    '%% Constructor'
    'methods'
    '    function obj = $filename(varargin)'
    '        % Constructor for $filename class.'
    ''
    '    end'
    ''
    'end % end constructors'
    ''
    ''
    '%% Methods'
    'methods'
    'end % end methods'
    ''
    'end % end classdef'
    ''};

repstr = {...
    '$filename'
    '$FILENAME'
    '$date'
    '$year'
    '$author'
    '$mail'
    '$company'};

repwithstr = {...
    func
    upper(func)
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

