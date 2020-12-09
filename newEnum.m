function newEnum(varargin)
% Creates a new file for editing an enumeration class.
%
%   newEnum(ENUMNAME)
%   opens the editor and pastes the content of a user-defined template into
%   the file ENUMNAME.m. 
%
%   Example
%   newEnum
%
%   References
%   Based on file 'tedit' from Peter Bodin.
%
%   See also
%     newClass, newTest
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-12-09,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.
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
            'classdef $filename'
            '% One-line description here, please.'
            '%'
            '%   Enumeration $filename'
            '%'
            '%   Example'
            '%     $filename'
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
            '%% Enumerates the different cases'
            'enumeration'
            '    First(''First item'');'
            '    Second(''Second item'');'
            'end % end properties'
            ''
            ''
            '%% Static methods'
            'methods (Static)'
            '    function res = parse(label)'
            '        % Identifies $filename from a char array.'
            '        if nargin == 0 || ~ischar(label)'
            '            error(''requires a character array as input argument'');'
            '        end'
            '        '
            '        mc = ?$filename;'
            '        itemList = mc.EnumerationMemberList;'
            '        for i = 1:length(itemList)'
            '            mitem = itemList(i);'
            '            item = $filename.(mitem.Name);'
            '            if strcmpi(label, item.Label)'
            '                res = item;'
            '                return;'
            '            end'
            '            error(''Unrecognized $filename label: %s'', label);'
            '        end'
            '    end'
            'end % end methods'
            ''
            ''
            '%% Constructor'
            'methods'
            '    function obj = $filename(label, varargin)'
            '        % Constructor for $filename class.'
            '        obj.Label = label;'
            '    end'
            ''
            'end % end constructors'
            ''
            ''
            '%% Properties'
            'properties'
            '    Label;'
            'end % end properties'
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
            'david.legland@inrae.fr'
            'INRAE - BIA-BIBS'};
        
        for k = 1:numel(repstr)
            template = strrep(template, repstr{k}, repwithstr{k});
        end
        out = sprintf('%s\n', template{:});
    end
end
