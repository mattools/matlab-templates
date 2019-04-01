function newClass(varargin)
%NEWCLASS Create a new file for editing a class
%
%   newClass(NEWCLASSNAME) opens the editor and pastes the content of a
%   user-defined template into the file NEWCLASSNAME.m.
%
%
%   References
%   Based on file 'tedit' from Peter Bodin.
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

switch nargin
    case 0
        edit
        warning('newClass:MissingArgument', ...
            'newClass without argument is the same as edit');
        return;
        
    case 1
        fname = varargin{:};
        edit(fname);
        
    otherwise
        error('too many input arguments');
        
end

% Matlab interface changed with 7.12.0, so we need to switch
if verLessThan('matlab','7.12.0') 
    try
        % Define the handle for the java commands:
        edhandle = com.mathworks.mlservices.MLEditorServices;
        
        % get editor active document
        doc = edhandle.builtinGetActiveDocument;
        
        % append template header
        text = parse(fname);
        edhandle.builtinAppendDocumentText(doc, text);
    catch ex
        rethrow(ex)
    end
else
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
            '%$FILENAME  One-line description here, please.'
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
            '    % Constructor for $filename class'
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
            datestr(now, 29)
            datestr(now, 10)
            'David Legland'
            'david.legland@inra.fr'
            'INRA - BIA-BIBS'};
        
        for k = 1:numel(repstr)
            template = strrep(template, repstr{k}, repwithstr{k});
        end
        out = sprintf('%s\n', template{:});
    end
end

