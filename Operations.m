classdef Operations
% One-line description here, please.
%
%   Enumeration Operations
%
%   Example
%     % Retrieve an Operation from its name
%     op = Operations.fromName('FirstOp');
%     op = 
%       Operations enumeration
%         FirstOp
%
%     % Retrieve an Operation from its label
%     op = Operations.fromLabel('User-defined Operation')
%     op = 
%       Operations enumeration
%         UserOp
%
%   See also
%     newEnum

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2020-12-11,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE - BIA-BIBS.


%% Enumerates the different cases
enumeration
    FirstOp('First Operation');
    SecondOp('Second Operation');
    UserOp('User-Defined Operation');
end % end properties


%% Static methods
methods (Static)
    function res = allNames()
        % Returns a cell list with all enumeration names.
        mc = ?Operations;
        itemList = mc.EnumerationMemberList;
        nItems = length(itemList);
        res = cell(1, nItems);
        
        for i = 1:nItems
            % retrieve current enumeration item
            mitem = itemList(i);
            res{i} = mitem.Name;
        end
    end
    
    function res = fromName(name)
        % Identifies a Operations from its name.
        if nargin == 0 || ~ischar(name)
            error('requires a character array as input argument');
        end
        
        mc = ?Operations;
        itemList = mc.EnumerationMemberList;
        for i = 1:length(itemList)
            % retrieve current enumeration item
            mitem = itemList(i);
            item = Operations.(mitem.Name);
            if strcmpi(name, char(item))
                res = item;
                return;
            end
        end
        
        error('Unrecognized Operations name: %s', name);
    end
    
    function res = allLabels()
        % Returns a cell list with all enumeration names.
        mc = ?Operations;
        itemList = mc.EnumerationMemberList;
        nItems = length(itemList);
        res = cell(1, nItems);
        
        for i = 1:nItems
            % retrieve current enumeration item
            mitem = itemList(i);
            item = Operations.(mitem.Name);
            res{i} = item.Label;
        end
    end
    
    function res = fromLabel(label)
        % Identifies a Operations from its label.
        if nargin == 0 || ~ischar(label)
            error('requires a character array as input argument');
        end
        
        mc = ?Operations;
        itemList = mc.EnumerationMemberList;
        for i = 1:length(itemList)
            % retrieve current enumeration item
            mitem = itemList(i);
            item = Operations.(mitem.Name);
            if strcmpi(label, item.Label)
                res = item;
                return;
            end
        end
        
        error('Unrecognized Operations label: %s', label);
    end
end % end methods


%% Constructor
methods
    function obj = Operations(label, varargin)
        % Constructor for Operations class.
        obj.Label = label;
    end

end % end constructors


%% Properties
properties
    Label;
end % end properties

end % end classdef

