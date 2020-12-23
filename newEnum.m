function newEnum(varargin)
% Creates a new file for editing an Enumeration class.
%
%   newEnum(ENUMNAME)
%   opens the editor and pastes the content of a user-defined template into
%   the file ENUMNAME.m. 
%   Global variables of the template can be modified by editing the end of
%   the "newEnum" file.
%
%   Some static methods are implemented to retrieve enumeration items from
%   either their name, or by a more detailed label.
%
%   Example
%     % Retrieve an Operation from its name
%     % (equivalent to op1 = Operations.FirstOp)
%     op1 = Operations.fromName('FirstOp');
%     op1 = 
%       Operations enumeration
%         FirstOp
%
%     % Retrieve an Operation from its label
%     op2 = Operations.fromLabel('User-defined Operation')
%     op2 = 
%       Operations enumeration
%         UserOp
%
%
%
%   References
%   Based on file 'tedit' from Peter Bodin.
%
%   See also
%     newClass, newTest, Operations
 
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
            '    function res = allNames()'
            '        % Returns a cell list with all enumeration names.'
            '        mc = ?$filename;'
            '        itemList = mc.EnumerationMemberList;'
            '        nItems = length(itemList);'
            '        res = cell(1, nItems);'
            '        '
            '        for i = 1:nItems'
            '            % retrieve current enumeration item'
            '            mitem = itemList(i);'
            '            res{i} = mitem.Name;'
            '        end'
            '    end'
            '    '
            '    function res = fromName(name)'
            '        % Identifies a $filename from its name.'
            '        if nargin == 0 || ~ischar(name)'
            '            error(''requires a character array as input argument'');'
            '        end'
            '        '
            '        mc = ?$filename;'
            '        itemList = mc.EnumerationMemberList;'
            '        for i = 1:length(itemList)'
            '            % retrieve current enumeration item'
            '            mitem = itemList(i);'
            '            item = $filename.(mitem.Name);'
            '            if strcmpi(name, char(item))'
            '                res = item;'
            '                return;'
            '            end'
            '        end'
            '        '
            '        error(''Unrecognized $filename name: %s'', name);'
            '    end'
            '    '
            '    function res = allLabels()'
            '        % Returns a cell list with all enumeration names.'
            '        mc = ?$filename;'
            '        itemList = mc.EnumerationMemberList;'
            '        nItems = length(itemList);'
            '        res = cell(1, nItems);'
            '        '
            '        for i = 1:nItems'
            '            % retrieve current enumeration item'
            '            mitem = itemList(i);'
            '            item = $filename.(mitem.Name);'
            '            res{i} = item.Label;'
            '        end'
            '    end'
            '    '
            '    function res = fromLabel(label)'
            '        % Identifies a $filename from its label.'
            '        if nargin == 0 || ~ischar(label)'
            '            error(''requires a character array as input argument'');'
            '        end'
            '        '
            '        mc = ?$filename;'
            '        itemList = mc.EnumerationMemberList;'
            '        for i = 1:length(itemList)'
            '            % retrieve current enumeration item'
            '            mitem = itemList(i);'
            '            item = $filename.(mitem.Name);'
            '            if strcmpi(label, item.Label)'
            '                res = item;'
            '                return;'
            '            end'
            '        end'
            '        '
            '        error(''Unrecognized $filename label: %s'', label);'
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
